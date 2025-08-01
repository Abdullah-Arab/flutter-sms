import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/config_provider.dart';
import 'action_list_screen.dart';

class ProviderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.read<ConfigProvider>();
    final cat = prov.selectedCategory!;
    return Scaffold(
      appBar: AppBar(title: Text('select_provider'.tr())),
      body: ListView(
        children: cat.providers.map((p) {
          final label = context.locale.languageCode=='ar'?p.nameAr:p.nameEn;
          return ListTile(
            title: Text(label),
            onTap: () {
              prov.pickProvider(p);
              Navigator.push(context, MaterialPageRoute(builder: (_) => ActionListScreen()));
            },
          );
        }).toList(),
      ),
    );
  }
}