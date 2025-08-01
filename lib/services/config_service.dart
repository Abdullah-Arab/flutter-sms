import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class ConfigService {
  static const remoteUrl = 'https://raw.githubusercontent.com/<user>/<repo>/<branch>/assets/config.json';
  Future<List<Category>> fetchCategories() async {
    final res = await http.get(Uri.parse(remoteUrl));
    if (res.statusCode != 200) throw Exception('Failed to load config');
    final map = json.decode(res.body) as Map<String, dynamic>;
    return (map['categories'] as List).map((c) => Category.fromJson(c)).toList();
  }
}