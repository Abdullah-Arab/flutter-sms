import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/config_service.dart';

class ConfigProvider extends ChangeNotifier {
  final _service = ConfigService();
  List<Category> categories = [];
  bool loading = true;

  Future<void> load() async {
    try {
      categories = await _service.loadConfig();
    } catch (e) {
      // handle error
    }
    loading = false;
    notifyListeners();
  }
}
