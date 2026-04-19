import 'dart:convert';
import 'package:budegt_iq/view/gov_bottm_nav.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class AIInsightsScreen extends StatefulWidget {
  const AIInsightsScreen({super.key});

  @override
  State<AIInsightsScreen> createState() => _AIInsightsScreenState();
}

class _AIInsightsScreenState extends State<AIInsightsScreen> {
  int currentIndex = 2;

  /// 🔐 PUT NEW API KEY HERE
  final String apiKey = "AIzaSyBDU19q9ksYrSuFw25VODV2BnheRYdGGss";

  List<FlSpot> spots = [];
  List<Map<String, dynamic>> recommendations = [];

  double gdpGrowth = 12;
  double satisfaction = 82;

  bool isLoading = true;
  bool isAiLoading = false;

  /// 🔁 NAVIGATION
  void _onNavTap(int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/simulation');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/regions');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  /// 📊 LOAD DATA (Firebase-ready)
  Future<void> loadData() async {
    List<FlSpot> tempSpots = [
      FlSpot(2024, 7000),
      FlSpot(2025, 7800),
      FlSpot(2026, 8600),
      FlSpot(2027, 9400),
      FlSpot(2028, 10500),
    ];

    setState(() {
      spots = tempSpots;
      gdpGrowth = 12;
      satisfaction = 82;
      isLoading = false;
    });

    /// 🔥 CALL AI AFTER DATA READY
    fetchAIRecommendations();
  }

  /// 🤖 GEMINI API
  Future<void> fetchAIRecommendations() async {
    setState(() => isAiLoading = true);

    final url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey";

    final prompt = """
You are a government economic AI.

GDP Growth: $gdpGrowth%
Public Satisfaction: $satisfaction%

Return ONLY valid JSON. No explanation.

Format:
[
 { "title": "string", "desc": "string", "impact": 0.0 }
]
""";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        }),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      /// ❌ HTTP ERROR
      if (response.statusCode != 200) {
        debugPrint("HTTP ERROR: ${response.body}");
        setState(() => isAiLoading = false);
        return;
      }

      final data = jsonDecode(response.body);

      /// ❌ INVALID RESPONSE
      if (data['candidates'] == null ||
          data['candidates'].isEmpty) {
        debugPrint("Invalid Gemini response");
        setState(() => isAiLoading = false);
        return;
      }

      String text =
          data["candidates"][0]["content"]["parts"][0]["text"] ?? "";

      /// 🔍 EXTRACT JSON
      final start = text.indexOf('[');
      final end = text.lastIndexOf(']') + 1;

      if (start == -1 || end == -1) {
        debugPrint("Invalid AI format: $text");
        setState(() => isAiLoading = false);
        return;
      }

      final jsonString = text.substring(start, end);

      try {
        final parsed = jsonDecode(jsonString);

        setState(() {
          recommendations =
              List<Map<String, dynamic>>.from(parsed);
          isAiLoading = false;
        });
      } catch (e) {
        debugPrint("JSON PARSE ERROR: $e");
        setState(() => isAiLoading = false);
      }
    } catch (e) {
      debugPrint("AI ERROR: $e");
      setState(() => isAiLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F7),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: _onNavTap,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// HEADER
                    Row(
                      children: [
                        const Icon(Icons.arrow_back),
                        const SizedBox(width: 10),
                        const Text(
                          "AI Budget Recommendation",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: fetchAIRecommendations,
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// CHART
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Budget Forecast",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          _buildChart(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// AI RECOMMENDATIONS
                    _card(
                      title: "Key Recommendations",
                      child: isAiLoading
                          ? const Center(
                              child: CircularProgressIndicator())
                          : Column(
                              children: recommendations.map((item) {
                                return _recommendationItem(
                                  title: item["title"],
                                  subtitle: item["desc"],
                                  progress:
                                      (item["impact"] as num)
                                          .toDouble(),
                                );
                              }).toList(),
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildChart() {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          minX: 2024,
          maxX: 2028,
          minY: 0,
          maxY: 12000,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              gradient: const LinearGradient(
                colors: [Colors.green, Colors.lightGreen],
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.3),
                    Colors.transparent
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({String? title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          if (title != null) const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _recommendationItem({
    required String title,
    required String subtitle,
    required double progress,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(subtitle),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}