// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Compare Regions',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'Roboto',
//         scaffoldBackgroundColor: const Color(0xFF0D1B2A),
//       ),
//       home: const CompareRegionsPage(),
//     );
//   }
// }

// // ── Color Constants ──────────────────────────────────────────────────────────

// const Color kNavyBg = Color(0xFF0D1B2A);
// const Color kNavyCard = Color(0xFF152236);
// const Color kNavyCardAlt = Color(0xFF1A2B40);
// const Color kNavyBorder = Color(0xFF1E3050);
// const Color kAccentTeal = Color(0xFF26A69A);
// const Color kAccentGreen = Color(0xFF4CAF50);
// const Color kAccentGreenLight = Color(0xFF66BB6A);
// const Color kTextPrimary = Color(0xFFE8F0FE);
// const Color kTextSecondary = Color(0xFF8A9BB5);

// // ── Data Model ───────────────────────────────────────────────────────────────

// class StateInfo {
//   final String name;
//   final String totalBudget;
//   final String population;
//   final String perCapita;
//   final Map<String, double> sectorBudget; // in billions

//   const StateInfo({
//     required this.name,
//     required this.totalBudget,
//     required this.population,
//     required this.perCapita,
//     required this.sectorBudget,
//   });
// }

// final List<StateInfo> allStates = [
//   StateInfo(
//     name: 'Maharashtra',
//     totalBudget: '₹450B',
//     population: '123M',
//     perCapita: '₹3,659',
//     sectorBudget: {
//       'Healthcare': 125.0,
//       'Education': 110.0,
//       'Infrastructure': 130.0,
//       'Agriculture': 85.0,
//     },
//   ),
//   StateInfo(
//     name: 'Karnataka',
//     totalBudget: '₹380B',
//     population: '68M',
//     perCapita: '₹5,588',
//     sectorBudget: {
//       'Healthcare': 95.0,
//       'Education': 105.0,
//       'Infrastructure': 115.0,
//       'Agriculture': 65.0,
//     },
//   ),
//   StateInfo(
//     name: 'Tamil Nadu',
//     totalBudget: '₹420B',
//     population: '77M',
//     perCapita: '₹5,454',
//     sectorBudget: {
//       'Healthcare': 110.0,
//       'Education': 120.0,
//       'Infrastructure': 105.0,
//       'Agriculture': 85.0,
//     },
//   ),
//   StateInfo(
//     name: 'Delhi',
//     totalBudget: '₹320B',
//     population: '32M',
//     perCapita: '₹10,000',
//     sectorBudget: {
//       'Healthcare': 90.0,
//       'Education': 95.0,
//       'Infrastructure': 80.0,
//       'Agriculture': 55.0,
//     },
//   ),
//   StateInfo(
//     name: 'Uttar Pradesh',
//     totalBudget: '₹520B',
//     population: '230M',
//     perCapita: '₹2,261',
//     sectorBudget: {
//       'Healthcare': 140.0,
//       'Education': 130.0,
//       'Infrastructure': 150.0,
//       'Agriculture': 100.0,
//     },
//   ),
//   StateInfo(
//     name: 'West Bengal',
//     totalBudget: '₹310B',
//     population: '100M',
//     perCapita: '₹3,100',
//     sectorBudget: {
//       'Healthcare': 80.0,
//       'Education': 85.0,
//       'Infrastructure': 90.0,
//       'Agriculture': 55.0,
//     },
//   ),
// ];

// // ── Main Page ─────────────────────────────────────────────────────────────────

// class CompareRegionsPage extends StatefulWidget {
//   const CompareRegionsPage({super.key});

//   @override
//   State<CompareRegionsPage> createState() => _CompareRegionsPageState();
// }

// class _CompareRegionsPageState extends State<CompareRegionsPage>
//     with TickerProviderStateMixin {
//   int _selectedNavIndex = 2; // Compare tab active

//   StateInfo _region1 = allStates[0]; // Maharashtra
//   StateInfo _region2 = allStates[1]; // Karnataka

//   late AnimationController _barAnimController;
//   late Animation<double> _barAnim;

//   @override
//   void initState() {
//     super.initState();
//     _barAnimController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//     _barAnim = CurvedAnimation(
//       parent: _barAnimController,
//       curve: Curves.easeOutCubic,
//     );
//     _barAnimController.forward();
//   }

//   @override
//   void dispose() {
//     _barAnimController.dispose();
//     super.dispose();
//   }

//   void _onRegion1Changed(StateInfo? state) {
//     if (state == null) return;
//     setState(() => _region1 = state);
//     _barAnimController.forward(from: 0);
//   }

//   void _onRegion2Changed(StateInfo? state) {
//     if (state == null) return;
//     setState(() => _region2 = state);
//     _barAnimController.forward(from: 0);
//   }

//   void _onNavTap(int index) => setState(() => _selectedNavIndex = index);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kNavyBg,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildAppBar(),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 8,
//                 ),
//                 child: Column(
//                   children: [
//                     _buildDropdownRow(),
//                     const SizedBox(height: 16),
//                     _buildChartCard(),
//                     const SizedBox(height: 16),
//                     _buildSummaryRow(),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNav(),
//     );
//   }

//   // ── App Bar ───────────────────────────────────────────────────────────────

//   Widget _buildAppBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: kAccentTeal),
//             onPressed: () {},
//           ),
//           const Text(
//             'Compare Regions',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w700,
//               color: kTextPrimary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Dropdown Row ──────────────────────────────────────────────────────────

//   Widget _buildDropdownRow() {
//     return Row(
//       children: [
//         Expanded(
//           child: _buildDropdownCard('Region 1', _region1, _onRegion1Changed),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: _buildDropdownCard('Region 2', _region2, _onRegion2Changed),
//         ),
//       ],
//     );
//   }

//   Widget _buildDropdownCard(
//     String label,
//     StateInfo selected,
//     ValueChanged<StateInfo?> onChanged,
//   ) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       decoration: BoxDecoration(
//         color: kNavyCard,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: kNavyBorder, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 11,
//               color: kTextSecondary,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 6),
//           DropdownButtonHideUnderline(
//             child: DropdownButton<StateInfo>(
//               value: selected,
//               isExpanded: true,
//               dropdownColor: kNavyCard,
//               iconEnabledColor: kTextSecondary,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: kTextPrimary,
//                 fontFamily: 'Roboto',
//               ),
//               items: allStates.map((s) {
//                 return DropdownMenuItem<StateInfo>(
//                   value: s,
//                   child: Text(
//                     s.name,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: selected.name == s.name
//                           ? kAccentTeal
//                           : kTextPrimary,
//                       fontWeight: selected.name == s.name
//                           ? FontWeight.w700
//                           : FontWeight.w400,
//                     ),
//                   ),
//                 );
//               }).toList(),
//               selectedItemBuilder: (context) => allStates
//                   .map(
//                     (s) => Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         s.name,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: kTextPrimary,
//                         ),
//                       ),
//                     ),
//                   )
//                   .toList(),
//               onChanged: onChanged,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Chart Card ────────────────────────────────────────────────────────────

//   Widget _buildChartCard() {
//     const sectors = [
//       'Healthcare',
//       'Education',
//       'Infrastructure',
//       'Agriculture',
//     ];
//     final maxVal = sectors.fold<double>(0, (prev, s) {
//       final v1 = _region1.sectorBudget[s] ?? 0;
//       final v2 = _region2.sectorBudget[s] ?? 0;
//       return [prev, v1, v2].reduce((a, b) => a > b ? a : b);
//     });

//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
//       decoration: BoxDecoration(
//         color: kNavyCard,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: kNavyBorder, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Budget Comparison (₹ Billions)',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: kTextPrimary,
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Y-axis labels + bars
//           AnimatedBuilder(
//             animation: _barAnim,
//             builder: (context, _) {
//               return _buildBarChart(sectors, maxVal);
//             },
//           ),

//           const SizedBox(height: 16),

//           // Legend
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildLegendDot(kAccentGreen, _region1.name),
//               const SizedBox(width: 20),
//               _buildLegendDot(kAccentGreenLight, _region2.name),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBarChart(List<String> sectors, double maxVal) {
//     // Y-axis steps: 0, 35, 70, 105, 140
//     final ySteps = [140, 105, 70, 35, 0];
//     const chartHeight = 180.0;
//     const yLabelWidth = 36.0;

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Y-axis labels
//         SizedBox(
//           width: yLabelWidth,
//           height: chartHeight + 24,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: ySteps
//                 .map(
//                   (v) => Text(
//                     '$v',
//                     style: const TextStyle(fontSize: 10, color: kTextSecondary),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),

//         // Chart area
//         Expanded(
//           child: Column(
//             children: [
//               // Bars + gridlines
//               SizedBox(
//                 height: chartHeight,
//                 child: Stack(
//                   children: [
//                     // Horizontal gridlines
//                     ...List.generate(5, (i) {
//                       return Positioned(
//                         top: (chartHeight / 4) * i,
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           height: 1,
//                           color: kNavyBorder.withOpacity(0.6),
//                         ),
//                       );
//                     }),

//                     // Bar groups
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: sectors.map((sector) {
//                         final v1 = _region1.sectorBudget[sector] ?? 0;
//                         final v2 = _region2.sectorBudget[sector] ?? 0;
//                         final h1 =
//                             (v1 / (maxVal == 0 ? 1 : maxVal)) *
//                             chartHeight *
//                             _barAnim.value;
//                         final h2 =
//                             (v2 / (maxVal == 0 ? 1 : maxVal)) *
//                             chartHeight *
//                             _barAnim.value;

//                         return Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             _buildBar(h1, kAccentGreen),
//                             const SizedBox(width: 4),
//                             _buildBar(h2, kAccentGreenLight),
//                           ],
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 8),

//               // X-axis labels
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: sectors
//                     .map(
//                       (s) => Text(
//                         s,
//                         style: const TextStyle(
//                           fontSize: 10.5,
//                           color: kTextSecondary,
//                         ),
//                       ),
//                     )
//                     .toList(),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBar(double height, Color color) {
//     return Container(
//       width: 22,
//       height: height.clamp(2.0, double.infinity),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
//       ),
//     );
//   }

//   Widget _buildLegendDot(Color color, String label) {
//     return Row(
//       children: [
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(3),
//           ),
//         ),
//         const SizedBox(width: 6),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 12,
//             color: kTextSecondary,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }

//   // ── Summary Row ───────────────────────────────────────────────────────────

//   Widget _buildSummaryRow() {
//     return Row(
//       children: [
//         Expanded(child: _buildSummaryCard(_region1)),
//         const SizedBox(width: 12),
//         Expanded(child: _buildSummaryCard(_region2)),
//       ],
//     );
//   }

//   Widget _buildSummaryCard(StateInfo state) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       decoration: BoxDecoration(
//         color: kNavyCard,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: kNavyBorder, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             state.name,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: kTextPrimary,
//             ),
//           ),
//           const SizedBox(height: 12),
//           _buildSummaryRow2('Total Budget', state.totalBudget),
//           const SizedBox(height: 8),
//           _buildSummaryRow2('Population', state.population),
//           const SizedBox(height: 8),
//           _buildSummaryRow2('Per Capita', state.perCapita),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryRow2(String label, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 12, color: kTextSecondary),
//         ),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w700,
//             color: kTextPrimary,
//           ),
//         ),
//       ],
//     );
//   }

//   // ── Bottom Nav ────────────────────────────────────────────────────────────

//   Widget _buildBottomNav() {
//     const items = [
//       {'icon': Icons.home_outlined, 'label': 'Home'},
//       {'icon': Icons.map_outlined, 'label': 'Regions'},
//       {'icon': Icons.compare_arrows_outlined, 'label': 'Compare'},
//       {'icon': Icons.chat_bubble_outline, 'label': 'AI Chat'},
//       {'icon': Icons.person_outline, 'label': 'Profile'},
//     ];

//     return Container(
//       decoration: BoxDecoration(
//         color: kNavyCard,
//         border: Border(top: BorderSide(color: kNavyBorder, width: 1)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 16,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: SizedBox(
//           height: 64,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: List.generate(items.length, (i) {
//               final isActive = i == _selectedNavIndex;
//               return GestureDetector(
//                 onTap: () => _onNavTap(i),
//                 behavior: HitTestBehavior.opaque,
//                 child: SizedBox(
//                   width: 64,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         items[i]['icon'] as IconData,
//                         size: 22,
//                         color: isActive ? kAccentTeal : kTextSecondary,
//                       ),
//                       const SizedBox(height: 3),
//                       Text(
//                         items[i]['label'] as String,
//                         style: TextStyle(
//                           fontSize: 10.5,
//                           fontWeight: isActive
//                               ? FontWeight.w600
//                               : FontWeight.w400,
//                           color: isActive ? kAccentTeal : kTextSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }

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

final List<StateData> statesData = [
  StateData(
    name: 'Maharashtra',
    budget: '₹450B',
    population: '123M',
    perCapita: '₹3,659',
    healthcare: 120,
    education: 105,
    infrastructure: 130,
    agriculture: 75,
  ),
  StateData(
    name: 'Karnataka',
    budget: '₹380B',
    population: '68M',
    perCapita: '₹5,588',
    healthcare: 95,
    education: 88,
    infrastructure: 100,
    agriculture: 72,
  ),
  StateData(
    name: 'Tamil Nadu',
    budget: '₹420B',
    population: '77M',
    perCapita: '₹5,454',
    healthcare: 110,
    education: 115,
    infrastructure: 95,
    agriculture: 68,
  ),
  StateData(
    name: 'Delhi',
    budget: '₹320B',
    population: '32M',
    perCapita: '₹10,000',
    healthcare: 130,
    education: 120,
    infrastructure: 85,
    agriculture: 20,
  ),
  StateData(
    name: 'Uttar Pradesh',
    budget: '₹520B',
    population: '230M',
    perCapita: '₹2,261',
    healthcare: 80,
    education: 70,
    infrastructure: 110,
    agriculture: 135,
  ),
  StateData(
    name: 'West Bengal',
    budget: '₹310B',
    population: '100M',
    perCapita: '₹3,100',
    healthcare: 75,
    education: 80,
    infrastructure: 70,
    agriculture: 90,
  ),
];

StateData getState(String name) => statesData.firstWhere((s) => s.name == name);

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

  void _onNavTap(int index) => setState(() => _selectedNavIndex = index);

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: _buildBottomNav(),
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
            onPressed: () {},
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF1A1A2E),
                size: 20,
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A2E),
              ),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              items: items
                  .map(
                    (name) => DropdownMenuItem(
                      value: name,
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
              selectedItemBuilder: (context) => items
                  .map(
                    (name) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A2E),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
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
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }

  // ── Summary Card ──────────────────────────────────────────────────────────

  Widget _buildSummaryCard(StateData state, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 10),
          _summaryRow('Total Budget', state.budget),
          const SizedBox(height: 6),
          _summaryRow('Population', state.population),
          const SizedBox(height: 6),
          _summaryRow('Per Capita', state.perCapita),
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

  Widget _buildBottomNav() {
    const items = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.map_outlined, 'label': 'Regions'},
      {'icon': Icons.compare_arrows_outlined, 'label': 'Compare'},
      {'icon': Icons.chat_bubble_outline, 'label': 'AI Chat'},
      {'icon': Icons.person_outline, 'label': 'Profile'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final isActive = i == _selectedNavIndex;
              return GestureDetector(
                onTap: () => _onNavTap(i),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 64,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items[i]['icon'] as IconData,
                        size: 22,
                        color: isActive
                            ? const Color(0xFF26A69A)
                            : Colors.grey.shade500,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        items[i]['label'] as String,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isActive
                              ? const Color(0xFF26A69A)
                              : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
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
