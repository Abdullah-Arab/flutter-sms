import 'dart:convert';
import 'package:flutter/services.dart';
import '../../features/sms_commands/models/category.dart';

class ConfigService {
  Future<List<Category>> fetchCategories() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/config.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final List<dynamic> categoriesJson = jsonData['categories'] as List;
      return categoriesJson
          .map((json) => Category.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load configuration: $e');
    }
  }
}
