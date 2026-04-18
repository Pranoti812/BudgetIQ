import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String url = "https://your-api.com/budget";

  static Future<List<dynamic>> fetchBudget() async {
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("API failed");
    }
  }
}