import 'package:budegt_iq/view/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CitizenHomeScreen extends StatefulWidget {
  const CitizenHomeScreen({super.key});

  @override
  State<CitizenHomeScreen> createState() => _CitizenHomeScreenState();
}

class _CitizenHomeScreenState extends State<CitizenHomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08132f),

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
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Track your government's budget allocation",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      const Icon(
                        Icons.notifications_none,
                        size: 34,
                        color: Color(0xff00ff9c),
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

              /// TAX CARD
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xff162341),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.25),
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
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      height: 280,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 65,
                          sectionsSpace: 7,
                          sections: [
                            PieChartSectionData(
                              value: 35,
                              color: const Color(0xff1fd3c6),
                              radius: 48,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              value: 30,
                              color: const Color(0xff00ff85),
                              radius: 48,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              value: 25,
                              color: const Color(0xff4a8dff),
                              radius: 48,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              value: 10,
                              color: const Color(0xff9a46ff),
                              radius: 48,
                              showTitle: false,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LegendTile(
                          color: Color(0xff1fd3c6),
                          text: "Healthcare: 35%",
                        ),
                        LegendTile(
                          color: Color(0xff00ff85),
                          text: "Education: 30%",
                        ),
                      ],
                    ),

                    SizedBox(height: 14),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LegendTile(
                          color: Color(0xff4a8dff),
                          text: "Infrastructure: 25%",
                        ),
                        LegendTile(
                          color: Color(0xff9a46ff),
                          text: "Others: 10%",
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// SMALL CARDS
              const Row(
                children: [
                  Expanded(
                    child: BudgetCard(
                      icon: Icons.favorite_border,
                      iconColor: Color(0xff1fd3c6),
                      title: "Healthcare",
                      amount: "₹2.5T",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: BudgetCard(
                      icon: Icons.school_outlined,
                      iconColor: Color(0xff00ff85),
                      title: "Education",
                      amount: "₹2.1T",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: BudgetCard(
                      icon: Icons.apartment_outlined,
                      iconColor: Color(0xff4a8dff),
                      title: "Infra",
                      amount: "₹1.8T",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              /// BUTTON 1
              Container(
                height: 68,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff8a2cff),
                      Color(0xff6f3cff),
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

              /// BUTTON 2
              Container(
                height: 68,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff162341),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white10,
                    width: 1.2,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 24,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Ask AI Assistant",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),

      /// REUSABLE NAV BAR
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
    return Row(
      children: [
        Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

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
      decoration: BoxDecoration(
        color: const Color(0xff162341),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            color: Colors.black.withOpacity(.20),
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 48),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  }