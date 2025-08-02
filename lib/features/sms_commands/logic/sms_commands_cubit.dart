import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/config_service.dart';
import '../../../../core/services/local_storage_service.dart';
import '../models/category.dart';
import '../models/service_provider.dart';
import '../models/action_item.dart';
import 'sms_commands_state.dart';

class SmsCommandsCubit extends Cubit<SmsCommandsState> {
  final ConfigService _configService;
  final LocalStorageService _localStorageService;

  // Store form values per provider
  final Map<String, Map<String, String>> _providerFormValues = {};

  SmsCommandsCubit(this._configService, this._localStorageService)
    : super(const SmsCommandsInitial());

  Future<void> loadCategories() async {
    emit(const SmsCommandsLoading());

    try {
      final categories = await _configService.fetchCategories();
      emit(SmsCommandsLoaded(categories: categories));
    } catch (e) {
      emit(SmsCommandsError(e.toString()));
    }
  }

  void selectCategory(Category category) {
    if (state is SmsCommandsLoaded) {
      final currentState = state as SmsCommandsLoaded;
      emit(
        currentState.copyWith(
          selectedCategory: category,
          selectedProvider: null,
          selectedAction: null,
          formValues: const {},
        ),
      );
    }
  }

  Future<void> selectProvider(ServiceProvider provider) async {
    if (state is SmsCommandsLoaded) {
      final currentState = state as SmsCommandsLoaded;

      // Load saved form values for this provider
      Map<String, String> savedValues = _providerFormValues[provider.id] ?? {};

      // If not in memory, try to load from persistent storage
      if (savedValues.isEmpty) {
        savedValues = await _loadProviderFormValues(provider.id);
        _providerFormValues[provider.id] = savedValues;
      }

      emit(
        currentState.copyWith(
          selectedProvider: provider,
          selectedAction: null,
          formValues: savedValues,
        ),
      );
    }
  }

  void selectAction(ActionItem action) {
    if (state is SmsCommandsLoaded) {
      final currentState = state as SmsCommandsLoaded;

      // Keep existing form values when selecting action
      emit(currentState.copyWith(selectedAction: action));
    }
  }

  void updateFormValue(String fieldId, String value) async {
    if (state is SmsCommandsLoaded) {
      final currentState = state as SmsCommandsLoaded;
      final updatedValues = Map<String, String>.from(currentState.formValues);
      updatedValues[fieldId] = value;

      // Save to provider-specific storage
      if (currentState.selectedProvider != null) {
        final providerId = currentState.selectedProvider!.id;
        _providerFormValues[providerId] = updatedValues;

        // Also save to persistent storage
        await _saveProviderFormValues(providerId, updatedValues);
      }

      emit(currentState.copyWith(formValues: updatedValues));
    }
  }

  void clearForm() {
    if (state is SmsCommandsLoaded) {
      final currentState = state as SmsCommandsLoaded;
      emit(currentState.copyWith(formValues: const {}));
    }
  }

  void clearProviderFormValues(String providerId) {
    _providerFormValues.remove(providerId);
    _localStorageService.remove('provider_form_$providerId');
  }

  Future<void> _saveProviderFormValues(
    String providerId,
    Map<String, String> values,
  ) async {
    try {
      await _localStorageService.setString(
        'provider_form_$providerId',
        _encodeFormValues(values),
      );
    } catch (e) {
      print('Error saving form values: $e');
    }
  }

  Future<Map<String, String>> _loadProviderFormValues(String providerId) async {
    try {
      final savedData = await _localStorageService.getString(
        'provider_form_$providerId',
      );
      if (savedData != null) {
        return _decodeFormValues(savedData);
      }
    } catch (e) {
      print('Error loading form values: $e');
    }
    return {};
  }

  String _encodeFormValues(Map<String, String> values) {
    return values.entries.map((e) => '${e.key}:${e.value}').join('|');
  }

  Map<String, String> _decodeFormValues(String encoded) {
    final Map<String, String> result = {};
    final pairs = encoded.split('|');
    for (final pair in pairs) {
      final parts = pair.split(':');
      if (parts.length == 2) {
        result[parts[0]] = parts[1];
      }
    }
    return result;
  }

  Future<bool> sendSms() async {
    if (state is SmsCommandsLoaded) {
      final currentState = state as SmsCommandsLoaded;
      final selectedAction = currentState.selectedAction;
      final formValues = currentState.formValues;

      if (selectedAction == null) {
        print('No action selected');
        return false;
      }

      try {
        // Generate SMS message from template
        String message = selectedAction.template;
        formValues.forEach((key, value) {
          message = message.replaceAll('{$key}', value);
        });

        print('Generated SMS message: $message');
        print('SMS Number: ${selectedAction.smsNumber}');

        // Create SMS URL
        final uri = Uri(
          scheme: 'sms',
          path: selectedAction.smsNumber,
          queryParameters: {'body': message},
        );

        print('SMS URI: $uri');

        // Launch SMS app
        final launched = await launchUrl(uri);
        print('SMS app launched: $launched');
        return launched;
      } catch (e) {
        print('Error sending SMS: $e');
        return false;
      }
    }
    return false;
  }
}
