import 'package:budegt_iq/view/bottom_nav.dart';
import 'package:budegt_iq/view/upload_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CitizenHomeScreen extends StatefulWidget {
  const CitizenHomeScreen({super.key});

  @override
  State<CitizenHomeScreen> createState() => _CitizenHomeScreenState();
}

class _CitizenHomeScreenState extends State<CitizenHomeScreen> {
  int currentIndex = 0;

  bool isUploaded = false; // 🔥 ADDED

  @override
  void initState() {
    super.initState();

    // 🔥 Upload data automatically once
    uploadDataOnce();
  }

  Future<void> uploadDataOnce() async {
    if (!isUploaded) {
      isUploaded = true;

      print("🚀 Uploading data...");
      await UploadService.uploadJsonToFirebase();
      print("✅ Upload complete");
    }
  }

  // 🔥 FETCH DATA FROM FIREBASE (UNCHANGED)
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

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, Citizen",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Track your government's budget allocation",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      const Icon(
                        Icons.notifications_none,
                        size: 34,
                        color: Color(0xff00b8a9),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          height: 22,
                          width: 22,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              "3",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),

              const SizedBox(height: 30),

              /// PIE CARD
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.08),
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Where Your Tax Goes",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 30),

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
                    
                  ],
                ),
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

              const SizedBox(height: 20),

                Container(
                height: 68,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff14b8b0),
                      Color(0xff00d641),
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    "View Region Insights",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// WHITE BUTTON
              Container(
                height: 68,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xffb8f2e5),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black12,
                      offset: Offset(0, 6),
                    )
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble_outline, size: 24),
                    SizedBox(width: 10),
                    Text(
                      "Ask AI Assistant",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
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
    return Container(   // 🔥 WRAP WITH CONTAINER
      constraints: BoxConstraints(maxWidth: 140), // 🔥 LIMIT WIDTH
      child: Row(
        mainAxisSize: MainAxisSize.min, // 🔥 IMPORTANT
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
          Expanded(   // 🔥 keep Expanded here
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
      padding: const EdgeInsets.all(10), // 🔥 added padding
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

          // 🔥 FIX: Amount flexible
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