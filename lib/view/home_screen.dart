import 'package:budegt_iq/view/widget/budget_card.dart';
import 'package:budegt_iq/view/widget/legend_title.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controller/home_controller.dart';
import 'bottom_nav.dart';

class CitizenHomeScreen extends StatefulWidget {
  const CitizenHomeScreen({super.key});

  @override
  State<CitizenHomeScreen> createState() => _CitizenHomeScreenState();
}

class _CitizenHomeScreenState extends State<CitizenHomeScreen> {
  final controller = HomeController();
  bool isLoading = true;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await controller.loadData();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final items = controller.items;

    return Scaffold(
      backgroundColor: const Color(0xffeef4f2),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// HEADER
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Hello, Citizen",
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(Icons.notifications),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// PIE CHART
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const Text("Where Your Tax Goes"),

                          SizedBox(
                            height: 200,
                            child: PieChart(
                              PieChartData(
                                sections: items.map((e) {
                                  return PieChartSectionData(
                                    value: e.value,
                                    radius: 40,
                                    showTitle: false,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// LEGENDS
                          Column(
                            children: items.map((e) {
                              return LegendTile(
                                color: Colors.blue,
                                text: "${e.title}: ${e.value}%",
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// CARDS
                    Row(
                      children: items.map((e) {
                        return Expanded(
                          child: BudgetCard(
                            title: e.title,
                            amount: e.amount,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}