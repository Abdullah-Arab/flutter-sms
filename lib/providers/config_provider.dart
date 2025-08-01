import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/service_provider.dart';
import '../models/action_item.dart';
import '../services/config_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfigProvider extends ChangeNotifier {
  final _service = ConfigService();
  List<Category> categories = [];
  Category? selectedCategory;
  ServiceProvider? selectedProvider;
  ActionItem? selectedAction;
  Map<String, String> values = {};

  Future load() async {
    categories = await _service.fetchCategories();
    notifyListeners();
  }

  pickCategory(Category c) {
    selectedCategory = c;
    selectedProvider = null;
    selectedAction = null;
    values.clear();
    notifyListeners();
  }

  pickProvider(ServiceProvider p) {
    selectedProvider = p;
    selectedAction = null;
    values.clear();
    notifyListeners();
  }

  pickAction(ActionItem a) {
    selectedAction = a;
    values.clear();
    notifyListeners();
  }

  Future sendSms() async {
    if (selectedAction == null) return;
    var msg = selectedAction!.template;
    values.forEach((k, v) => msg = msg.replaceAll('{$k}', v));
    final uri = Uri(scheme: 'sms', path: selectedAction!.smsNumber, queryParameters: {'body': msg});
    await launchUrl(uri);
  }
}