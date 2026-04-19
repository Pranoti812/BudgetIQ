import 'package:budegt_iq/view/dashboard_screen.dart';
import 'package:budegt_iq/view/gov_bottm_nav.dart';
//import 'package:budegt_iq/view/region.dart';
import 'package:budegt_iq/view/region_screen.dart';
import 'package:budegt_iq/view/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({super.key});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  double healthcare = 40;
  double defense = 40;
  double agriculture = 40;

  List<FlSpot> growthSpots = [];
  List<FlSpot> satisfactionSpots = [];
  
  Object? get currentIndex => null;

  @override
  void initState() {
    super.initState();
    generateProjection();
  }

  /// 🔥 LOGIC (UNCHANGED)
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

  /// 🔁 NAVIGATION
void _onNavTap(int index) {
  if (index == currentIndex) return; // prevent reload

  switch (index) {
    case 0:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
      break;

    case 1:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SimulationScreen()),
      );
      break;

    // case 2:
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (_) => const AIInsightsScreen()),
    //   );
    //   break;

    case 3:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegionScreen()),
      );
      break;

    case 4:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DataIntegrationScreen()),
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
      backgroundColor: const Color(0xFF0B1A33),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// HEADER
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DashboardScreen()),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Scenario Simulation",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
                        _legendItem(Colors.purple, "Growth"),
                        const SizedBox(width: 16),
                        _legendItem(Colors.blue, "Satisfaction"),
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
                    _infoTile("Economic Impact", "+GDP growth"),
                    const SizedBox(height: 12),
                    _infoTile("Social Welfare",
                        "Healthcare improves life expectancy"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 SLIDER
  Widget _slider(String label, double value, Function(double) onChanged) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(color: Colors.white70)),
            Text("${value.toInt()}%",
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        Slider(
          value: value,
          min: 0,
          max: 100,
          activeColor: Colors.purple,
          onChanged: onChanged,
        ),
      ],
    );
  }

  /// 🔥 UPDATED CHART (FIXED AXIS)
  Widget _buildChart() {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          minX: 2024,
          maxX: 2028,
          minY: 60,
          maxY: 130,

          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.white12,
              strokeWidth: 1,
            ),
          ),

          borderData: FlBorderData(show: false),

          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 10),
                ),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 10,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 10),
                ),
              ),
            ),
            rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
          ),

          lineBarsData: [
            LineChartBarData(
              spots: growthSpots,
              isCurved: true,
              color: Colors.purple,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.purple.withOpacity(0.2),
              ),
            ),
            LineChartBarData(
              spots: satisfactionSpots,
              isCurved: true,
              color: Colors.blue,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.2),
              ),
            ),
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
        Text(text,
            style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _card(String title, Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2A44),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 12),
          child
        ],
      ),
    );
  }

  Widget _infoTile(String t, String s) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3A5A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Text(s,
              style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}