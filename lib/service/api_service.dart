// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String url = "https://your-api.com/budget";

//   static Future<List<dynamic>> fetchBudget() async {
//     final res = await http.get(Uri.parse(url));

//     if (res.statusCode == 200) {
//       return jsonDecode(res.body);
//     } else {
//       throw Exception("API failed");
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = "579b464db66ec23bdd000001b5ef14aa898343b46abd5209a84983aa";

  static Future<List<dynamic>> fetchRegions() async {
    final url = Uri.parse(
      "https://api.data.gov.in/resource/44842dc8-955c-4bf4-bb39-75219affd568?api-key=$apiKey&format=json",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return jsonData['records']; // 🔥 IMPORTANT
    } else {
      throw Exception("Failed to load data");
    }
  }
}