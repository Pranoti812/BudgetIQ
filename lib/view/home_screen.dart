import 'package:budegt_iq/view/bottom_nav.dart';
import 'package:budegt_iq/view/upload_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budegt_iq/controller/home_controller.dart';

class CitizenHomeScreen extends StatefulWidget {
  const CitizenHomeScreen({super.key});

  @override
  State<CitizenHomeScreen> createState() => _CitizenHomeScreenState();
}

class _CitizenHomeScreenState extends State<CitizenHomeScreen> {
  final controller = HomeController();
  bool isLoading = true;
  int currentIndex = 0;
  bool isUploaded = false;

  @override
  void initState() {
    super.initState();
    uploadDataOnce();
    loadData(); // ✅ merged both initStates
  }

  Future<void> uploadDataOnce() async {
    if (!isUploaded) {
      isUploaded = true;
      await UploadService.uploadJsonToFirebase();
    }
  }

  Future<void> loadData() async {
    await controller.loadData();
    setState(() => isLoading = false);
  }

  Future<Map<String, dynamic>> getBudgetData() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('gva_data').get();

    Map<String, double> sectorTotals = {};
    double total = 0;

    for (var doc in snapshot.docs) {
      String sector = doc['industry'] ?? "Other";
      double value =
          double.tryParse(doc['current_price'].toString()) ?? 0;

      sectorTotals[sector] = (sectorTotals[sector] ?? 0) + value;
      total += value;
    }

    Map<String, double> percentages = {};
    sectorTotals.forEach((key, value) {
      percentages[key] = (value / total) * 100;
    });

    var sortedKeys = sectorTotals.keys.toList()
      ..sort((a, b) => sectorTotals[b]!.compareTo(sectorTotals[a]!));

    return {
      "percentages": percentages,
      "totals": sectorTotals,
      "keys": sortedKeys,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeef4f2),

      // ✅ KEEP ONLY ONE bottom nav
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

                    /// PIE CHART
                    FutureBuilder(
                      future: getBudgetData(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        var data = snapshot.data as Map<String, dynamic>;
                        Map<String, double> percentages =
                            data['percentages'];
                        List keys = data['keys'];

                        final colors = [
                          Color(0xff18b9ab),
                          Color(0xff17c455),
                          Color(0xff2f77f6),
                          Color(0xff9b52f2),
                        ];

                        int count = keys.length > 4 ? 4 : keys.length;

                        return SizedBox(
                          height: 280,
                          child: PieChart(
                            PieChartData(
                              centerSpaceRadius: 65,
                              sectionsSpace: 7,
                              sections: List.generate(count, (index) {
                                return PieChartSectionData(
                                  value: percentages[keys[index]]!,
                                  color: colors[index],
                                  radius: 48,
                                  showTitle: false,
                                );
                              }),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    /// LEGEND
                    FutureBuilder(
                      future: getBudgetData(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return SizedBox();

                        var data = snapshot.data as Map<String, dynamic>;
                        Map<String, double> percentages =
                            data['percentages'];
                        List keys = data['keys'];

                        final colors = [
                          Color(0xff18b9ab),
                          Color(0xff17c455),
                          Color(0xff2f77f6),
                          Color(0xff9b52f2),
                        ];

                        int count = keys.length > 4 ? 4 : keys.length;

                        return Column(
                          children: List.generate(
                            (count / 2).ceil(),
                            (rowIndex) {
                              int i = rowIndex * 2;

                              return Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 14),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (i < count)
                                      LegendTile(
                                        color: colors[i],
                                        text:
                                            "${keys[i]}: ${percentages[keys[i]]!.toStringAsFixed(1)}%",
                                      ),
                                    if (i + 1 < count)
                                      LegendTile(
                                        color: colors[i + 1],
                                        text:
                                            "${keys[i + 1]}: ${percentages[keys[i + 1]]!.toStringAsFixed(1)}%",
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 28),

                    /// BUDGET CARDS
                    FutureBuilder(
                      future: getBudgetData(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return SizedBox();

                        var data = snapshot.data as Map<String, dynamic>;
                        Map<String, double> totals = data['totals'];
                        List keys = data['keys'];

                        int count = keys.length > 3 ? 3 : keys.length;

                        final icons = [
                          Icons.favorite_border,
                          Icons.school_outlined,
                          Icons.apartment_outlined,
                        ];

                        final colors = [
                          Color(0xff12b8aa),
                          Color(0xff18c54e),
                          Color(0xff2f77f6),
                        ];

                        return Row(
                          children: List.generate(count, (index) {
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: index != count - 1 ? 16 : 0),
                                child: BudgetCard(
                                  icon: icons[index],
                                  iconColor: colors[index],
                                  title: keys[index],
                                  amount:
                                      "₹${totals[keys[index]]!.toStringAsFixed(0)}",
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// 🔹 LEGEND TILE (REQUIRED)
class LegendTile extends StatelessWidget {
  final Color color;
  final String text;

  const LegendTile({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(   
      constraints: BoxConstraints(maxWidth: 140), 
      child: Row(
        mainAxisSize: MainAxisSize.min, 
        children: [
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(  
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 BUDGET CARD (REQUIRED)

class BudgetCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String amount;

  const BudgetCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      padding: const EdgeInsets.all(10), 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            color: Colors.black.withOpacity(.06),
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 40),

          const SizedBox(height: 10),

          // 🔥 FIX: Title flexible
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 6),

          
          Flexible(
            child: Text(
              amount,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}