import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import '../models/vendor.dart';
import '../models/command.dart';
import 'package:easy_localization/easy_localization.dart';

class TransactionFormScreen extends StatefulWidget {
  final Vendor vendor;
  final Command command;
  TransactionFormScreen({required this.vendor, required this.command});
  @override
  _TransactionFormScreenState createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _telephony = Telephony.instance;
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = {};
    final keys =
        RegExp(
          r"\{(.*?)\}",
        ).allMatches(widget.command.template).map((m) => m.group(1)!).toList();
    for (var k in keys) controllers[k] = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.locale.languageCode == 'ar'
              ? widget.command.nameAr
              : widget.command.nameEn,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ...controllers.entries.map(
              (e) => TextField(
                controller: e.value,
                decoration: InputDecoration(labelText: e.key),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: sendSms, child: Text('send'.tr())),
          ],
        ),
      ),
    );
  }

  void sendSms() async {
    var msg = widget.command.template;
    controllers.forEach((k, c) => msg = msg.replaceAll('{$k}', c.text));
    await _telephony.sendSms(to: widget.vendor.shortcode, message: msg);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('sms_sent'.tr())));
  }
}
