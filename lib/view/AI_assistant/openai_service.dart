// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class OpenAIService {
//   final String apiKey;
//   final String _baseUrl =
//       'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

//   List<Map<String, dynamic>> _conversationHistory = [];

//   OpenAIService({required this.apiKey});

//   Future<String> askGPT(String prompt) async {
//     if (prompt.trim().isEmpty) {
//       return "I didn't catch that. Please try again.";
//     }

//     try {
//       // Add user message to history
//       _conversationHistory.add({
//         "role": "user",
//         "parts": [
//           {"text": prompt},
//         ],
//       });

//       // Prepare request body
//       final requestBody = {
//         "contents": _conversationHistory,
//         "generationConfig": {
//           "temperature": 0.7,
//           "topK": 40,
//           "topP": 0.95,
//           "maxOutputTokens": 1024,
//         },
//         "safetySettings": [
//           {
//             "category": "HARM_CATEGORY_HARASSMENT",
//             "threshold": "BLOCK_MEDIUM_AND_ABOVE",
//           },
//           {
//             "category": "HARM_CATEGORY_HATE_SPEECH",
//             "threshold": "BLOCK_MEDIUM_AND_ABOVE",
//           },
//           {
//             "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
//             "threshold": "BLOCK_MEDIUM_AND_ABOVE",
//           },
//           {
//             "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
//             "threshold": "BLOCK_MEDIUM_AND_ABOVE",
//           },
//         ],
//       };

//       final response = await http
//           .post(
//             Uri.parse('$_baseUrl?key=$apiKey'),
//             headers: {'Content-Type': 'application/json'},
//             body: jsonEncode(requestBody),
//           )
//           .timeout(
//             const Duration(seconds: 30),
//             onTimeout: () {
//               throw Exception('Request timeout. Please try again.');
//             },
//           );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         if (data['candidates'] != null && data['candidates'].isNotEmpty) {
//           final content = data['candidates'][0]['content'];
//           if (content != null &&
//               content['parts'] != null &&
//               content['parts'].isNotEmpty) {
//             String reply = content['parts'][0]['text'] ?? "No response";

//             // Add assistant reply to history
//             _conversationHistory.add({
//               "role": "model",
//               "parts": [
//                 {"text": reply},
//               ],
//             });

//             // Keep only last 10 exchanges (20 messages)
//             if (_conversationHistory.length > 20) {
//               _conversationHistory = _conversationHistory.sublist(
//                 _conversationHistory.length - 20,
//               );
//             }

//             return reply;
//           }
//         }

//         return "I couldn't generate a response. Please try again.";
//       } else if (response.statusCode == 429) {
//         return "Too many requests. Please wait a moment and try again.";
//       } else if (response.statusCode == 400) {
//         final errorData = jsonDecode(response.body);
//         print("API Error 400: $errorData");
//         return "Invalid request. Please try asking differently.";
//       } else if (response.statusCode == 403) {
//         return "API key error. Please check your Gemini API key.";
//       } else {
//         print("API Error ${response.statusCode}: ${response.body}");
//         return "Sorry, I encountered an error. Please try again.";
//       }
//     } catch (e) {
//       print("Error in askGPT: $e");
//       if (e.toString().contains('timeout')) {
//         return "Request took too long. Please try again.";
//       }
//       return "Connection error. Please check your internet and try again.";
//     }
//   }

//   void clearHistory() {
//     _conversationHistory.clear();
//   }
// }

// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:http/http.dart' as http;

// // class OpenAIService {
// //   // ✅ Hardcoded API Key (replace with your real key)
// //   final String apiKey = "AIzaSyCLFPhcTWU81YgagJHqtx1drhZOdb-WB-Q";

// //   final String _baseUrl =
// //       'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

// //   List<Map<String, dynamic>> _conversationHistory = [];

// //   OpenAIService({required String apiKey});

// //   Future<String> askGPT(String prompt) async {
// //     if (prompt.trim().isEmpty) {
// //       return "I didn't catch that. Please try again.";
// //     }

// //     try {
// //       // Add user message to history
// //       _conversationHistory.add({
// //         "role": "user",
// //         "parts": [
// //           {"text": prompt},
// //         ],
// //       });

// //       // Prepare request body
// //       final requestBody = {
// //         "contents": _conversationHistory,
// //         "generationConfig": {
// //           "temperature": 0.7,
// //           "topK": 40,
// //           "topP": 0.95,
// //           "maxOutputTokens": 1024,
// //         },
// //         "safetySettings": [
// //           {
// //             "category": "HARM_CATEGORY_HARASSMENT",
// //             "threshold": "BLOCK_MEDIUM_AND_ABOVE",
// //           },
// //           {
// //             "category": "HARM_CATEGORY_HATE_SPEECH",
// //             "threshold": "BLOCK_MEDIUM_AND_ABOVE",
// //           },
// //           {
// //             "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
// //             "threshold": "BLOCK_MEDIUM_AND_ABOVE",
// //           },
// //           {
// //             "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
// //             "threshold": "BLOCK_MEDIUM_AND_ABOVE",
// //           },
// //         ],
// //       };

// //       final response = await http
// //           .post(
// //             Uri.parse('$_baseUrl?key=$apiKey'),
// //             headers: {'Content-Type': 'application/json'},
// //             body: jsonEncode(requestBody),
// //           )
// //           .timeout(
// //             const Duration(seconds: 30),
// //             onTimeout: () {
// //               throw Exception('Request timeout. Please try again.');
// //             },
// //           );

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);

// //         if (data['candidates'] != null && data['candidates'].isNotEmpty) {
// //           final content = data['candidates'][0]['content'];
// //           if (content != null &&
// //               content['parts'] != null &&
// //               content['parts'].isNotEmpty) {
// //             String reply = content['parts'][0]['text'] ?? "No response";

// //             // Add assistant reply to history
// //             _conversationHistory.add({
// //               "role": "model",
// //               "parts": [
// //                 {"text": reply},
// //               ],
// //             });

// //             // Keep only last 10 exchanges (20 messages)
// //             if (_conversationHistory.length > 20) {
// //               _conversationHistory = _conversationHistory.sublist(
// //                 _conversationHistory.length - 20,
// //               );
// //             }

// //             return reply;
// //           }
// //         }

// //         return "I couldn't generate a response. Please try again.";
// //       } else if (response.statusCode == 429) {
// //         return "Too many requests. Please wait a moment and try again.";
// //       } else if (response.statusCode == 400) {
// //         final errorData = jsonDecode(response.body);
// //         print("API Error 400: $errorData");
// //         return "Invalid request. Please try asking differently.";
// //       } else if (response.statusCode == 403) {
// //         return "API key error. Please check your Gemini API key.";
// //       } else {
// //         print("API Error ${response.statusCode}: ${response.body}");
// //         return "Sorry, I encountered an error. Please try again.";
// //       }
// //     } catch (e) {
// //       print("Error in askGPT: $e");
// //       if (e.toString().contains('timeout')) {
// //         return "Request took too long. Please try again.";
// //       }
// //       return "Connection error. Please check your internet and try again.";
// //     }
// //   }

// //   void clearHistory() {
// //     _conversationHistory.clear();
// //   }
// // }

// // /// ✅ MAIN FUNCTION (ONLY FOR CLI TESTING)
// // /// ❌ Will NOT run inside Flutter app
// // void main() async {
// //   final service = OpenAIService(
// //     apiKey: 'AIzaSyCLFPhcTWU81YgagJHqtx1drhZOdb-WB-Q',
// //   );

// //   print("Console Test Mode (type 'exit' to quit)");

// //   while (true) {
// //     stdout.write("You: ");
// //     final input = stdin.readLineSync();

// //     if (input == null || input.toLowerCase() == 'exit') {
// //       print("Exiting...");
// //       break;
// //     }

// //     final response = await service.askGPT(input);
// //     print("AI: $response\n");
// //   }
// // }

import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey;
  final String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

  List<Map<String, dynamic>> _conversationHistory = [];

  OpenAIService({required this.apiKey});

  Future<String> askGPT(String prompt) async {
    if (prompt.trim().isEmpty) {
      return "I didn't catch that. Please try again.";
    }

    try {
      // Add user message to history
      _conversationHistory.add({
        "role": "user",
        "parts": [
          {"text": prompt},
        ],
      });

      // Prepare request body
      final requestBody = {
        "contents": _conversationHistory,
        "generationConfig": {
          "temperature": 0.7,
          "topK": 40,
          "topP": 0.95,
          "maxOutputTokens": 1024,
        },
        "safetySettings": [
          {
            "category": "HARM_CATEGORY_HARASSMENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE",
          },
          {
            "category": "HARM_CATEGORY_HATE_SPEECH",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE",
          },
          {
            "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE",
          },
          {
            "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE",
          },
        ],
      };

      final response = await http
          .post(
            Uri.parse('$_baseUrl?key=$apiKey'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(requestBody),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception('Request timeout. Please try again.');
            },
          );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          final content = data['candidates'][0]['content'];
          if (content != null &&
              content['parts'] != null &&
              content['parts'].isNotEmpty) {
            String reply = content['parts'][0]['text'] ?? "No response";

            // Add assistant reply to history
            _conversationHistory.add({
              "role": "model",
              "parts": [
                {"text": reply},
              ],
            });

            // Keep only last 10 exchanges (20 messages)
            if (_conversationHistory.length > 20) {
              _conversationHistory = _conversationHistory.sublist(
                _conversationHistory.length - 20,
              );
            }

            return reply;
          }
        }

        return "I couldn't generate a response. Please try again.";
      } else if (response.statusCode == 429) {
        return "Too many requests. Please wait a moment and try again.";
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        print("API Error 400: $errorData");
        return "Invalid request. Please try asking differently.";
      } else if (response.statusCode == 403) {
        return "API key error. Please check your Gemini API key.";
      } else {
        print("API Error ${response.statusCode}: ${response.body}");
        return "Sorry, I encountered an error. Please try again.";
      }
    } catch (e) {
      print("Error in askGPT: $e");
      if (e.toString().contains('timeout')) {
        return "Request took too long. Please try again.";
      }
      return "Connection error. Please check your internet and try again.";
    }
  }

  void clearHistory() {
    _conversationHistory.clear();
  }
}
