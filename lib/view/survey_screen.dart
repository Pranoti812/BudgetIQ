// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'survey_result_screen.dart';

// /*
// ========================
// DOMAIN MODEL
// ========================
// */
// class Domain {
//   final String name;
//   final IconData icon;

//   Domain(this.name, this.icon);
// }

// final List<Domain> domains = [
//   Domain("Education", Icons.school),
//   Domain("Healthcare", Icons.local_hospital),
//   Domain("Roads", Icons.alt_route),
//   Domain("Water", Icons.water_drop),
//   Domain("Electricity", Icons.bolt),
// ];

// /*
// ========================
// LOCAL STORAGE
// ========================
// */
// List<Map<String, dynamic>> localVotes = [];

// class SurveyScreen extends StatefulWidget {
//   @override
//   State<SurveyScreen> createState() => _SurveyScreenState();
// }

// class _SurveyScreenState extends State<SurveyScreen> {
//   String selectedReason = "";
//   String? selectedDomain;

//   /*
//   ========================
//   REAL ML FUNCTION (SAFE)
//   ========================
//   */
//   Future<Map<String, dynamic>> analyzeText(String text) async {
//     const apiUrl =
//         "https://api-inference.huggingface.co/models/distilbert-base-uncased-finetuned-sst-2-english";

//     const apiKey = "YOUR_HUGGINGFACE_TOKEN"; // replace if needed

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           "Authorization": "Bearer $apiKey",
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({"inputs": text}),
//       );

//       final data = jsonDecode(response.body);

//       // SAFE CHECK
//       if (data is List && data.isNotEmpty) {
//         final result = data[0];

//         return {
//           "sentiment": result["label"] ?? "NEUTRAL",
//           "score": (result["score"] ?? 0).toDouble(),
//         };
//       }

//       return {"sentiment": "NEUTRAL", "score": 0.0};
//     } catch (e) {
//       return {"sentiment": "NEUTRAL", "score": 0.0};
//     }
//   }

//   /*
//   ========================
//   SUBMIT VOTE
//   ========================
//   */
//   void submitVote() async {
//     if (selectedDomain == null || selectedReason.isEmpty) return;

//     final mlResult = await analyzeText(selectedReason);

//     String sentiment = mlResult["sentiment"] ?? "NEUTRAL";
//     double score = (mlResult["score"] as num?)?.toDouble() ?? 0.0;

//     final vote = {
//       "domain": selectedDomain,
//       "reason": selectedReason,
//       "sentiment": sentiment,
//       "score": score,
//     };

//     localVotes.add(vote);

//     if (!mounted) return;

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => ResultScreen(
//           domain: selectedDomain!,
//           reason: selectedReason,
//           sentiment: sentiment,
//           score: score,
//         ),
//       ),
//     );
//   }

//   /*
//   ========================
//   UI
//   ========================
//   */
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Budget Survey")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: domains.length,
//               itemBuilder: (context, index) {
//                 final d = domains[index];

//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedDomain = d.name;
//                     });
//                   },
//                   child: Card(
//                     margin: EdgeInsets.all(10),
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(
//                         color: selectedDomain == d.name
//                             ? Colors.green
//                             : Colors.grey,
//                         width: 2,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: ListTile(
//                       leading: Icon(d.icon, size: 28),
//                       title: Text(
//                         d.name,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       trailing: Icon(
//                         Icons.check_circle,
//                         color: selectedDomain == d.name
//                             ? Colors.green
//                             : Colors.grey,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(12),
//             child: TextField(
//               onChanged: (val) => selectedReason = val,
//               decoration: InputDecoration(
//                 labelText: "Reason for your vote",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(12),
//             child: ElevatedButton(
//               onPressed: selectedDomain == null ? null : submitVote,
//               child: Text("Submit Vote"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'survey_result_screen.dart';

/*
========================
DOMAIN MODEL
========================
*/
class Domain {
  final String name;
  final IconData icon;

  Domain(this.name, this.icon);
}

final List<Domain> domains = [
  Domain("Education", Icons.school),
  Domain("Healthcare", Icons.local_hospital),
  Domain("Roads", Icons.alt_route),
  Domain("Water", Icons.water_drop),
  Domain("Electricity", Icons.bolt),
];

/*
========================
LOCAL STORAGE
========================
*/
List<Map<String, dynamic>> localVotes = [];

class SurveyScreen extends StatefulWidget {
  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  String selectedReason = "";
  String? selectedDomain;

  /*
  ========================
  REAL ML FUNCTION (SAFE)
  ========================
  */
  Future<Map<String, dynamic>> analyzeText(String text) async {
    const apiUrl =
        "https://api-inference.huggingface.co/models/distilbert-base-uncased-finetuned-sst-2-english";

    const apiKey = "YOUR_HUGGINGFACE_TOKEN"; // replace if needed

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"inputs": text}),
      );

      final data = jsonDecode(response.body);

      // SAFE CHECK
      if (data is List && data.isNotEmpty) {
        final result = data[0];

        return {
          "sentiment": result["label"] ?? "NEUTRAL",
          "score": (result["score"] ?? 0).toDouble(),
        };
      }

      return {"sentiment": "NEUTRAL", "score": 0.0};
    } catch (e) {
      return {"sentiment": "NEUTRAL", "score": 0.0};
    }
  }

  /*
  ========================
  SUBMIT VOTE
  ========================
  */
  void submitVote() async {
    if (selectedDomain == null || selectedReason.isEmpty) return;

    final mlResult = await analyzeText(selectedReason);

    String sentiment = mlResult["sentiment"] ?? "NEUTRAL";
    double score = (mlResult["score"] as num?)?.toDouble() ?? 0.0;

    final vote = {
      "domain": selectedDomain,
      "reason": selectedReason,
      "sentiment": sentiment,
      "score": score,
    };

    localVotes.add(vote);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          domain: selectedDomain!,
          reason: selectedReason,
          sentiment: sentiment,
          score: score,
        ),
      ),
    );
  }

  /*
  ========================
  UI
  ========================
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Budget Survey")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: domains.length,
              itemBuilder: (context, index) {
                final d = domains[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDomain = d.name;
                    });
                  },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: selectedDomain == d.name
                            ? Colors.green
                            : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(d.icon, size: 28),
                      title: Text(
                        d.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.check_circle,
                        color: selectedDomain == d.name
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              onChanged: (val) => selectedReason = val,
              decoration: InputDecoration(
                labelText: "Reason for your vote",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: selectedDomain == null ? null : submitVote,
              child: Text("Submit Vote"),
            ),
          ),
        ],
      ),
    );
  }
}
