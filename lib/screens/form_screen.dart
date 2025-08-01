import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/config_provider.dart';
import '../widgets/dynamic_form.dart';

class FormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.read<ConfigProvider>();
    final action = prov.selectedAction!;
    final title = context.locale.languageCode=='ar'?action.nameAr:action.nameEn;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: DynamicForm(
          fields: action.fields,
          onSubmit: () => prov.sendSms(),
        ),
      ),
    );
  }
}