import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/config_provider.dart';
import 'provider_list_screen.dart';

class CategoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.watch<ConfigProvider>();
    if (prov.categories.isEmpty) return Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text('select_category'.tr())),
      body: ListView(
        children: prov.categories.map((c) {
          final label = context.locale.languageCode=='ar'?c.nameAr:c.nameEn;
          return ListTile(
            title: Text(label),
            onTap: () {
              prov.pickCategory(c);
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderListScreen()));
            },
          );
        }).toList(),
      ),
    );
  }
}