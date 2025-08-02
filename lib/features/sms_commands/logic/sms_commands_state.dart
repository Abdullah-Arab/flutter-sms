import '../models/category.dart';
import '../models/service_provider.dart';
import '../models/action_item.dart';

abstract class SmsCommandsState {
  const SmsCommandsState();
}

class SmsCommandsInitial extends SmsCommandsState {
  const SmsCommandsInitial();
}

class SmsCommandsLoading extends SmsCommandsState {
  const SmsCommandsLoading();
}

class SmsCommandsLoaded extends SmsCommandsState {
  final List<Category> categories;
  final Category? selectedCategory;
  final ServiceProvider? selectedProvider;
  final ActionItem? selectedAction;
  final Map<String, String> formValues;

  const SmsCommandsLoaded({
    required this.categories,
    this.selectedCategory,
    this.selectedProvider,
    this.selectedAction,
    this.formValues = const {},
  });

  SmsCommandsLoaded copyWith({
    List<Category>? categories,
    Category? selectedCategory,
    ServiceProvider? selectedProvider,
    ActionItem? selectedAction,
    Map<String, String>? formValues,
  }) {
    return SmsCommandsLoaded(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedProvider: selectedProvider ?? this.selectedProvider,
      selectedAction: selectedAction ?? this.selectedAction,
      formValues: formValues ?? this.formValues,
    );
  }
}

class SmsCommandsError extends SmsCommandsState {
  final String message;

  const SmsCommandsError(this.message);
}
