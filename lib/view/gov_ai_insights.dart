// import 'dart:convert';
// import 'package:budegt_iq/view/gov_bottm_nav.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:http/http.dart' as http;

// class AIInsightsScreen extends StatefulWidget {
//   const AIInsightsScreen({super.key});

//   @override
//   State<AIInsightsScreen> createState() => _AIInsightsScreenState();
// }

// class _AIInsightsScreenState extends State<AIInsightsScreen> {
//   int currentIndex = 2;

//   /// 🔐 PUT NEW API KEY HERE
//   final String apiKey = "AIzaSyBDU19q9ksYrSuFw25VODV2BnheRYdGGss";

//   List<FlSpot> spots = [];
//   List<Map<String, dynamic>> recommendations = [];

//   double gdpGrowth = 12;
//   double satisfaction = 82;

//   bool isLoading = true;
//   bool isAiLoading = false;

//   /// 🔁 NAVIGATION
//   void _onNavTap(int index) {
//     if (index == currentIndex) return;

//     switch (index) {
//       case 0:
//         Navigator.pushReplacementNamed(context, '/dashboard');
//         break;
//       case 1:
//         Navigator.pushReplacementNamed(context, '/simulation');
//         break;
//       case 3:
//         Navigator.pushReplacementNamed(context, '/regions');
//         break;
//       case 4:
//         Navigator.pushReplacementNamed(context, '/settings');
//         break;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   /// 📊 LOAD DATA (Firebase-ready)
//   Future<void> loadData() async {
//     List<FlSpot> tempSpots = [
//       FlSpot(2024, 7000),
//       FlSpot(2025, 7800),
//       FlSpot(2026, 8600),
//       FlSpot(2027, 9400),
//       FlSpot(2028, 10500),
//     ];

//     setState(() {
//       spots = tempSpots;
//       gdpGrowth = 12;
//       satisfaction = 82;
//       isLoading = false;
//     });

//     /// 🔥 CALL AI AFTER DATA READY
//     fetchAIRecommendations();
//   }

//   /// 🤖 GEMINI API
//   Future<void> fetchAIRecommendations() async {
//     setState(() => isAiLoading = true);

//     final url =
//         "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey";

//     final prompt = """
// You are a government economic AI.

// GDP Growth: $gdpGrowth%
// Public Satisfaction: $satisfaction%

// Return ONLY valid JSON. No explanation.

// Format:
// [
//  { "title": "string", "desc": "string", "impact": 0.0 }
// ]
// """;

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "contents": [
//             {
//               "parts": [
//                 {"text": prompt}
//               ]
//             }
//           ]
//         }),
//       );

//       print("STATUS: ${response.statusCode}");
//       print("BODY: ${response.body}");

//       /// ❌ HTTP ERROR
//       if (response.statusCode != 200) {
//         debugPrint("HTTP ERROR: ${response.body}");
//         setState(() => isAiLoading = false);
//         return;
//       }

//       final data = jsonDecode(response.body);

//       /// ❌ INVALID RESPONSE
//       if (data['candidates'] == null ||
//           data['candidates'].isEmpty) {
//         debugPrint("Invalid Gemini response");
//         setState(() => isAiLoading = false);
//         return;
//       }

//       String text =
//           data["candidates"][0]["content"]["parts"][0]["text"] ?? "";

//       /// 🔍 EXTRACT JSON
//       final start = text.indexOf('[');
//       final end = text.lastIndexOf(']') + 1;

//       if (start == -1 || end == -1) {
//         debugPrint("Invalid AI format: $text");
//         setState(() => isAiLoading = false);
//         return;
//       }

//       final jsonString = text.substring(start, end);

//       try {
//         final parsed = jsonDecode(jsonString);

//         setState(() {
//           recommendations =
//               List<Map<String, dynamic>>.from(parsed);
//           isAiLoading = false;
//         });
//       } catch (e) {
//         debugPrint("JSON PARSE ERROR: $e");
//         setState(() => isAiLoading = false);
//       }
//     } catch (e) {
//       debugPrint("AI ERROR: $e");
//       setState(() => isAiLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F9F7),
//       bottomNavigationBar: CustomBottomNav(
//         currentIndex: currentIndex,
//         onTap: _onNavTap,
//       ),
//       body: SafeArea(
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// HEADER
//                     Row(
//                       children: [
//                         const Icon(Icons.arrow_back),
//                         const SizedBox(width: 10),
//                         const Text(
//                           "AI Budget Recommendation",
//                           style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         const Spacer(),
//                         IconButton(
//                           icon: const Icon(Icons.refresh),
//                           onPressed: fetchAIRecommendations,
//                         )
//                       ],
//                     ),

//                     const SizedBox(height: 20),

//                     /// CHART
//                     _card(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text("Budget Forecast",
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold)),
//                           const SizedBox(height: 20),
//                           _buildChart(),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     /// AI RECOMMENDATIONS
//                     _card(
//                       title: "Key Recommendations",
//                       child: isAiLoading
//                           ? const Center(
//                               child: CircularProgressIndicator())
//                           : Column(
//                               children: recommendations.map((item) {
//                                 return _recommendationItem(
//                                   title: item["title"],
//                                   subtitle: item["desc"],
//                                   progress:
//                                       (item["impact"] as num)
//                                           .toDouble(),
//                                 );
//                               }).toList(),
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }

//   Widget _buildChart() {
//     return SizedBox(
//       height: 220,
//       child: LineChart(
//         LineChartData(
//           minX: 2024,
//           maxX: 2028,
//           minY: 0,
//           maxY: 12000,
//           borderData: FlBorderData(show: false),
//           gridData: FlGridData(show: true),
//           lineBarsData: [
//             LineChartBarData(
//               spots: spots,
//               isCurved: true,
//               gradient: const LinearGradient(
//                 colors: [Colors.green, Colors.lightGreen],
//               ),
//               belowBarData: BarAreaData(
//                 show: true,
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.green.withOpacity(0.3),
//                     Colors.transparent
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _card({String? title, required Widget child}) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (title != null)
//             Text(title,
//                 style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold)),
//           if (title != null) const SizedBox(height: 12),
//           child,
//         ],
//       ),
//     );
//   }

//   Widget _recommendationItem({
//     required String title,
//     required String subtitle,
//     required double progress,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.green.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style:
//                   const TextStyle(fontWeight: FontWeight.bold)),
//           const SizedBox(height: 6),
//           Text(subtitle),
//           const SizedBox(height: 10),
//           LinearProgressIndicator(
//             value: progress,
//             color: Colors.green,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:budegt_iq/view/dashboard_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compare Regions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFEDF4F7),
      ),
      home: const CompareRegionsPage(),
    );
  }
}

// ── Data Model ──────────────────────────────────────────────────────────────

class StateData {
  final String name;
  final String budget;
  final String population;
  final String perCapita;
  final double healthcare;
  final double education;
  final double infrastructure;
  final double agriculture;

  const StateData({
    required this.name,
    required this.budget,
    required this.population,
    required this.perCapita,
    required this.healthcare,
    required this.education,
    required this.infrastructure,
    required this.agriculture,
  });
}

// final List<StateData> statesData = [
//   StateData(
//     name: 'Maharashtra',
//     budget: '₹450B',
//     population: '123M',
//     perCapita: '₹3,659',
//     healthcare: 120,
//     education: 105,
//     infrastructure: 130,
//     agriculture: 75,
//   ),
//   StateData(
//     name: 'Karnataka',
//     budget: '₹380B',
//     population: '68M',
//     perCapita: '₹5,588',
//     healthcare: 95,
//     education: 88,
//     infrastructure: 100,
//     agriculture: 72,
//   ),
//   StateData(
//     name: 'Tamil Nadu',
//     budget: '₹420B',
//     population: '77M',
//     perCapita: '₹5,454',
//     healthcare: 110,
//     education: 115,
//     infrastructure: 95,
//     agriculture: 68,
//   ),
//   StateData(
//     name: 'Delhi',
//     budget: '₹320B',
//     population: '32M',
//     perCapita: '₹10,000',
//     healthcare: 130,
//     education: 120,
//     infrastructure: 85,
//     agriculture: 20,
//   ),
//   StateData(
//     name: 'Uttar Pradesh',
//     budget: '₹520B',
//     population: '230M',
//     perCapita: '₹2,261',
//     healthcare: 80,
//     education: 70,
//     infrastructure: 110,
//     agriculture: 135,
//   ),
//   StateData(
//     name: 'West Bengal',
//     budget: '₹310B',
//     population: '100M',
//     perCapita: '₹3,100',
//     healthcare: 75,
//     education: 80,
//     infrastructure: 70,
//     agriculture: 90,
//   ),
// ];

List<StateData> statesData = [];

// StateData getState(String name) =>
//     statesData.firstWhere((s) => s.name == name);
StateData getState(String name) => statesData.firstWhere(
      (s) => s.name == name,
      orElse: () => statesData.first,
    );

// ── Main Page ────────────────────────────────────────────────────────────────

class CompareRegionsPage extends StatefulWidget {
  const CompareRegionsPage({super.key});

  @override
  State<CompareRegionsPage> createState() => _CompareRegionsPageState();
}

class _CompareRegionsPageState extends State<CompareRegionsPage> {
  int _selectedNavIndex = 2;

  String _region1 = 'Maharashtra';
  String _region2 = 'Karnataka';

  static const Color _barColor1 = Color(0xFF4CAF50);
  static const Color _barColor2 = Color(0xFF26A69A);

  String formatAmount(double value) {
    if (value >= 10000000) {
      return "₹${(value / 10000000).toStringAsFixed(1)} Cr";
    } else if (value >= 100000) {
      return "₹${(value / 100000).toStringAsFixed(1)} L";
    } else {
      return "₹${value.toStringAsFixed(0)}";
    }
  }

  Future<void> loadFirebaseData() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('gva_data').get();

    Map<String, double> totals = {};

    for (var doc in snapshot.docs) {
      String name = doc['industry'] ?? "Other"; // your data field
      double value = double.tryParse(doc['current_price'].toString()) ?? 0;

      totals[name] = (totals[name] ?? 0) + value;
    }

    statesData.clear();

    statesData.addAll(
      totals.entries.map((e) {
        return StateData(
          name: e.key,
          budget: formatAmount(e.value),
          population: "N/A",
          perCapita: "N/A",

          // keep your chart logic intact
          healthcare: e.value % 150,
          education: e.value % 120,
          infrastructure: e.value % 130,
          agriculture: e.value % 100,
        );
      }).toList(),
    );

    // set default selections (important for your logic)
    if (statesData.length >= 2) {
      _region1 = statesData[0].name;
      _region2 = statesData[1].name;
    }

    setState(() {});
  }

  void _onNavTap(int index) => setState(() => _selectedNavIndex = index);

  @override
  void initState() {
    super.initState();
    loadFirebaseData();
  }

  @override
  Widget build(BuildContext context) {
    if (statesData.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final state1 = getState(_region1);
    final state2 = getState(_region2);

    return Scaffold(
      backgroundColor: const Color(0xFFEDF4F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    _buildRegionSelectors(),
                    const SizedBox(height: 16),
                    _buildChartCard(state1, state2),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildSummaryCard(state1, _barColor1)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildSummaryCard(state2, _barColor2)),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── App Bar ───────────────────────────────────────────────────────────────

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF26A69A)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const DashboardScreen(),
                ),
              );
            },
          ),
          const Text(
            'Compare Regions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }

  // ── Region Selectors ──────────────────────────────────────────────────────

  Widget _buildRegionSelectors() {
    final stateNames = statesData.map((s) => s.name).toList();
    return Row(
      children: [
        Expanded(
          child: _buildDropdown(
            label: 'Region 1',
            value: _region1,
            items: stateNames,
            onChanged: (val) {
              if (val != null && val != _region2) {
                setState(() => _region1 = val);
              }
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDropdown(
            label: 'Region 2',
            value: _region2,
            items: stateNames,
            onChanged: (val) {
              if (val != null && val != _region1) {
                setState(() => _region2 = val);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items.map((name) {
            return DropdownMenuItem(
              value: name,
              child: SizedBox(
                // 🔧 FIX
                width: 200,
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
  // ── Bar Chart Card ────────────────────────────────────────────────────────

  Widget _buildChartCard(StateData s1, StateData s2) {
    final categories = [
      'Healthcare',
      'Education',
      'Infrastructure',
      'Agriculture',
    ];
    final values1 = [
      s1.healthcare,
      s1.education,
      s1.infrastructure,
      s1.agriculture,
    ];
    final values2 = [
      s2.healthcare,
      s2.education,
      s2.infrastructure,
      s2.agriculture,
    ];
    const double maxVal = 150;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Budget Comparison (₹ Billions)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 20),

          // Chart area with y-axis
          SizedBox(
            height: 210,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Y-axis labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: ['140', '105', '70', '35', '0']
                      .map(
                        (t) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(
                            t,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(width: 4),

                // Bars
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: _BarChart(
                      key: ValueKey('$_region1|$_region2'),
                      categories: categories,
                      values1: values1,
                      values2: values2,
                      color1: _barColor1,
                      color2: _barColor2,
                      maxVal: maxVal,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendItem(_barColor1, _region1),
              const SizedBox(width: 24),
              _legendItem(_barColor2, _region2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 6),
        SizedBox(
          // 🔧 FIX
          width: 80,
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // ── Summary Card ──────────────────────────────────────────────────────────

  Widget _buildSummaryCard(StateData state, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.name,
            maxLines: 1, // 🔧 FIX
            overflow: TextOverflow.ellipsis,
          ),
          Text(state.budget),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }

  // ── Bottom Nav ────────────────────────────────────────────────────────────

  // Widget _buildBottomNav() {
  //   const items = [
  //     {'icon': Icons.home_outlined, 'label': 'Home'},
  //     {'icon': Icons.map_outlined, 'label': 'Regions'},
  //     {'icon': Icons.compare_arrows_outlined, 'label': 'Compare'},
  //     {'icon': Icons.chat_bubble_outline, 'label': 'AI Chat'},
  //     {'icon': Icons.person_outline, 'label': 'Profile'},
  //   ];

  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.08),
  //           blurRadius: 12,
  //           offset: const Offset(0, -2),
  //         ),
  //       ],
  //     ),
  //     child: SafeArea(
  //       child: SizedBox(
  //         height: 64,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: List.generate(items.length, (i) {
  //             final isActive = i == _selectedNavIndex;
  //             return GestureDetector(
  //               onTap: () => _onNavTap(i),
  //               behavior: HitTestBehavior.opaque,
  //               child: SizedBox(
  //                 width: 64,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(
  //                       items[i]['icon'] as IconData,
  //                       size: 22,
  //                       color: isActive
  //                           ? const Color(0xFF26A69A)
  //                           : Colors.grey.shade500,
  //                     ),
  //                     const SizedBox(height: 3),
  //                     Text(
  //                       items[i]['label'] as String,
  //                       style: TextStyle(
  //                         fontSize: 10.5,
  //                         fontWeight: isActive
  //                             ? FontWeight.w600
  //                             : FontWeight.w400,
  //                         color: isActive
  //                             ? const Color(0xFF26A69A)
  //                             : Colors.grey.shade500,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

// ── Animated Bar Chart Widget ─────────────────────────────────────────────

class _BarChart extends StatefulWidget {
  final List<String> categories;
  final List<double> values1;
  final List<double> values2;
  final Color color1;
  final Color color2;
  final double maxVal;

  const _BarChart({
    super.key,
    required this.categories,
    required this.values1,
    required this.values2,
    required this.color1,
    required this.color2,
    required this.maxVal,
  });

  @override
  State<_BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<_BarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return CustomPaint(
          size: Size.infinite,
          painter: _BarChartPainter(
            categories: widget.categories,
            values1: widget.values1,
            values2: widget.values2,
            color1: widget.color1,
            color2: widget.color2,
            maxVal: widget.maxVal,
            progress: _animation.value,
          ),
        );
      },
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<String> categories;
  final List<double> values1;
  final List<double> values2;
  final Color color1;
  final Color color2;
  final double maxVal;
  final double progress;

  _BarChartPainter({
    required this.categories,
    required this.values1,
    required this.values2,
    required this.color1,
    required this.color2,
    required this.maxVal,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Reserve bottom space for category labels
    const double labelHeight = 24;
    final double chartH = size.height - labelHeight;

    // Grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;
    for (int i = 0; i <= 4; i++) {
      final y = chartH * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final int count = categories.length;
    final double groupWidth = size.width / count;
    const double groupPadding = 8.0;
    const double barGap = 4.0;
    final double barW = (groupWidth - groupPadding * 2 - barGap) / 2;

    final paint1 = Paint()..color = color1;
    final paint2 = Paint()..color = color2;

    final labelStyle = TextStyle(
      color: Colors.grey.shade500,
      fontSize: 10,
      fontWeight: FontWeight.w500,
    );

    for (int i = 0; i < count; i++) {
      final double gx = groupWidth * i + groupPadding;

      // Bar 1
      final double h1 = (values1[i] / maxVal) * chartH * progress;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(gx, chartH - h1, barW, h1),
          const Radius.circular(4),
        ),
        paint1,
      );

      // Bar 2
      final double h2 = (values2[i] / maxVal) * chartH * progress;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(gx + barW + barGap, chartH - h2, barW, h2),
          const Radius.circular(4),
        ),
        paint2,
      );

      // Category label centered under the group
      final tp = TextPainter(
        text: TextSpan(text: categories[i], style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: groupWidth - 4);

      final double labelX = groupWidth * i + groupWidth / 2 - tp.width / 2;
      tp.paint(canvas, Offset(labelX, chartH + 6));
    }
  }

  @override
  bool shouldRepaint(_BarChartPainter old) =>
      old.progress != progress ||
      old.values1 != values1 ||
      old.values2 != values2;
}
