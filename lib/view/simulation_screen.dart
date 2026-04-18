import 'package:budegt_iq/view/gov_bottm_nav.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
    generateProjection(); // ✅ initial graph
  }

  /// 🔥 SIMULATION LOGIC
  void generateProjection() {
    List<FlSpot> growth = [];
    List<FlSpot> satisfaction = [];

    double baseGrowth = 85;
    double baseSatisfaction = 70;

    for (int i = 0; i < 5; i++) {
      double year = (2024 + i).toDouble(); // ✅ FIXED

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

      growth.add(FlSpot(year, g.toDouble()));
      satisfaction.add(FlSpot(year, s.toDouble()));
    }

    setState(() {
      growthSpots = growth;
      satisfactionSpots = satisfaction;
    });
  }

  /// 🔁 NAVIGATION
  void _onNavTap(int index) {
    setState(() => currentIndex = index);

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/ai');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/regions');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  /// 🔁 UPDATE HELPER
  void updateValue(VoidCallback update) {
    setState(() {
      update();
    });
    generateProjection(); // ✅ update graph
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                children: const [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 10),
                  Text(
                    "Scenario Simulation",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
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
                        _legendItem(Colors.green, "Economic Growth"),
                        const SizedBox(width: 16),
                        _legendItem(
                            Colors.greenAccent, "Public Satisfaction"),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// TRADE-OFFS
              _card(
                "Trade-offs Analysis",
                Column(
                  children: [
                    _infoTile(
                        "Economic Impact",
                        "+0% GDP growth by 2028",
                        Colors.green),
                    const SizedBox(height: 12),
                    _infoTile(
                        "Social Welfare",
                        "Healthcare improvement affects life expectancy +0 years",
                        Colors.green.shade400),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🎚 SLIDER
  Widget _slider(String label, double value, Function(double) onChanged) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text("${value.toInt()}%"),
          ],
        ),
        Slider(
          value: value,
          min: 0,
          max: 100,
          activeColor: Colors.green,
          onChanged: onChanged,
        ),
      ],
    );
  }

  /// 📊 CHART
  Widget _buildChart() {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          minX: 2024,
          maxX: 2028,
          minY: 50,
          maxY: 140,

          gridData: FlGridData(
            show: true,
            horizontalInterval: 20,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: Colors.grey.withOpacity(0.2)),
            getDrawingVerticalLine: (value) =>
                FlLine(color: Colors.grey.withOpacity(0.1)),
          ),

          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 30,
                getTitlesWidget: (value, meta) =>
                    Text(value.toInt().toString(),
                        style: const TextStyle(fontSize: 10)),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) => Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(value.toInt().toString(),
                      style: const TextStyle(fontSize: 10)),
                ),
              ),
            ),
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),

          borderData: FlBorderData(show: false),

          lineBarsData: [
            LineChartBarData(
              spots: growthSpots,
              isCurved: true,
              barWidth: 3,
              gradient: const LinearGradient(
                colors: [Colors.green, Colors.lightGreen],
              ),
              dotData: FlDotData(show: true),
            ),
            LineChartBarData(
              spots: satisfactionSpots,
              isCurved: true,
              barWidth: 3,
              gradient: LinearGradient(
                colors: [
                  Colors.greenAccent.shade400,
                  Colors.greenAccent.shade100
                ],
              ),
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }

  /// 🏷 LEGEND
  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  /// 📦 CARD
  Widget _card(String title, Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  /// 📊 INFO TILE
  Widget _infoTile(String title, String subtitle, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.6)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(subtitle,
              style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}