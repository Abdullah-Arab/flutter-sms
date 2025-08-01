import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/config_provider.dart';
import 'vendor_list_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cfg = context.watch<ConfigProvider>();
    if (cfg.loading)
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text('select_category'.tr())),
      body: ListView(
        children:
            cfg.categories
                .map(
                  (c) => ListTile(
                    title: Text(
                      context.locale.languageCode == 'ar' ? c.nameAr : c.nameEn,
                    ),
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VendorListScreen(category: c),
                          ),
                        ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
