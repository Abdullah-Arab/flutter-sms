import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/input_field.dart';
import '../providers/config_provider.dart';

class DynamicForm extends StatefulWidget {
  final List<InputField> fields;
  final VoidCallback onSubmit;
  DynamicForm({required this.fields, required this.onSubmit});
  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _vals = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ...widget.fields.map((f) {
            switch (f.type) {
              case 'text':
                return TextFormField(
                  decoration: InputDecoration(
                    labelText: context.locale.languageCode=='ar'?f.labelAr:f.labelEn,
                  ),
                  validator: (v) => v==null||v.isEmpty? 'required'.tr():null,
                  onSaved: (v) => _vals[f.id] = v!,
                );

              case 'dropdown':
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: context.locale.languageCode=='ar'?f.labelAr:f.labelEn,
                  ),
                  items: f.options!.map((opt) {
                    final label = context.locale.languageCode=='ar'?opt.labelAr:opt.labelEn;
                    return DropdownMenuItem(value: opt.value, child: Text(label));
                  }).toList(),
                  validator: (v) => v==null? 'required'.tr():null,
                  onChanged: (v) => _vals[f.id] = v!,
                );

              default:
                return SizedBox();
            }
          }).toList(),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('send'.tr()),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Provider.of<ConfigProvider>(context, listen: false).values = _vals;
                widget.onSubmit();
              }
            },
          ),
        ],
      ),
    );
  }
}