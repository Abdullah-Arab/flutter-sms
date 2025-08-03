import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../l10n/app_localizations.dart';
import '../../logic/sms_commands_cubit.dart';
import '../../logic/sms_commands_state.dart';
import '../../models/input_field.dart';

class DynamicForm extends StatefulWidget {
  final List<InputField> fields;
  final VoidCallback onSubmit;

  const DynamicForm({super.key, required this.fields, required this.onSubmit});

  @override
  State<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String> _values = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each field
    for (final field in widget.fields) {
      _controllers[field.id] = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SmsCommandsCubit, SmsCommandsState>(
      builder: (context, state) {
        if (state is SmsCommandsLoaded) {
          // Update local values and controllers with Cubit values
          _updateFormValues(state.formValues);
        }

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Form Header with Clear Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.formFields,
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _clearAllFields();
                    },
                    icon: const Icon(Icons.clear, size: 16),
                    label: Text(
                      l10n.clearAll,
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red.shade600,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              ...widget.fields.map((field) {
                final isArabic =
                    Localizations.localeOf(context).languageCode == 'ar';
                final label = isArabic ? field.labelAr : field.labelEn;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildFormField(field, label, l10n),
                );
              }).toList(),
              const SizedBox(height: 32),
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      widget.onSubmit();
                    }
                  },
                  icon: const Icon(Icons.send),
                  label: Text(
                    l10n.sendSms,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateFormValues(Map<String, String> cubitValues) {
    for (final field in widget.fields) {
      final savedValue = cubitValues[field.id];
      if (savedValue != null && savedValue.isNotEmpty) {
        // Update local values
        _values[field.id] = savedValue;

        // Update controller if it exists and value is different
        final controller = _controllers[field.id];
        if (controller != null && controller.text != savedValue) {
          controller.text = savedValue;
        }
      }
    }
  }

  void _clearAllFields() {
    setState(() {
      _values.clear();
      // Clear all controllers
      for (final controller in _controllers.values) {
        controller.clear();
      }
    });

    // Clear form values in Cubit
    final cubit = context.read<SmsCommandsCubit>();
    cubit.clearForm();
  }

  Widget _buildFormField(
    InputField field,
    String label,
    AppLocalizations l10n,
  ) {
    final hasSavedValue = _values[field.id]?.isNotEmpty == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field label with saved indicator
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            if (hasSavedValue)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 12,
                      color: Colors.green.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.saved,
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),

        // Form field
        _buildFieldWidget(field, label, l10n),
      ],
    );
  }

  Widget _buildFieldWidget(
    InputField field,
    String label,
    AppLocalizations l10n,
  ) {
    switch (field.type) {
      case 'text':
        return TextFormField(
          controller: _controllers[field.id],
          decoration: InputDecoration(
            labelText: label,
            hintText: l10n.enterField(label),
            prefixIcon: Icon(
              _getFieldIcon(field.id),
              color: Colors.grey.shade600,
            ),
            suffixIcon:
                _values[field.id]?.isNotEmpty == true
                    ? Icon(
                      Icons.check_circle,
                      color: Colors.green.shade600,
                      size: 20,
                    )
                    : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.fieldRequired(label);
            }
            return null;
          },
          onChanged: (value) {
            if (value != null) {
              _values[field.id] = value;
              // Update form values in real-time
              final cubit = context.read<SmsCommandsCubit>();
              cubit.updateFormValue(field.id, value);
              setState(() {}); // Rebuild to show/hide check icon
            }
          },
          onSaved: (value) {
            if (value != null) {
              _values[field.id] = value;
            }
          },
        );

      case 'dropdown':
        return DropdownButtonFormField<String>(
          value:
              _values[field.id]?.isNotEmpty == true ? _values[field.id] : null,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(
              _getFieldIcon(field.id),
              color: Colors.grey.shade600,
            ),
          ),
          items:
              field.options?.map((option) {
                final isArabic =
                    Localizations.localeOf(context).languageCode == 'ar';
                final optionLabel = isArabic ? option.labelAr : option.labelEn;
                return DropdownMenuItem(
                  value: option.value,
                  child: Text(optionLabel),
                );
              }).toList() ??
              [],
          validator: (value) {
            if (value == null) {
              return l10n.fieldRequired(label);
            }
            return null;
          },
          onChanged: (value) {
            if (value != null) {
              _values[field.id] = value;
              // Update form values in real-time
              final cubit = context.read<SmsCommandsCubit>();
              cubit.updateFormValue(field.id, value);
              setState(() {}); // Rebuild to show/hide check icon
            }
          },
        );

      default:
        return const SizedBox();
    }
  }

  IconData _getFieldIcon(String fieldId) {
    if (fieldId.contains('account')) {
      return Icons.account_balance;
    } else if (fieldId.contains('pin')) {
      return Icons.lock;
    } else if (fieldId.contains('amount')) {
      return Icons.attach_money;
    } else if (fieldId.contains('phone')) {
      return Icons.phone;
    } else {
      return Icons.edit;
    }
  }
}
