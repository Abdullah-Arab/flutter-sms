import 'package:flutter/material.dart';
import '../models/category.dart';
import 'command_list_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class VendorListScreen extends StatelessWidget {
  final Category category;
  VendorListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.locale.languageCode == 'ar'
              ? category.nameAr
              : category.nameEn,
        ),
      ),
      body: ListView(
        children:
            category.vendors
                .map(
                  (v) => ListTile(
                    title: Text(
                      context.locale.languageCode == 'ar' ? v.nameAr : v.nameEn,
                    ),
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CommandListScreen(vendor: v),
                          ),
                        ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
