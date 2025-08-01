import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/config_provider.dart';
import 'form_screen.dart';

class ActionListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.read<ConfigProvider>();
    final provdr = prov.selectedProvider!;
    return Scaffold(
      appBar: AppBar(title: Text('select_action'.tr())),
      body: ListView(
        children: provdr.actions.map((a) {
          final label = context.locale.languageCode=='ar'?a.nameAr:a.nameEn;
          return ListTile(
            title: Text(label),
            onTap: () {
              prov.pickAction(a);
              Navigator.push(context, MaterialPageRoute(builder: (_) => FormScreen()));
            },
          );
        }).toList(),
      ),
    );
  }
}