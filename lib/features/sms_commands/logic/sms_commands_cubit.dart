import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/config_service.dart';
import '../models/category.dart';
import '../models/service_provider.dart';
import '../models/action_item.dart';
import 'sms_commands_state.dart';

class SmsCommandsCubit extends Cubit<SmsCommandsState> {
  final ConfigService _configService;

  SmsCommandsCubit(this._configService) : super(const SmsCommandsInitial());

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

  void selectProvider(ServiceProvider provider) {
    if (state is SmsCommandsLoaded) {
      final currentState = state as SmsCommandsLoaded;
      emit(
        currentState.copyWith(
          selectedProvider: provider,
          selectedAction: null,
          formValues: const {},
        ),
      );
    }
  }

  void selectAction(ActionItem action) {
    if (state is SmsCommandsLoaded) {
      final currentState = state as SmsCommandsLoaded;
      emit(currentState.copyWith(selectedAction: action, formValues: const {}));
    }
  }

  void updateFormValue(String fieldId, String value) {
    if (state is SmsCommandsLoaded) {
      final currentState = state as SmsCommandsLoaded;
      final updatedValues = Map<String, String>.from(currentState.formValues);
      updatedValues[fieldId] = value;
      emit(currentState.copyWith(formValues: updatedValues));
    }
  }

  void clearForm() {
    if (state is SmsCommandsLoaded) {
      final currentState = state as SmsCommandsLoaded;
      emit(currentState.copyWith(formValues: const {}));
    }
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
