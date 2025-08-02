import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../logic/sms_commands_cubit.dart';
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
  final Map<String, String> _values = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
  }

  Widget _buildFormField(
    InputField field,
    String label,
    AppLocalizations l10n,
  ) {
    switch (field.type) {
      case 'text':
        return TextFormField(
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
