import 'package:budegt_iq/view/a_screen.dart';
import 'package:budegt_iq/view/gov_bottm_nav.dart';
import 'package:budegt_iq/view/set_screen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// 🔥 IMPORT SCREENS
import 'dashboard_screen.dart';
import 'region_screen.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({super.key});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  int currentIndex = 1;

  double healthcare = 40;
  double defense = 40;
  double agriculture = 40;

  List<FlSpot> growthSpots = [];
  List<FlSpot> satisfactionSpots = [];

  @override
  void initState() {
    super.initState();
    generateProjection();
  }

  /// 🔥 SIMULATION LOGIC
  void generateProjection() {
    List<FlSpot> growth = [];
    List<FlSpot> satisfaction = [];

    double baseGrowth = 85;
    double baseSatisfaction = 70;

    for (int i = 0; i < 5; i++) {
      double year = (2024 + i).toDouble();

      double g = baseGrowth +
          (healthcare * 0.25) +
          (defense * 0.12) +
          (agriculture * 0.18) +
          (i * 4);

      double s = baseSatisfaction +
          (healthcare * 0.35) -
          (defense * 0.10) +
          (agriculture * 0.25) +
          (i * 3);

      growth.add(FlSpot(year, g));
      satisfaction.add(FlSpot(year, s));
    }

    setState(() {
      growthSpots = growth;
      satisfactionSpots = satisfaction;
    });
  }

  /// 🔥 FIXED NAVIGATION (NO ROUTES)
  void _onNavTap(int index) {
    setState(() => currentIndex = index);

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
        break;

      case 1:
        break;

      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AIScreen()),
        );
        break;

      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RegionScreen()),
        );
        break;

      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SettingsScreen()),
        );
        break;
    }
  }

  void updateValue(VoidCallback update) {
    setState(update);
    generateProjection();
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// HEADER
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Scenario Simulation",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// SLIDERS
              _card(
                "Adjust Budget Allocation",
                Column(
                  children: [
                    _slider("Healthcare", healthcare,
                        (v) => updateValue(() => healthcare = v)),
                    _slider("Defense", defense,
                        (v) => updateValue(() => defense = v)),
                    _slider("Agriculture", agriculture,
                        (v) => updateValue(() => agriculture = v)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// GRAPH
              _card(
                "Impact Projection (5 Years)",
                Column(
                  children: [
                    _buildChart(),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _legendItem(Colors.green, "Growth"),
                        const SizedBox(width: 16),
                        _legendItem(Colors.lightGreen, "Satisfaction"),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// INFO
              _card(
                "Trade-offs Analysis",
                Column(
                  children: [
                    _infoTile("Economic Impact", "+GDP growth", Colors.green),
                    const SizedBox(height: 12),
                    _infoTile("Social Welfare",
                        "Healthcare improves life expectancy", Colors.green),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _slider(String label, double value, Function(double) onChanged) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(label), Text("${value.toInt()}%")],
        ),
        Slider(value: value, min: 0, max: 100, onChanged: onChanged),
      ],
    );
  }

  Widget _buildChart() {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          minX: 2024,
          maxX: 2028,
          lineBarsData: [
            LineChartBarData(spots: growthSpots, isCurved: true),
            LineChartBarData(spots: satisfactionSpots, isCurved: true),
          ],
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 10, height: 10, color: color),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }

  Widget _card(String title, Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(title), const SizedBox(height: 10), child],
      ),
    );
  }

  Widget _infoTile(String t, String s, Color c) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration:
          BoxDecoration(color: c, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(t), Text(s)],
      ),
    );
  }
}