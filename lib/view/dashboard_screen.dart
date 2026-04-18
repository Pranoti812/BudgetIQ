import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final Stream<DocumentSnapshot> budgetStream =
      FirebaseFirestore.instance.collection('budget').doc('current').snapshots();

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

  /// 🔥 FULL NAVIGATION HANDLER
  void _onNavTap(int index) {
    setState(() => _currentIndex = index);

    switch (index) {
      case 1:
        Navigator.pushNamed(context, '/simulation');
        break;
      case 2:
        Navigator.pushNamed(context, '/ai');
        break;
      case 3:
        Navigator.pushNamed(context, '/regions');
        break;
      case 4:
        Navigator.pushNamed(context, '/settings');
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

            /// ✅ SAFE FIREBASE PARSING
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildStatsGrid(),
                  const SizedBox(height: 20),
                  _buildAllocationCard(),
                  const SizedBox(height: 20),
                  _buildAIAlerts(),
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

  /// HEADER
  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Government Dashboard",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Text(
          "AI-powered budget optimization & governance",
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  /// STATS GRID (CLICKABLE)
  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: [
        _statCard("Total Budget", "₹${totalBudget.toStringAsFixed(1)}T", Icons.attach_money, Colors.purple),
        _statCard("Allocation Efficiency", "$efficiency%", Icons.trending_up, Colors.green),
        _statCard("Population Covered", "${population.toStringAsFixed(1)}B", Icons.people, Colors.blue),
        _statCard("Active Alerts", "$alerts", Icons.warning, Colors.orange),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        if (title.contains("Alerts")) {
          Navigator.pushNamed(context, '/ai');
        } else if (title.contains("Population")) {
          Navigator.pushNamed(context, '/regions');
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
            Text(value,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  /// PIE CHART (CLICKABLE)
  Widget _buildAllocationCard() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/regions'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Current Allocation",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 50,
                  sections: List.generate(allocation.length, (i) {
                    final colors = [
                      Colors.blue,
                      Colors.teal,
                      Colors.orange,
                      Colors.purple
                    ];
                    return PieChartSectionData(
                      value: allocation[i],
                      color: colors[i],
                      radius: 20,
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

  /// AI ALERTS
  Widget _buildAIAlerts() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("AI Alerts",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  /// BUTTONS
  Widget _buildButtons() {
    return Column(
      children: [
        _button("Run Scenario Simulation"),
        const SizedBox(height: 12),
        _button("Generate AI Budget"),
      ],
    );
  }

  Widget _button(String text) {
    return GestureDetector(
      onTap: () {
        if (text.contains("Simulation")) {
          Navigator.pushNamed(context, '/simulation');
        } else if (text.contains("AI")) {
          Navigator.pushNamed(context, '/ai');
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  /// BOTTOM NAV
  Widget _buildBottomNav() {
  return BottomNavigationBar(
    currentIndex: _currentIndex,
    backgroundColor: const Color(0xFF0B1A33),
    selectedItemColor: Colors.purple,
    unselectedItemColor: Colors.white54,
    type: BottomNavigationBarType.fixed,

    /// 🔥 NAVIGATION LOGIC HERE
    onTap: (index) {
      setState(() => _currentIndex = index);

      switch (index) {
        case 0:
          // Already on Dashboard
          break;

        case 1:
          Navigator.pushNamed(context, '/simulation');
          break;

        case 2:
          Navigator.pushNamed(context, '/ai');
          break;

        case 3:
          Navigator.pushNamed(context, '/regions');
          break;

        case 4:
          Navigator.pushNamed(context, '/settings');
          break;
      }
    },

    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: "Dashboard",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.show_chart),
        label: "Simulation",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.lightbulb),
        label: "AI Insights",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.location_on),
        label: "Regions",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Settings",
      ),
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