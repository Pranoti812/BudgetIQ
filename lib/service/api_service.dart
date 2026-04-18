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

  // 🔥 Replace with your real API URL
  static const String regionUrl =
      "https://mocki.io/v1/YOUR_REGION_API_ID";

  /// ✅ FETCH REGION DATA (SAFE + ERROR HANDLING)
  static Future<List<dynamic>> fetchRegions() async {
    try {
      final response = await http.get(
        Uri.parse(regionUrl),
        headers: {
          "Content-Type": "application/json",
        },
      );

      // 🔍 DEBUG (optional)
      // print(response.body);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        /// ✅ CASE 1: API returns List
        if (decoded is List) {
          return decoded;
        }

        /// ✅ CASE 2: API returns { data: [...] }
        if (decoded is Map && decoded['data'] != null) {
          return decoded['data'];
        }

        throw Exception("Invalid JSON format");
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("fetchRegions failed: $e");
    }
  }
}