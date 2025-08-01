import 'package:flutter/material.dart';
import '../models/vendor.dart';
import 'transaction_form_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class CommandListScreen extends StatelessWidget {
  final Vendor vendor;
  CommandListScreen({required this.vendor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(vendor.nameEn)),
      body: ListView(
        children:
            vendor.commands
                .map(
                  (cmd) => ListTile(
                    title: Text(
                      context.locale.languageCode == 'ar'
                          ? cmd.nameAr
                          : cmd.nameEn,
                    ),
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => TransactionFormScreen(
                                  vendor: vendor,
                                  command: cmd,
                                ),
                          ),
                        ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
