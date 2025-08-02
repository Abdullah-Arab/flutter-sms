import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ...widget.fields.map((field) {
            final isArabic =
                Localizations.localeOf(context).languageCode == 'ar';
            final label = isArabic ? field.labelAr : field.labelEn;

            switch (field.type) {
              case 'text':
                return TextFormField(
                  decoration: InputDecoration(labelText: label),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
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
                  onSaved: (value) {
                    if (value != null) {
                      _values[field.id] = value;
                    }
                  },
                );

              case 'dropdown':
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: label),
                  items:
                      field.options?.map((option) {
                        final optionLabel =
                            isArabic ? option.labelAr : option.labelEn;
                        return DropdownMenuItem(
                          value: option.value,
                          child: Text(optionLabel),
                        );
                      }).toList() ??
                      [],
                  validator: (value) {
                    if (value == null) {
                      return 'Required';
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
          }).toList(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                widget.onSubmit();
              }
            },
            child: const Text('Send SMS'),
          ),
        ],
      ),
    );
  }
}
