// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SMS Commands';

  @override
  String get selectCategory => 'Select a Service Category';

  @override
  String get selectCategoryDescription => 'Choose from banking, telecom, and government services';

  @override
  String get selectProvider => 'Select a Service Provider';

  @override
  String get selectProviderDescription => 'Choose from available service providers';

  @override
  String get fillForm => 'Fill the Form';

  @override
  String get fillFormDescription => 'Complete the form below to generate your SMS';

  @override
  String get smsPreview => 'SMS Preview';

  @override
  String get loadingServices => 'Loading services...';

  @override
  String get loadingProviders => 'Loading providers...';

  @override
  String get noCategorySelected => 'No category selected';

  @override
  String get noCategorySelectedDescription => 'Please go back and select a category first';

  @override
  String get goBack => 'Go Back';

  @override
  String get retry => 'Retry';

  @override
  String get error => 'Error';

  @override
  String get unknownState => 'Unknown state';

  @override
  String get noActionSelected => 'No action selected';

  @override
  String get sendSms => 'Send SMS';

  @override
  String get smsAppOpenedSuccess => 'SMS app opened successfully!';

  @override
  String get smsAppFailed => 'Failed to open SMS app';

  @override
  String get about => 'About';

  @override
  String get aboutDescription => 'Generate SMS commands for various Libyan service providers. Select a category, provider, and action to create your SMS.';

  @override
  String get ok => 'OK';

  @override
  String get providers => 'providers';

  @override
  String get actions => 'actions';

  @override
  String enterField(String field) {
    return 'Enter $field';
  }

  @override
  String fieldRequired(String field) {
    return '$field is required';
  }

  @override
  String get formFields => 'Form Fields';

  @override
  String get clearAll => 'Clear All';

  @override
  String get saved => 'Saved';
}
