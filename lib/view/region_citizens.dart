// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Region Analysis',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'Roboto',
//         scaffoldBackgroundColor: const Color(0xFFEDF4F7),
//       ),
//       home: const RegionAnalysisPage(),
//     );
//   }
// }

// // ── Data Model ──────────────────────────────────────────────────────────────

// class StateData {
//   final String name;
//   final String budget;
//   final String population;
//   final String perCapita;
//   final String growth;
//   final bool growthPositive;
//   final Color pinColor;

//   const StateData({
//     required this.name,
//     required this.budget,
//     required this.population,
//     required this.perCapita,
//     required this.growth,
//     required this.growthPositive,
//     required this.pinColor,
//   });
// }

// final List<StateData> statesData = [
//   StateData(
//     name: 'Maharashtra',
//     budget: '₹450B',
//     population: '123M',
//     perCapita: '₹3659',
//     growth: '+12%',
//     growthPositive: true,
//     pinColor: const Color(0xFF26A69A),
//   ),
//   StateData(
//     name: 'Karnataka',
//     budget: '₹380B',
//     population: '68M',
//     perCapita: '₹5588',
//     growth: '+9%',
//     growthPositive: true,
//     pinColor: const Color(0xFF66BB6A),
//   ),
//   StateData(
//     name: 'Tamil Nadu',
//     budget: '₹420B',
//     population: '77M',
//     perCapita: '₹5454',
//     growth: '+11%',
//     growthPositive: true,
//     pinColor: const Color(0xFF5C6BC0),
//   ),
//   StateData(
//     name: 'Delhi',
//     budget: '₹320B',
//     population: '32M',
//     perCapita: '₹10000',
//     growth: '+8%',
//     growthPositive: true,
//     pinColor: const Color(0xFFFFCA28),
//   ),
//   StateData(
//     name: 'Uttar Pradesh',
//     budget: '₹520B',
//     population: '230M',
//     perCapita: '₹2261',
//     growth: '-3%',
//     growthPositive: false,
//     pinColor: const Color(0xFFEF5350),
//   ),
//   StateData(
//     name: 'West Bengal',
//     budget: '₹310B',
//     population: '100M',
//     perCapita: '₹3100',
//     growth: '+5%',
//     growthPositive: true,
//     pinColor: const Color(0xFFAB47BC),
//   ),
// ];

// // ── Main Page ────────────────────────────────────────────────────────────────

// class RegionAnalysisPage extends StatefulWidget {
//   const RegionAnalysisPage({super.key});

//   @override
//   State<RegionAnalysisPage> createState() => _RegionAnalysisPageState();
// }

// class _RegionAnalysisPageState extends State<RegionAnalysisPage> {
//   int _selectedIndex = 1; // Regions tab active
//   StateData? _selectedState = statesData[0]; // Maharashtra selected by default

//   void _onStateSelected(StateData state) {
//     setState(() {
//       if (_selectedState?.name == state.name) {
//         _selectedState = null; // toggle off
//       } else {
//         _selectedState = state;
//       }
//     });
//   }

//   void _onNavTap(int index) {
//     setState(() => _selectedIndex = index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEDF4F7),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // ── App Bar ──
//             _buildAppBar(),

//             // ── Scrollable Content ──
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 8,
//                 ),
//                 child: Column(
//                   children: [
//                     // Heatmap Card
//                     _buildHeatmapCard(),
//                     const SizedBox(height: 16),

//                     // Detail Card (animated)
//                     AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 300),
//                       transitionBuilder: (child, animation) {
//                         return FadeTransition(
//                           opacity: animation,
//                           child: SlideTransition(
//                             position: Tween<Offset>(
//                               begin: const Offset(0, 0.08),
//                               end: Offset.zero,
//                             ).animate(animation),
//                             child: child,
//                           ),
//                         );
//                       },
//                       child: _selectedState != null
//                           ? _buildDetailCard(_selectedState!)
//                           : const SizedBox.shrink(),
//                     ),

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

//   // ── App Bar ──────────────────────────────────────────────────────────────

//   Widget _buildAppBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: Color(0xFF26A69A)),
//             onPressed: () {},
//           ),
//           const Text(
//             'Region Analysis',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF1A1A2E),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Heatmap Card ─────────────────────────────────────────────────────────

//   Widget _buildHeatmapCard() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Title
//           const Padding(
//             padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
//             child: Text(
//               'India Budget Heatmap',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xFF1A1A2E),
//               ),
//             ),
//           ),

//           // Grid of state tiles inside a gradient container
//           Container(
//             margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
//               ),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: statesData.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//                 childAspectRatio: 2.6,
//               ),
//               itemBuilder: (context, index) {
//                 final state = statesData[index];
//                 final isSelected = _selectedState?.name == state.name;
//                 return _buildStateTile(state, isSelected);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStateTile(StateData state, bool isSelected) {
//     return GestureDetector(
//       onTap: () => _onStateSelected(state),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//           color: isSelected ? state.pinColor.withOpacity(0.12) : Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border(left: BorderSide(color: state.pinColor, width: 3.5)),
//           boxShadow: isSelected
//               ? [
//                   BoxShadow(
//                     color: state.pinColor.withOpacity(0.25),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ]
//               : [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//           child: Row(
//             children: [
//               Icon(Icons.location_on, color: state.pinColor, size: 20),
//               const SizedBox(width: 6),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       state.name,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF1A1A2E),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Text(
//                       state.budget,
//                       style: TextStyle(
//                         fontSize: 11.5,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ── Detail Card ───────────────────────────────────────────────────────────

//   Widget _buildDetailCard(StateData state) {
//     return Container(
//       key: ValueKey(state.name),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header row
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 18, 16, 4),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       state.name,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xFF1A1A2E),
//                       ),
//                     ),
//                     const Text(
//                       'State Budget Overview',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.close, color: Colors.grey, size: 20),
//                   onPressed: () => setState(() => _selectedState = null),
//                 ),
//               ],
//             ),
//           ),

//           // Stats grid
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildStatBox(
//                         label: 'Total Budget',
//                         value: state.budget,
//                         bgColor: const Color(0xFFF0F4FF),
//                         valueColor: const Color(0xFF1A1A2E),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: _buildStatBox(
//                         label: 'Population',
//                         value: state.population,
//                         bgColor: const Color(0xFFF0FFF4),
//                         valueColor: const Color(0xFF1A1A2E),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildStatBox(
//                         label: 'Per Capita',
//                         value: state.perCapita,
//                         bgColor: const Color(0xFFF5F5FF),
//                         valueColor: const Color(0xFF1A1A2E),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: _buildStatBox(
//                         label: 'Growth',
//                         value: state.growth,
//                         bgColor: const Color(0xFFFFF0F8),
//                         valueColor: state.growthPositive
//                             ? const Color(0xFF2E7D32)
//                             : const Color(0xFFC62828),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatBox({
//     required String label,
//     required String value,
//     required Color bgColor,
//     required Color valueColor,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey.shade600,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w700,
//               color: valueColor,
//             ),
//           ),
//         ],
//       ),
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
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: SizedBox(
//           height: 64,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: List.generate(items.length, (i) {
//               final isActive = i == _selectedIndex;
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
//                         color: isActive
//                             ? const Color(0xFF26A69A)
//                             : Colors.grey.shade500,
//                       ),
//                       const SizedBox(height: 3),
//                       Text(
//                         items[i]['label'] as String,
//                         style: TextStyle(
//                           fontSize: 10.5,
//                           fontWeight: isActive
//                               ? FontWeight.w600
//                               : FontWeight.w400,
//                           color: isActive
//                               ? const Color(0xFF26A69A)
//                               : Colors.grey.shade500,
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

// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Region Analysis',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         fontFamily: 'Roboto',
// //         scaffoldBackgroundColor: const Color(0xFF0D1B2A),
// //       ),
// //       home: const RegionAnalysisPage(),
// //     );
// //   }
// // }

// // // ── Color Constants ──────────────────────────────────────────────────────────

// // const Color kNavyBg = Color(0xFF0D1B2A);
// // const Color kNavyCard = Color(0xFF152236);
// // const Color kNavyCardAlt = Color(0xFF1A2B40);
// // const Color kNavyBorder = Color(0xFF1E3050);
// // const Color kAccentTeal = Color(0xFF26A69A);
// // const Color kAccentPurple = Color(0xFF7C3AED);
// // const Color kTextPrimary = Color(0xFFE8F0FE);
// // const Color kTextSecondary = Color(0xFF8A9BB5);

// // // ── Data Model ──────────────────────────────────────────────────────────────

// // class StateData {
// //   final String name;
// //   final String budget;
// //   final String population;
// //   final String perCapita;
// //   final String growth;
// //   final bool growthPositive;
// //   final Color pinColor;

// //   const StateData({
// //     required this.name,
// //     required this.budget,
// //     required this.population,
// //     required this.perCapita,
// //     required this.growth,
// //     required this.growthPositive,
// //     required this.pinColor,
// //   });
// // }

// // final List<StateData> statesData = [
// //   StateData(
// //     name: 'Maharashtra',
// //     budget: '₹450B',
// //     population: '123M',
// //     perCapita: '₹3659',
// //     growth: '+12%',
// //     growthPositive: true,
// //     pinColor: const Color(0xFF26A69A),
// //   ),
// //   StateData(
// //     name: 'Karnataka',
// //     budget: '₹380B',
// //     population: '68M',
// //     perCapita: '₹5588',
// //     growth: '+9%',
// //     growthPositive: true,
// //     pinColor: const Color(0xFF66BB6A),
// //   ),
// //   StateData(
// //     name: 'Tamil Nadu',
// //     budget: '₹420B',
// //     population: '77M',
// //     perCapita: '₹5454',
// //     growth: '+11%',
// //     growthPositive: true,
// //     pinColor: const Color(0xFF5C6BC0),
// //   ),
// //   StateData(
// //     name: 'Delhi',
// //     budget: '₹320B',
// //     population: '32M',
// //     perCapita: '₹10000',
// //     growth: '+8%',
// //     growthPositive: true,
// //     pinColor: const Color(0xFFFFCA28),
// //   ),
// //   StateData(
// //     name: 'Uttar Pradesh',
// //     budget: '₹520B',
// //     population: '230M',
// //     perCapita: '₹2261',
// //     growth: '-3%',
// //     growthPositive: false,
// //     pinColor: const Color(0xFFEF5350),
// //   ),
// //   StateData(
// //     name: 'West Bengal',
// //     budget: '₹310B',
// //     population: '100M',
// //     perCapita: '₹3100',
// //     growth: '+5%',
// //     growthPositive: true,
// //     pinColor: const Color(0xFFAB47BC),
// //   ),
// // ];

// // // ── Main Page ────────────────────────────────────────────────────────────────

// // class RegionAnalysisPage extends StatefulWidget {
// //   const RegionAnalysisPage({super.key});

// //   @override
// //   State<RegionAnalysisPage> createState() => _RegionAnalysisPageState();
// // }

// // class _RegionAnalysisPageState extends State<RegionAnalysisPage> {
// //   int _selectedIndex = 1; // Regions tab active
// //   StateData? _selectedState = statesData[0]; // Maharashtra selected by default

// //   void _onStateSelected(StateData state) {
// //     setState(() {
// //       if (_selectedState?.name == state.name) {
// //         _selectedState = null; // toggle off
// //       } else {
// //         _selectedState = state;
// //       }
// //     });
// //   }

// //   void _onNavTap(int index) {
// //     setState(() => _selectedIndex = index);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: kNavyBg,
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             // ── App Bar ──
// //             _buildAppBar(),

// //             // ── Scrollable Content ──
// //             Expanded(
// //               child: SingleChildScrollView(
// //                 padding: const EdgeInsets.symmetric(
// //                   horizontal: 16,
// //                   vertical: 8,
// //                 ),
// //                 child: Column(
// //                   children: [
// //                     // Heatmap Card
// //                     _buildHeatmapCard(),
// //                     const SizedBox(height: 16),

// //                     // Detail Card (animated)
// //                     AnimatedSwitcher(
// //                       duration: const Duration(milliseconds: 300),
// //                       transitionBuilder: (child, animation) {
// //                         return FadeTransition(
// //                           opacity: animation,
// //                           child: SlideTransition(
// //                             position: Tween<Offset>(
// //                               begin: const Offset(0, 0.08),
// //                               end: Offset.zero,
// //                             ).animate(animation),
// //                             child: child,
// //                           ),
// //                         );
// //                       },
// //                       child: _selectedState != null
// //                           ? _buildDetailCard(_selectedState!)
// //                           : const SizedBox.shrink(),
// //                     ),

// //                     const SizedBox(height: 16),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       bottomNavigationBar: _buildBottomNav(),
// //     );
// //   }

// //   // ── App Bar ──────────────────────────────────────────────────────────────

// //   Widget _buildAppBar() {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
// //       child: Row(
// //         children: [
// //           IconButton(
// //             icon: const Icon(Icons.arrow_back, color: kAccentTeal),
// //             onPressed: () {},
// //           ),
// //           const Text(
// //             'Region Analysis',
// //             style: TextStyle(
// //               fontSize: 22,
// //               fontWeight: FontWeight.w700,
// //               color: kTextPrimary,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // ── Heatmap Card ─────────────────────────────────────────────────────────

// //   Widget _buildHeatmapCard() {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: kNavyCard,
// //         borderRadius: BorderRadius.circular(20),
// //         border: Border.all(color: kNavyBorder, width: 1),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.3),
// //             blurRadius: 16,
// //             offset: const Offset(0, 6),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // Title
// //           const Padding(
// //             padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
// //             child: Text(
// //               'India Budget Heatmap',
// //               style: TextStyle(
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.w700,
// //                 color: kTextPrimary,
// //               ),
// //             ),
// //           ),

// //           // Grid of state tiles inside a gradient container
// //           Container(
// //             margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
// //             padding: const EdgeInsets.all(14),
// //             decoration: BoxDecoration(
// //               gradient: const LinearGradient(
// //                 begin: Alignment.topLeft,
// //                 end: Alignment.bottomRight,
// //                 colors: [Color(0xFF0F2035), Color(0xFF162840)],
// //               ),
// //               borderRadius: BorderRadius.circular(16),
// //               border: Border.all(color: kNavyBorder, width: 1),
// //             ),
// //             child: GridView.builder(
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               itemCount: statesData.length,
// //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 2,
// //                 mainAxisSpacing: 10,
// //                 crossAxisSpacing: 10,
// //                 childAspectRatio: 2.6,
// //               ),
// //               itemBuilder: (context, index) {
// //                 final state = statesData[index];
// //                 final isSelected = _selectedState?.name == state.name;
// //                 return _buildStateTile(state, isSelected);
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildStateTile(StateData state, bool isSelected) {
// //     return GestureDetector(
// //       onTap: () => _onStateSelected(state),
// //       child: AnimatedContainer(
// //         duration: const Duration(milliseconds: 200),
// //         decoration: BoxDecoration(
// //           color: isSelected ? state.pinColor.withOpacity(0.15) : kNavyCardAlt,
// //           borderRadius: BorderRadius.circular(12),
// //           border: Border(left: BorderSide(color: state.pinColor, width: 3.5)),
// //           boxShadow: isSelected
// //               ? [
// //                   BoxShadow(
// //                     color: state.pinColor.withOpacity(0.3),
// //                     blurRadius: 10,
// //                     offset: const Offset(0, 3),
// //                   ),
// //                 ]
// //               : [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.2),
// //                     blurRadius: 4,
// //                     offset: const Offset(0, 2),
// //                   ),
// //                 ],
// //         ),
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
// //           child: Row(
// //             children: [
// //               Icon(Icons.location_on, color: state.pinColor, size: 20),
// //               const SizedBox(width: 6),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Text(
// //                       state.name,
// //                       style: const TextStyle(
// //                         fontSize: 13,
// //                         fontWeight: FontWeight.w600,
// //                         color: kTextPrimary,
// //                       ),
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                     Text(
// //                       state.budget,
// //                       style: const TextStyle(
// //                         fontSize: 11.5,
// //                         color: kTextSecondary,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // ── Detail Card ───────────────────────────────────────────────────────────

// //   Widget _buildDetailCard(StateData state) {
// //     return Container(
// //       key: ValueKey(state.name),
// //       decoration: BoxDecoration(
// //         color: kNavyCard,
// //         borderRadius: BorderRadius.circular(20),
// //         border: Border.all(color: kNavyBorder, width: 1),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.3),
// //             blurRadius: 16,
// //             offset: const Offset(0, 6),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // Header row
// //           Padding(
// //             padding: const EdgeInsets.fromLTRB(20, 18, 16, 4),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       state.name,
// //                       style: const TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.w700,
// //                         color: kTextPrimary,
// //                       ),
// //                     ),
// //                     const Text(
// //                       'State Budget Overview',
// //                       style: TextStyle(
// //                         fontSize: 13,
// //                         color: kTextSecondary,
// //                         fontWeight: FontWeight.w400,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 IconButton(
// //                   icon: const Icon(
// //                     Icons.close,
// //                     color: kTextSecondary,
// //                     size: 20,
// //                   ),
// //                   onPressed: () => setState(() => _selectedState = null),
// //                 ),
// //               ],
// //             ),
// //           ),

// //           // Stats grid
// //           Padding(
// //             padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
// //             child: Column(
// //               children: [
// //                 Row(
// //                   children: [
// //                     Expanded(
// //                       child: _buildStatBox(
// //                         label: 'Total Budget',
// //                         value: state.budget,
// //                         bgColor: const Color(0xFF1A2B40),
// //                         valueColor: kTextPrimary,
// //                         accentColor: const Color(0xFF5C6BC0),
// //                       ),
// //                     ),
// //                     const SizedBox(width: 12),
// //                     Expanded(
// //                       child: _buildStatBox(
// //                         label: 'Population',
// //                         value: state.population,
// //                         bgColor: const Color(0xFF1A2B40),
// //                         valueColor: kTextPrimary,
// //                         accentColor: const Color(0xFF26A69A),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 12),
// //                 Row(
// //                   children: [
// //                     Expanded(
// //                       child: _buildStatBox(
// //                         label: 'Per Capita',
// //                         value: state.perCapita,
// //                         bgColor: const Color(0xFF1A2B40),
// //                         valueColor: kTextPrimary,
// //                         accentColor: const Color(0xFFAB47BC),
// //                       ),
// //                     ),
// //                     const SizedBox(width: 12),
// //                     Expanded(
// //                       child: _buildStatBox(
// //                         label: 'Growth',
// //                         value: state.growth,
// //                         bgColor: const Color(0xFF1A2B40),
// //                         valueColor: state.growthPositive
// //                             ? const Color(0xFF4CAF50)
// //                             : const Color(0xFFEF5350),
// //                         accentColor: state.growthPositive
// //                             ? const Color(0xFF4CAF50)
// //                             : const Color(0xFFEF5350),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildStatBox({
// //     required String label,
// //     required String value,
// //     required Color bgColor,
// //     required Color valueColor,
// //     required Color accentColor,
// //   }) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //       decoration: BoxDecoration(
// //         color: bgColor,
// //         borderRadius: BorderRadius.circular(14),
// //         border: Border(
// //           top: BorderSide(color: accentColor.withOpacity(0.5), width: 1.5),
// //         ),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             label,
// //             style: const TextStyle(
// //               fontSize: 12,
// //               color: kTextSecondary,
// //               fontWeight: FontWeight.w500,
// //             ),
// //           ),
// //           const SizedBox(height: 6),
// //           Text(
// //             value,
// //             style: TextStyle(
// //               fontSize: 22,
// //               fontWeight: FontWeight.w700,
// //               color: valueColor,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // ── Bottom Nav ────────────────────────────────────────────────────────────

// //   Widget _buildBottomNav() {
// //     const items = [
// //       {'icon': Icons.home_outlined, 'label': 'Home'},
// //       {'icon': Icons.map_outlined, 'label': 'Regions'},
// //       {'icon': Icons.compare_arrows_outlined, 'label': 'Compare'},
// //       {'icon': Icons.chat_bubble_outline, 'label': 'AI Chat'},
// //       {'icon': Icons.person_outline, 'label': 'Profile'},
// //     ];

// //     return Container(
// //       decoration: BoxDecoration(
// //         color: kNavyCard,
// //         border: Border(top: BorderSide(color: kNavyBorder, width: 1)),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.3),
// //             blurRadius: 16,
// //             offset: const Offset(0, -4),
// //           ),
// //         ],
// //       ),
// //       child: SafeArea(
// //         child: SizedBox(
// //           height: 64,
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceAround,
// //             children: List.generate(items.length, (i) {
// //               final isActive = i == _selectedIndex;
// //               return GestureDetector(
// //                 onTap: () => _onNavTap(i),
// //                 behavior: HitTestBehavior.opaque,
// //                 child: SizedBox(
// //                   width: 64,
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Icon(
// //                         items[i]['icon'] as IconData,
// //                         size: 22,
// //                         color: isActive ? kAccentTeal : kTextSecondary,
// //                       ),
// //                       const SizedBox(height: 3),
// //                       Text(
// //                         items[i]['label'] as String,
// //                         style: TextStyle(
// //                           fontSize: 10.5,
// //                           fontWeight: isActive
// //                               ? FontWeight.w600
// //                               : FontWeight.w400,
// //                           color: isActive ? kAccentTeal : kTextSecondary,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             }),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';

// ── Data Model ──────────────────────────────────────────────────────────────

class StateData {
  final String name;
  final String budget;
  final String population;
  final String perCapita;
  final String growth;
  final bool growthPositive;
  final Color pinColor;

  const StateData({
    required this.name,
    required this.budget,
    required this.population,
    required this.perCapita,
    required this.growth,
    required this.growthPositive,
    required this.pinColor,
  });
}

final List<StateData> statesData = [
  StateData(
    name: 'Maharashtra',
    budget: '₹450B',
    population: '123M',
    perCapita: '₹3659',
    growth: '+12%',
    growthPositive: true,
    pinColor: const Color(0xFF26A69A),
  ),
  StateData(
    name: 'Karnataka',
    budget: '₹380B',
    population: '68M',
    perCapita: '₹5588',
    growth: '+9%',
    growthPositive: true,
    pinColor: const Color(0xFF66BB6A),
  ),
  StateData(
    name: 'Tamil Nadu',
    budget: '₹420B',
    population: '77M',
    perCapita: '₹5454',
    growth: '+11%',
    growthPositive: true,
    pinColor: const Color(0xFF5C6BC0),
  ),
  StateData(
    name: 'Delhi',
    budget: '₹320B',
    population: '32M',
    perCapita: '₹10000',
    growth: '+8%',
    growthPositive: true,
    pinColor: const Color(0xFFFFCA28),
  ),
  StateData(
    name: 'Uttar Pradesh',
    budget: '₹520B',
    population: '230M',
    perCapita: '₹2261',
    growth: '-3%',
    growthPositive: false,
    pinColor: const Color(0xFFEF5350),
  ),
  StateData(
    name: 'West Bengal',
    budget: '₹310B',
    population: '100M',
    perCapita: '₹3100',
    growth: '+5%',
    growthPositive: true,
    pinColor: const Color(0xFFAB47BC),
  ),
];

// ── Main Page ────────────────────────────────────────────────────────────────

class RegionAnalysisPage extends StatefulWidget {
  const RegionAnalysisPage({super.key});

  @override
  State<RegionAnalysisPage> createState() => _RegionAnalysisPageState();
}

class _RegionAnalysisPageState extends State<RegionAnalysisPage> {
  int _selectedIndex = 1;
  StateData? _selectedState = statesData[0];

  void _onStateSelected(StateData state) {
    setState(() {
      if (_selectedState?.name == state.name) {
        _selectedState = null;
      } else {
        _selectedState = state;
      }
    });
  }

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 WillPopScope ensures system back button navigates back to home_screen
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
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
                      _buildHeatmapCard(),
                      const SizedBox(height: 16),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.08),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: _selectedState != null
                            ? _buildDetailCard(_selectedState!)
                            : const SizedBox.shrink(),
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
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          // 🔥 Back button navigates back to home_screen
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF26A69A)),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Region Analysis',
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

  // ── Heatmap Card ─────────────────────────────────────────────────────────

  Widget _buildHeatmapCard() {
    return Container(
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
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Text(
              'India Budget Heatmap',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: statesData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.6,
              ),
              itemBuilder: (context, index) {
                final state = statesData[index];
                final isSelected = _selectedState?.name == state.name;
                return _buildStateTile(state, isSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateTile(StateData state, bool isSelected) {
    return GestureDetector(
      onTap: () => _onStateSelected(state),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? state.pinColor.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(left: BorderSide(color: state.pinColor, width: 3.5)),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: state.pinColor.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.location_on, color: state.pinColor, size: 20),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      state.budget,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Detail Card ───────────────────────────────────────────────────────────

  Widget _buildDetailCard(StateData state) {
    return Container(
      key: ValueKey(state.name),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 16, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const Text(
                      'State Budget Overview',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                  onPressed: () => setState(() => _selectedState = null),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatBox(
                        label: 'Total Budget',
                        value: state.budget,
                        bgColor: const Color(0xFFF0F4FF),
                        valueColor: const Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatBox(
                        label: 'Population',
                        value: state.population,
                        bgColor: const Color(0xFFF0FFF4),
                        valueColor: const Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatBox(
                        label: 'Per Capita',
                        value: state.perCapita,
                        bgColor: const Color(0xFFF5F5FF),
                        valueColor: const Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatBox(
                        label: 'Growth',
                        value: state.growth,
                        bgColor: const Color(0xFFFFF0F8),
                        valueColor: state.growthPositive
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFC62828),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox({
    required String label,
    required String value,
    required Color bgColor,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ],
      ),
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
              final isActive = i == _selectedIndex;
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
