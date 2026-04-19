import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AiBudgetScreen extends StatefulWidget {
  const AiBudgetScreen({super.key});

  @override
  State<AiBudgetScreen> createState() => _AiBudgetScreenState();
}

class _AiBudgetScreenState extends State<AiBudgetScreen> {
  final TextEditingController populationController =
      TextEditingController();

  final TextEditingController gdpController =
      TextEditingController();

  final TextEditingController literacyController =
      TextEditingController();

  final TextEditingController povertyController =
      TextEditingController();

  Map<String, double> budget = {};
  bool showResult = false;

  /// 🔥 RESET ON SCREEN OPEN
  @override
  void initState() {
    super.initState();
    _resetFields();
  }

  void _resetFields() {
    populationController.text = "";
    gdpController.text = "";
    literacyController.text = "";
    povertyController.text = "";

    budget.clear();
    showResult = false;
  }

  /// 🔥 MEMORY SAFE
  @override
  void dispose() {
    populationController.dispose();
    gdpController.dispose();
    literacyController.dispose();
    povertyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1A33),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1A33),
        elevation: 0,
        title: const Text("Smart Budget Allocation"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// INPUT CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1C2A44),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Input Parameters",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _inputField("Population (millions)", populationController),
                  _inputField("GDP (₹ trillions)", gdpController),
                  _inputField("Literacy Rate (%)", literacyController),
                  _inputField("Poverty Index", povertyController),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _generateAI,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: Colors.purple,
                ),
                child: const Text(
                  "✨ Generate AI Allocation",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            /// 🔥 RESULT
            if (showResult) ...[
              const SizedBox(height: 20),

              /// HEATMAP
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C2A44),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sector Priority Heatmap",
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 12),
                    _buildHeatMap(),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// PIE CHART
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C2A44),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text("Budget Distribution",
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 12),
                    _buildPieChart(),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  /// 🔥 INPUT FIELD
  Widget _inputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A3A5A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }

  /// 🔥 AI CALCULATION
  void _generateAI() {
    final population = double.tryParse(populationController.text) ?? 0;
    final gdp = double.tryParse(gdpController.text) ?? 0;
    final literacy = double.tryParse(literacyController.text) ?? 0;
    final poverty = double.tryParse(povertyController.text) ?? 0;

    double healthcare = poverty * 2;
    double education = literacy * 1.5;
    double defense = gdp * 0.5;
    double agriculture = population * 0.05;

    double total = healthcare + education + defense + agriculture;

    setState(() {
      budget = {
        "Healthcare": (healthcare / total) * 100,
        "Education": (education / total) * 100,
        "Defense": (defense / total) * 100,
        "Agriculture": (agriculture / total) * 100,
      };
      showResult = true;
    });
  }

  /// 🔥 PIE CHART
  Widget _buildPieChart() {
    return SizedBox(
      height: 220,
      child: PieChart(
        PieChartData(
          sections: budget.entries.map((e) {
            return PieChartSectionData(
              value: e.value,
              title: "${e.value.toStringAsFixed(1)}%",
            );
          }).toList(),
        ),
      ),
    );
  }

  /// 🔥 HEATMAP
  Widget _buildHeatMap() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: budget.entries.map((e) {
        Color color;

        if (e.value > 35) {
          color = Colors.red;
        } else if (e.value > 20) {
          color = Colors.orange;
        } else {
          color = Colors.green;
        }

        return Container(
          width: 150,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color),
          ),
          child: Column(
            children: [
              Text(e.key,
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 5),
              Text("${e.value.toStringAsFixed(1)}%",
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }
}