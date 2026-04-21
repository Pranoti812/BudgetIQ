// // // // import 'package:budegt_iq/view/compare.dart';
// // // // //import 'package:budegt_iq/view/set_screen.dart';
// // // // import 'package:budegt_iq/view/widget/AI_budget_screen.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:fl_chart/fl_chart.dart';
// // // // import 'package:flutter/material.dart';

// // // // // 🔥 IMPORT SCREENS
// // // // import 'simulation_screen.dart';
// // // // import 'region_screen.dart';
// // // // // import 'ai_screen.dart';
// // // // import 'settings_screen.dart';
// // // // import 'a_screen.dart';

// // // // class DashboardScreen extends StatefulWidget {
// // // //   const DashboardScreen({super.key});

// // // //   @override
// // // //   State<DashboardScreen> createState() => _DashboardScreenState();
// // // // }

// // // // class _DashboardScreenState extends State<DashboardScreen> {
// // // //   int _currentIndex = 0;

// // // //   final Stream<DocumentSnapshot> budgetStream = FirebaseFirestore.instance
// // // //       .collection('budget')
// // // //       .doc('current')
// // // //       .snapshots();

// // // //   double totalBudget = 0;
// // // //   double efficiency = 0;
// // // //   double population = 0;
// // // //   int alerts = 0;

// // // //   List<double> allocation = [30, 25, 10, 35];

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     fetchAPIData();
// // // //   }

// // // //   Future<void> fetchAPIData() async {
// // // //     await Future.delayed(const Duration(milliseconds: 500));
// // // //     setState(() {
// // // //       efficiency = 94;
// // // //     });
// // // //   }

// // // //   /// ✅ FIXED NAVIGATION (NO ROUTES NEEDED)
// // // //   void _onNavTap(int index) {
// // // //     setState(() => _currentIndex = index);
// // // //     switch (index) {
// // // //       case 0:
// // // //         return;

// // // //       case 1:
// // // //         Navigator.pushReplacement(
// // // //           context,
// // // //           MaterialPageRoute(builder: (_) => const SimulationScreen()),
// // // //         );
// // // //         break;

// // // //       // case 2:
// // // //       //   Navigator.push(context,
// // // //       //       MaterialPageRoute(builder: (_) => const CompareRegionsPage()));
// // // //       //   break;

// // // //       case 3:
// // // //         Navigator.push(
// // // //             context, MaterialPageRoute(builder: (_) => const RegionScreen()));
// // // //         break;

// // // //       // case 4:
// // // //       //   Navigator.push(
// // // //       //       context, MaterialPageRoute(builder: (_) =>  SettingsScreen()));
// // // //       //   break;
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: const Color(0xFF0B1A33),
// // // //       bottomNavigationBar: _buildBottomNav(),
// // // //       body: SafeArea(
// // // //         child: StreamBuilder<DocumentSnapshot>(
// // // //           stream: budgetStream,
// // // //           builder: (context, snapshot) {
// // // //             if (snapshot.connectionState == ConnectionState.waiting) {
// // // //               return const Center(child: CircularProgressIndicator());
// // // //             }

// // // //             if (snapshot.hasData && snapshot.data!.exists) {
// // // //               final raw = snapshot.data!.data();
// // // //               if (raw != null && raw is Map<String, dynamic>) {
// // // //                 totalBudget = (raw['totalBudget'] ?? 7.1).toDouble();
// // // //                 population = (raw['population'] ?? 1.4).toDouble();
// // // //                 alerts = raw['alerts'] ?? 12;

// // // //                 allocation = List<double>.from(
// // // //                   (raw['allocation'] ?? [30, 25, 10, 35])
// // // //                       .map((e) => (e as num).toDouble()),
// // // //                 );
// // // //               }
// // // //             }

// // // //             return SingleChildScrollView(
// // // //               padding: const EdgeInsets.all(16),
// // // //               child: Column(
// // // //                 children: [
// // // //                   _buildHeader(),
// // // //                   const SizedBox(height: 20),
// // // //                   _buildStatsGrid(),
// // // //                   const SizedBox(height: 20),
// // // //                   _buildAllocationCard(),
// // // //                   const SizedBox(height: 20),
// // // //                   _buildButtons(),
// // // //                 ],
// // // //               ),
// // // //             );
// // // //           },
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildHeader() {
// // // //     return const Column(
// // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // //       children: [
// // // //         Text("Government Dashboard",
// // // //             style: TextStyle(
// // // //                 color: Colors.white,
// // // //                 fontSize: 22,
// // // //                 fontWeight: FontWeight.bold)),
// // // //         SizedBox(height: 6),
// // // //         Text("AI-powered budget optimization & governance",
// // // //             style: TextStyle(color: Colors.white70)),
// // // //       ],
// // // //     );
// // // //   }

// // // //   Widget _buildStatsGrid() {
// // // //     return GridView.count(
// // // //       shrinkWrap: true,
// // // //       physics: const NeverScrollableScrollPhysics(),
// // // //       crossAxisCount: 2,
// // // //       crossAxisSpacing: 12,
// // // //       mainAxisSpacing: 12,
// // // //       childAspectRatio: 1.2,
// // // //       children: [
// // // //         _statCard("Total Budget", "₹${totalBudget.toStringAsFixed(1)}T",
// // // //             Icons.attach_money, Colors.purple),
// // // //         _statCard(
// // // //             "Efficiency", "$efficiency%", Icons.trending_up, Colors.green),
// // // //         _statCard("Population", "${population.toStringAsFixed(1)}B",
// // // //             Icons.people, Colors.blue),
// // // //         _statCard("Alerts", "$alerts", Icons.warning, Colors.orange),
// // // //       ],
// // // //     );
// // // //   }

// // // //   Widget _statCard(String title, String value, IconData icon, Color color) {
// // // //     return GestureDetector(
// // // //       onTap: () {
// // // //         if (title.contains("Alerts")) {
// // // //           Navigator.push(
// // // //               context, MaterialPageRoute(builder: (_) => const AIScreen()));
// // // //         } else if (title.contains("Population")) {
// // // //           Navigator.push(
// // // //               context, MaterialPageRoute(builder: (_) => const RegionScreen()));
// // // //         }
// // // //       },
// // // //       child: Container(
// // // //         padding: const EdgeInsets.all(14),
// // // //         decoration: _cardDecoration(),
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             Icon(icon, color: color),
// // // //             const Spacer(),
// // // //             Text(value,
// // // //                 style: const TextStyle(
// // // //                     color: Colors.white, fontWeight: FontWeight.bold)),
// // // //             Text(title, style: const TextStyle(color: Colors.white70)),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildAllocationCard() {
// // // //     return GestureDetector(
// // // //       onTap: () {
// // // //         Navigator.push(
// // // //             context, MaterialPageRoute(builder: (_) => const RegionScreen()));
// // // //       },
// // // //       child: Container(
// // // //         padding: const EdgeInsets.all(16),
// // // //         decoration: _cardDecoration(),
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             const Text("Current Allocation",
// // // //                 style: TextStyle(color: Colors.white)),
// // // //             const SizedBox(height: 20),
// // // //             SizedBox(
// // // //               height: 180,
// // // //               child: PieChart(
// // // //                 PieChartData(
// // // //                   sections: List.generate(allocation.length, (i) {
// // // //                     return PieChartSectionData(
// // // //                       value: allocation[i],
// // // //                       color: [
// // // //                         Colors.blue,
// // // //                         Colors.teal,
// // // //                         Colors.orange,
// // // //                         Colors.purple
// // // //                       ][i],
// // // //                     );
// // // //                   }),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildButtons() {
// // // //     return Column(
// // // //       children: [
// // // //         _button("Run Scenario Simulation"),
// // // //         const SizedBox(height: 12),
// // // //         _button("Generate AI Budget"),
// // // //       ],
// // // //     );
// // // //   }

// // // //   Widget _button(String text) {
// // // //     return GestureDetector(
// // // //       onTap: () {
// // // //         if (text.contains("Simulation")) {
// // // //           Navigator.push(context,
// // // //               MaterialPageRoute(builder: (_) => const SimulationScreen()));
// // // //         } else {
// // // //           Navigator.push(
// // // //               context, MaterialPageRoute(builder: (_) => const AIScreen()));
// // // //         }
// // // //       },
// // // //       child: Container(
// // // //         height: 50,
// // // //         decoration: BoxDecoration(
// // // //           gradient: const LinearGradient(
// // // //             colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
// // // //           ),
// // // //           borderRadius: BorderRadius.circular(12),
// // // //         ),
// // // //         child: Center(
// // // //           child: Text(text,
// // // //               style: const TextStyle(
// // // //                   color: Colors.white, fontWeight: FontWeight.bold)),
// // // //         ),
// // // //       ),
// // // //        SizedBox(height: 12),
// // // //       _button(
// // // //         "Generate AI Budget",
// // // //         () {
// // // //           Navigator.push(
// // // //             context,
// // // //             MaterialPageRoute(builder: (_) => const AiBudgetScreen()),
// // // //           );
// // // //         },
// // // //       ),
// // // //     );

// // // // }
// // // //   Widget _button(String text, VoidCallback onTap) {
// // // //   return SizedBox(
// // // //     width: double.infinity,
// // // //     child: ElevatedButton(
// // // //       onPressed: onTap,
// // // //       style: ElevatedButton.styleFrom(
// // // //         padding: const EdgeInsets.symmetric(vertical: 16),
// // // //         shape: RoundedRectangleBorder(
// // // //           borderRadius: BorderRadius.circular(14),
// // // //         ),
// // // //         backgroundColor: Colors.purple,
// // // //       ),
// // // //       child: Text(text, style: const TextStyle(color: Colors.white)),
// // // //     ),
// // // //   );
// // // // }

// // // //   Widget _buildBottomNav() {
// // // //     return BottomNavigationBar(
// // // //       currentIndex: _currentIndex,
// // // //       onTap: _onNavTap,
// // // //       backgroundColor: const Color(0xFF0B1A33),
// // // //       selectedItemColor: Colors.purple,
// // // //       unselectedItemColor: Colors.white54,
// // // //       type: BottomNavigationBarType.fixed,
// // // //       items: const [
// // // //         BottomNavigationBarItem(
// // // //             icon: Icon(Icons.dashboard), label: "Dashboard"),
// // // //         BottomNavigationBarItem(
// // // //             icon: Icon(Icons.show_chart), label: "Simulation"),
// // // //         BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "AI"),
// // // //         BottomNavigationBarItem(
// // // //             icon: Icon(Icons.location_on), label: "Regions"),
// // // //         BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
// // // //       ],
// // // //     );
// // // //   }

// // // //   BoxDecoration _cardDecoration() {
// // // //     return BoxDecoration(
// // // //       color: const Color(0xFF142544),
// // // //       borderRadius: BorderRadius.circular(16),
// // // //     );
// // // //   }
// // // // }

// // // // class SettingsScreen {
// // // //   const SettingsScreen();
// // // // }

// // // import 'package:budegt_iq/view/compare.dart';
// // // //import 'package:budegt_iq/view/set_screen.dart';
// // // import 'package:budegt_iq/view/widget/AI_budget_screen.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:fl_chart/fl_chart.dart';
// // // import 'package:flutter/material.dart';

// // // // 🔥 IMPORT SCREENS
// // // import 'simulation_screen.dart';
// // // import 'region_screen.dart';
// // // // import 'ai_screen.dart';
// // // import 'settings_screen.dart';
// // // import 'a_screen.dart';

// // // class DashboardScreen extends StatefulWidget {
// // //   const DashboardScreen({super.key});

// // //   @override
// // //   State<DashboardScreen> createState() => _DashboardScreenState();
// // // }

// // // class _DashboardScreenState extends State<DashboardScreen> {
// // //   int _currentIndex = 0;

// // //   final Stream<DocumentSnapshot> budgetStream = FirebaseFirestore.instance
// // //       .collection('budget')
// // //       .doc('current')
// // //       .snapshots();

// // //   double totalBudget = 0;
// // //   double efficiency = 0;
// // //   double population = 0;
// // //   int alerts = 0;

// // //   List<double> allocation = [30, 25, 10, 35];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     fetchAPIData();
// // //   }

// // //   Future<void> fetchAPIData() async {
// // //     await Future.delayed(const Duration(milliseconds: 500));
// // //     setState(() {
// // //       efficiency = 94;
// // //     });
// // //   }

// // //   /// ✅ FIXED NAVIGATION (NO ROUTES NEEDED)
// // //   void _onNavTap(int index) {
// // //     setState(() => _currentIndex = index);
// // //     switch (index) {
// // //       case 0:
// // //         return;

// // //       case 1:
// // //         Navigator.pushReplacement(
// // //           context,
// // //           MaterialPageRoute(builder: (_) => const SimulationScreen()),
// // //         );
// // //         break;

// // //       // case 2:
// // //       //   Navigator.push(context,
// // //       //       MaterialPageRoute(builder: (_) => const CompareRegionsPage()));
// // //       //   break;

// // //       case 3:
// // //         Navigator.push(
// // //             context, MaterialPageRoute(builder: (_) => const RegionScreen()));
// // //         break;

// // //       case 4:
// // //         Navigator.push(
// // //             context, MaterialPageRoute(builder: (_) =>  SettingsScreen()));
// // //         break;
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFF0B1A33),
// // //       bottomNavigationBar: _buildBottomNav(),
// // //       body: SafeArea(
// // //         child: StreamBuilder<DocumentSnapshot>(
// // //           stream: budgetStream,
// // //           builder: (context, snapshot) {
// // //             if (snapshot.connectionState == ConnectionState.waiting) {
// // //               return const Center(child: CircularProgressIndicator());
// // //             }

// // //             if (snapshot.hasData && snapshot.data!.exists) {
// // //               final raw = snapshot.data!.data();
// // //               if (raw != null && raw is Map<String, dynamic>) {
// // //                 totalBudget = (raw['totalBudget'] ?? 7.1).toDouble();
// // //                 population = (raw['population'] ?? 1.4).toDouble();
// // //                 alerts = raw['alerts'] ?? 12;

// // //                 allocation = List<double>.from(
// // //                   (raw['allocation'] ?? [30, 25, 10, 35])
// // //                       .map((e) => (e as num).toDouble()),
// // //                 );
// // //               }
// // //             }

// // //             return SingleChildScrollView(
// // //               padding: const EdgeInsets.all(16),
// // //               child: Column(
// // //                 children: [
// // //                   _buildHeader(),
// // //                   const SizedBox(height: 20),
// // //                   _buildStatsGrid(),
// // //                   const SizedBox(height: 20),
// // //                   _buildAllocationCard(),
// // //                   const SizedBox(height: 20),
// // //                   _buildButtons(),
// // //                 ],
// // //               ),
// // //             );
// // //           },
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildHeader() {
// // //     return const Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Text("Government Dashboard",
// // //             style: TextStyle(
// // //                 color: Colors.white,
// // //                 fontSize: 22,
// // //                 fontWeight: FontWeight.bold)),
// // //         SizedBox(height: 6),
// // //         Text("AI-powered budget optimization & governance",
// // //             style: TextStyle(color: Colors.white70)),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildStatsGrid() {
// // //     return GridView.count(
// // //       shrinkWrap: true,
// // //       physics: const NeverScrollableScrollPhysics(),
// // //       crossAxisCount: 2,
// // //       crossAxisSpacing: 12,
// // //       mainAxisSpacing: 12,
// // //       childAspectRatio: 1.2,
// // //       children: [
// // //         _statCard("Total Budget", "₹${totalBudget.toStringAsFixed(1)}T",
// // //             Icons.attach_money, Colors.purple),
// // //         _statCard(
// // //             "Efficiency", "$efficiency%", Icons.trending_up, Colors.green),
// // //         _statCard("Population", "${population.toStringAsFixed(1)}B",
// // //             Icons.people, Colors.blue),
// // //         _statCard("Alerts", "$alerts", Icons.warning, Colors.orange),
// // //       ],
// // //     );
// // //   }

// // //   Widget _statCard(String title, String value, IconData icon, Color color) {
// // //     return GestureDetector(
// // //       onTap: () {
// // //         if (title.contains("Alerts")) {
// // //           Navigator.push(
// // //               context, MaterialPageRoute(builder: (_) => const AIScreen()));
// // //         } else if (title.contains("Population")) {
// // //           Navigator.push(
// // //               context, MaterialPageRoute(builder: (_) => const RegionScreen()));
// // //         }
// // //       },
// // //       child: Container(
// // //         padding: const EdgeInsets.all(14),
// // //         decoration: _cardDecoration(),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Icon(icon, color: color),
// // //             const Spacer(),
// // //             Text(value,
// // //                 style: const TextStyle(
// // //                     color: Colors.white, fontWeight: FontWeight.bold)),
// // //             Text(title, style: const TextStyle(color: Colors.white70)),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildAllocationCard() {
// // //     return GestureDetector(
// // //       onTap: () {
// // //         Navigator.push(
// // //             context, MaterialPageRoute(builder: (_) => const RegionScreen()));
// // //       },
// // //       child: Container(
// // //         padding: const EdgeInsets.all(16),
// // //         decoration: _cardDecoration(),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             const Text("Current Allocation",
// // //                 style: TextStyle(color: Colors.white)),
// // //             const SizedBox(height: 20),
// // //             SizedBox(
// // //               height: 180,
// // //               child: PieChart(
// // //                 PieChartData(
// // //                   sections: List.generate(allocation.length, (i) {
// // //                     return PieChartSectionData(
// // //                       value: allocation[i],
// // //                       color: [
// // //                         Colors.blue,
// // //                         Colors.teal,
// // //                         Colors.orange,
// // //                         Colors.purple
// // //                       ][i],
// // //                     );
// // //                   }),
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   // ✅ FIXED: _buildButtons now uses the single _button method with correct signature
// // //   Widget _buildButtons() {
// // //     return Column(
// // //       children: [
// // //         _button(
// // //           "Run Scenario Simulation",
// // //           () {
// // //             Navigator.push(
// // //               context,
// // //               MaterialPageRoute(builder: (_) => const SimulationScreen()),
// // //             );
// // //           },
// // //         ),
// // //         const SizedBox(height: 12),
// // //         _button(
// // //           "Generate AI Budget",
// // //           () {
// // //             Navigator.push(
// // //               context,
// // //               MaterialPageRoute(builder: (_) => const AiBudgetScreen()),
// // //             );
// // //           },
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   // ✅ FIXED: Single _button method with text + onTap — removed the duplicate
// // //   Widget _button(String text, VoidCallback onTap) {
// // //     return SizedBox(
// // //       width: double.infinity,
// // //       child: ElevatedButton(
// // //         onPressed: onTap,
// // //         style: ElevatedButton.styleFrom(
// // //           padding: const EdgeInsets.symmetric(vertical: 16),
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(14),
// // //           ),
// // //           backgroundColor: Colors.purple,
// // //         ),
// // //         child: Text(text, style: const TextStyle(color: Colors.white)),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildBottomNav() {
// // //     return BottomNavigationBar(
// // //       currentIndex: _currentIndex,
// // //       onTap: _onNavTap,
// // //       backgroundColor: const Color(0xFF0B1A33),
// // //       selectedItemColor: Colors.purple,
// // //       unselectedItemColor: Colors.white54,
// // //       type: BottomNavigationBarType.fixed,
// // //       items: const [
// // //         BottomNavigationBarItem(
// // //             icon: Icon(Icons.dashboard), label: "Dashboard"),
// // //         BottomNavigationBarItem(
// // //             icon: Icon(Icons.show_chart), label: "Simulation"),
// // //         BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "AI"),
// // //         BottomNavigationBarItem(
// // //             icon: Icon(Icons.location_on), label: "Regions"),
// // //         BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
// // //       ],
// // //     );
// // //   }

// // //   BoxDecoration _cardDecoration() {
// // //     return BoxDecoration(
// // //       color: const Color(0xFF142544),
// // //       borderRadius: BorderRadius.circular(16),
// // //     );
// // //   }
// // // }

// // // class SettingsScreen {
// // //   const SettingsScreen();
// // // }

// // import 'package:budegt_iq/view/compare.dart';
// // //import 'package:budegt_iq/view/widget/AI_budget_screen.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:flutter/material.dart';

// // // 🔥 IMPORT SCREENS
// // import 'simulation_screen.dart';
// // import 'region_screen.dart';
// // import 'settings_screen.dart';
// // import 'a_screen.dart';

// // class DashboardScreen extends StatefulWidget {
// //   const DashboardScreen({super.key});

// //   @override
// //   State<DashboardScreen> createState() => _DashboardScreenState();
// // }

// // class _DashboardScreenState extends State<DashboardScreen> {
// //   int _currentIndex = 0;

// //   final Stream<DocumentSnapshot> budgetStream = FirebaseFirestore.instance
// //       .collection('budget')
// //       .doc('current')
// //       .snapshots();

// //   double totalBudget = 0;
// //   double efficiency = 0;
// //   double population = 0;
// //   int alerts = 0;

// //   List<double> allocation = [30, 25, 10, 35];

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchAPIData();
// //   }

// //   Future<void> fetchAPIData() async {
// //     await Future.delayed(const Duration(milliseconds: 500));
// //     setState(() {
// //       efficiency = 94;
// //     });
// //   }

// //   void _onNavTap(int index) {
// //     setState(() => _currentIndex = index);
// //     switch (index) {
// //       case 0:
// //         return;

// //       case 1:
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (_) => const SimulationScreen()),
// //         );
// //         break;

// //       case 3:
// //         Navigator.push(
// //             context, MaterialPageRoute(builder: (_) => const RegionScreen()));
// //         break;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFF0B1A33),
// //       bottomNavigationBar: _buildBottomNav(),
// //       body: SafeArea(
// //         child: StreamBuilder<DocumentSnapshot>(
// //           stream: budgetStream,
// //           builder: (context, snapshot) {
// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return const Center(child: CircularProgressIndicator());
// //             }

// //             if (snapshot.hasData && snapshot.data!.exists) {
// //               final raw = snapshot.data!.data();
// //               if (raw != null && raw is Map<String, dynamic>) {
// //                 totalBudget = (raw['totalBudget'] ?? 7.1).toDouble();
// //                 population = (raw['population'] ?? 1.4).toDouble();
// //                 alerts = raw['alerts'] ?? 12;

// //                 allocation = List<double>.from(
// //                   (raw['allocation'] ?? [30, 25, 10, 35])
// //                       .map((e) => (e as num).toDouble()),
// //                 );
// //               }
// //             }

// //             return SingleChildScrollView(
// //               padding: const EdgeInsets.all(16),
// //               child: Column(
// //                 children: [
// //                   _buildHeader(),
// //                   const SizedBox(height: 20),
// //                   _buildStatsGrid(),
// //                   const SizedBox(height: 20),
// //                   _buildAllocationCard(),
// //                   const SizedBox(height: 20),
// //                   _buildButtons(),
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildHeader() {
// //     return const Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           "Government Dashboard",
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontSize: 22,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         SizedBox(height: 6),
// //         Text(
// //           "AI-powered budget optimization & governance",
// //           style: TextStyle(color: Colors.white70),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildStatsGrid() {
// //     return GridView.count(
// //       shrinkWrap: true,
// //       physics: const NeverScrollableScrollPhysics(),
// //       crossAxisCount: 2,
// //       crossAxisSpacing: 12,
// //       mainAxisSpacing: 12,
// //       childAspectRatio: 1.2,
// //       children: [
// //         _statCard("Total Budget", "₹${totalBudget.toStringAsFixed(1)}T",
// //             Icons.attach_money, Colors.purple),
// //         _statCard(
// //             "Efficiency", "$efficiency%", Icons.trending_up, Colors.green),
// //         _statCard("Population", "${population.toStringAsFixed(1)}B",
// //             Icons.people, Colors.blue),
// //         _statCard("Alerts", "$alerts", Icons.warning, Colors.orange),
// //       ],
// //     );
// //   }

// //   Widget _statCard(String title, String value, IconData icon, Color color) {
// //     return GestureDetector(
// //       onTap: () {
// //         if (title.contains("Alerts")) {
// //           Navigator.push(
// //               context, MaterialPageRoute(builder: (_) => const AIScreen()));
// //         } else if (title.contains("Population")) {
// //           Navigator.push(
// //               context, MaterialPageRoute(builder: (_) => const RegionScreen()));
// //         }
// //       },
// //       child: Container(
// //         padding: const EdgeInsets.all(14),
// //         decoration: _cardDecoration(),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Icon(icon, color: color),
// //             const Spacer(),
// //             Text(
// //               value,
// //               style: const TextStyle(
// //                   color: Colors.white, fontWeight: FontWeight.bold),
// //             ),
// //             Text(title, style: const TextStyle(color: Colors.white70)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildAllocationCard() {
// //     return GestureDetector(
// //       onTap: () {
// //         Navigator.push(
// //             context, MaterialPageRoute(builder: (_) => const RegionScreen()));
// //       },
// //       child: Container(
// //         padding: const EdgeInsets.all(16),
// //         decoration: _cardDecoration(),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text("Current Allocation",
// //                 style: TextStyle(color: Colors.white)),
// //             const SizedBox(height: 20),
// //             SizedBox(
// //               height: 180,
// //               child: PieChart(
// //                 PieChartData(
// //                   sections: List.generate(allocation.length, (i) {
// //                     return PieChartSectionData(
// //                       value: allocation[i],
// //                       color: [
// //                         Colors.blue,
// //                         Colors.teal,
// //                         Colors.orange,
// //                         Colors.purple,
// //                       ][i],
// //                     );
// //                   }),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // ✅ FIX 1: Single _buildButtons() — no more stray code or duplicate calls
// //   Widget _buildButtons() {
// //     return Column(
// //       children: [
// //         _button(
// //           "Run Scenario Simulation",
// //           () {
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(builder: (_) => const SimulationScreen()),
// //             );
// //           },
// //         ),
// //         const SizedBox(height: 12),
// //         _button(
// //           "Generate AI Budget",
// //           () {
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(builder: (_) => const AiBudgetScreen()),
// //             );
// //           },
// //         ),
// //       ],
// //     );
// //   }

// //   // ✅ FIX 2: Single _button() definition — takes text + VoidCallback, no duplicate
// //   Widget _button(String text, VoidCallback onTap) {
// //     return SizedBox(
// //       width: double.infinity,
// //       child: ElevatedButton(
// //         onPressed: onTap,
// //         style: ElevatedButton.styleFrom(
// //           padding: const EdgeInsets.symmetric(vertical: 16),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(14),
// //           ),
// //           backgroundColor: Colors.purple,
// //         ),
// //         child: Text(text, style: const TextStyle(color: Colors.white)),
// //       ),
// //     );
// //   }

// //   Widget _buildBottomNav() {
// //     return BottomNavigationBar(
// //       currentIndex: _currentIndex,
// //       onTap: _onNavTap,
// //       backgroundColor: const Color(0xFF0B1A33),
// //       selectedItemColor: Colors.purple,
// //       unselectedItemColor: Colors.white54,
// //       type: BottomNavigationBarType.fixed,
// //       items: const [
// //         BottomNavigationBarItem(
// //             icon: Icon(Icons.dashboard), label: "Dashboard"),
// //         BottomNavigationBarItem(
// //             icon: Icon(Icons.show_chart), label: "Simulation"),
// //         BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "AI"),
// //         BottomNavigationBarItem(
// //             icon: Icon(Icons.location_on), label: "Regions"),
// //         BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
// //       ],
// //     );
// //   }

// //   BoxDecoration _cardDecoration() {
// //     return BoxDecoration(
// //       color: const Color(0xFF142544),
// //       borderRadius: BorderRadius.circular(16),
// //     );
// //   }
// // }

// // class AiBudgetScreen {
// //   const AiBudgetScreen();
// // }

// import 'package:budegt_iq/view/compare.dart';
// import 'package:budegt_iq/view/widget/AI_budget_screen.dart'; // ✅ FIX: proper import instead of stub class
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// // 🔥 IMPORT SCREENS
// import 'simulation_screen.dart';
// import 'region_screen.dart';
// import 'settings_screen.dart';
// import 'a_screen.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   int _currentIndex = 0;

//   final Stream<DocumentSnapshot> budgetStream = FirebaseFirestore.instance
//       .collection('budget')
//       .doc('current')
//       .snapshots();

//   double totalBudget = 0;
//   double efficiency = 0;
//   double population = 0;
//   int alerts = 0;

//   List<double> allocation = [30, 25, 10, 35];

//   @override
//   void initState() {
//     super.initState();
//     fetchAPIData();
//   }

//   Future<void> fetchAPIData() async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     setState(() {
//       efficiency = 94;
//     });
//   }

//   void _onNavTap(int index) {
//     setState(() => _currentIndex = index);
//     switch (index) {
//       case 0:
//         return;

//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const SimulationScreen()),
//         );
//         break;

//       case 3:
//         Navigator.push(
//             context, MaterialPageRoute(builder: (_) => const RegionScreen()));
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0B1A33),
//       bottomNavigationBar: _buildBottomNav(),
//       body: SafeArea(
//         child: StreamBuilder<DocumentSnapshot>(
//           stream: budgetStream,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasData && snapshot.data!.exists) {
//               final raw = snapshot.data!.data();
//               if (raw != null && raw is Map<String, dynamic>) {
//                 totalBudget = (raw['totalBudget'] ?? 7.1).toDouble();
//                 population = (raw['population'] ?? 1.4).toDouble();
//                 alerts = raw['alerts'] ?? 12;

//                 allocation = List<double>.from(
//                   (raw['allocation'] ?? [30, 25, 10, 35])
//                       .map((e) => (e as num).toDouble()),
//                 );
//               }
//             }

//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   _buildHeader(),
//                   const SizedBox(height: 20),
//                   _buildStatsGrid(),
//                   const SizedBox(height: 20),
//                   _buildAllocationCard(),
//                   const SizedBox(height: 20),
//                   _buildButtons(),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Government Dashboard",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 6),
//         Text(
//           "AI-powered budget optimization & governance",
//           style: TextStyle(color: Colors.white70),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatsGrid() {
//     return GridView.count(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       crossAxisCount: 2,
//       crossAxisSpacing: 12,
//       mainAxisSpacing: 12,
//       childAspectRatio: 1.2,
//       children: [
//         _statCard("Total Budget", "₹${totalBudget.toStringAsFixed(1)}T",
//             Icons.attach_money, Colors.purple),
//         _statCard(
//             "Efficiency", "$efficiency%", Icons.trending_up, Colors.green),
//         _statCard("Population", "${population.toStringAsFixed(1)}B",
//             Icons.people, Colors.blue),
//         _statCard("Alerts", "$alerts", Icons.warning, Colors.orange),
//       ],
//     );
//   }

//   Widget _statCard(String title, String value, IconData icon, Color color) {
//     return GestureDetector(
//       onTap: () {
//         if (title.contains("Alerts")) {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (_) => const AIScreen()));
//         } else if (title.contains("Population")) {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (_) => const RegionScreen()));
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.all(14),
//         decoration: _cardDecoration(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, color: color),
//             const Spacer(),
//             Text(
//               value,
//               style: const TextStyle(
//                   color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             Text(title, style: const TextStyle(color: Colors.white70)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAllocationCard() {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (_) => const RegionScreen()));
//       },
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: _cardDecoration(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Current Allocation",
//                 style: TextStyle(color: Colors.white)),
//             const SizedBox(height: 20),
//             SizedBox(
//               height: 180,
//               child: PieChart(
//                 PieChartData(
//                   sections: List.generate(allocation.length, (i) {
//                     return PieChartSectionData(
//                       value: allocation[i],
//                       color: [
//                         Colors.blue,
//                         Colors.teal,
//                         Colors.orange,
//                         Colors.purple,
//                       ][i],
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildButtons() {
//     return Column(
//       children: [
//         _button(
//           "Run Scenario Simulation",
//           () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const SimulationScreen()),
//             );
//           },
//         ),
//         const SizedBox(height: 12),
//         _button(
//           "Generate AI Budget",
//           () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const AiBudgetScreen()), // ✅ now resolves to the real Widget
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _button(String text, VoidCallback onTap) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: onTap,
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(14),
//           ),
//           backgroundColor: Colors.purple,
//         ),
//         child: Text(text, style: const TextStyle(color: Colors.white)),
//       ),
//     );
//   }

//   Widget _buildBottomNav() {
//     return BottomNavigationBar(
//       currentIndex: _currentIndex,
//       onTap: _onNavTap,
//       backgroundColor: const Color(0xFF0B1A33),
//       selectedItemColor: Colors.purple,
//       unselectedItemColor: Colors.white54,
//       type: BottomNavigationBarType.fixed,
//       items: const [
//         BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard), label: "Dashboard"),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.show_chart), label: "Simulation"),
//         BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "AI"),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.location_on), label: "Regions"),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.settings), label: "Settings"),
//       ],
//     );
//   }

//   BoxDecoration _cardDecoration() {
//     return BoxDecoration(
//       color: const Color(0xFF142544),
//       borderRadius: BorderRadius.circular(16),
//     );
//   }
// }
// // ✅ FIX: Removed the fake `class AiBudgetScreen { const AiBudgetScreen(); }` stub that was here.
// // AiBudgetScreen is now correctly imported from 'package:budegt_iq/view/widget/AI_budget_screen.dart' at the top.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// 🔥 IMPORT SCREENS
import 'simulation_screen.dart';
import 'region_screen.dart';
import 'settings_screen.dart';
import 'a_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final Stream<DocumentSnapshot> budgetStream = FirebaseFirestore.instance
      .collection('budget')
      .doc('current')
      .snapshots();

  double totalBudget = 0;
  double efficiency = 0;
  double population = 0;
  int alerts = 0;

  List<double> allocation = [30, 25, 10, 35];

  @override
  void initState() {
    super.initState();
    fetchAPIData();
  }

  Future<void> fetchAPIData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      efficiency = 94;
    });
  }

  void _onNavTap(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        return;

      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SimulationScreen()),
        );
        break;

      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const RegionScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1A33),
      bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: budgetStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && snapshot.data!.exists) {
              final raw = snapshot.data!.data();
              if (raw != null && raw is Map<String, dynamic>) {
                totalBudget = (raw['totalBudget'] ?? 7.1).toDouble();
                population = (raw['population'] ?? 1.4).toDouble();
                alerts = raw['alerts'] ?? 12;

                allocation = List<double>.from(
                  (raw['allocation'] ?? [30, 25, 10, 35])
                      .map((e) => (e as num).toDouble()),
                );
              }
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildStatsGrid(),
                  const SizedBox(height: 20),
                  _buildAllocationCard(),
                  const SizedBox(height: 20),
                  _buildButtons(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Government Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          "AI-powered budget optimization & governance",
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: [
        _statCard("Total Budget", "₹${totalBudget.toStringAsFixed(1)}T",
            Icons.attach_money, Colors.purple),
        _statCard(
            "Efficiency", "$efficiency%", Icons.trending_up, Colors.green),
        _statCard("Population", "${population.toStringAsFixed(1)}B",
            Icons.people, Colors.blue),
        _statCard("Alerts", "$alerts", Icons.warning, Colors.orange),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        if (title.contains("Alerts")) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AIScreen()));
        } else if (title.contains("Population")) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const RegionScreen()));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(title, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildAllocationCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const RegionScreen()));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Current Allocation",
                style: TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: PieChart(
                PieChartData(
                  sections: List.generate(allocation.length, (i) {
                    return PieChartSectionData(
                      value: allocation[i],
                      color: [
                        Colors.blue,
                        Colors.teal,
                        Colors.orange,
                        Colors.purple,
                      ][i],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        _button(
          "Run Scenario Simulation",
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SimulationScreen()),
            );
          },
        ),
        const SizedBox(height: 12),
        _button(
          "Generate AI Budget",
          () {
            Navigator.push(
              context,
              // ✅ FIX: AiBudgetScreen is now a proper Widget defined below
              MaterialPageRoute(builder: (_) => const AiBudgetScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _button(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: Colors.purple,
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onNavTap,
      backgroundColor: const Color(0xFF0B1A33),
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: "Dashboard"),
        BottomNavigationBarItem(
            icon: Icon(Icons.show_chart), label: "Simulation"),
        BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "AI"),
        BottomNavigationBarItem(
            icon: Icon(Icons.location_on), label: "Regions"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFF142544),
      borderRadius: BorderRadius.circular(16),
    );
  }
}

// ✅ FIX: AiBudgetScreen is now a proper StatelessWidget (not a plain class).
// This replaces the broken import that pointed to a file that didn't exist.
// When you create your real AI budget screen, replace this with your actual implementation
// or move this class to its own file and import it from there.
class AiBudgetScreen extends StatelessWidget {
  const AiBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1A33),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1A33),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'AI Budget',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Text(
          'AI Budget Screen\nComing Soon',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      ),
    );
  }
}
