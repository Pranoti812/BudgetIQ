// import 'package:flutter/material.dart';

// class SimulationScreen extends StatefulWidget {
//   const SimulationScreen({Key? key}) : super(key: key);

//   @override
//   State<SimulationScreen> createState() => _SimulationScreenState();
// }

// class _SimulationScreenState extends State<SimulationScreen> {
//   double healthcare = 40;
//   double defense = 40;
//   double agriculture = 40;

//   final Gradient primaryGradient = const LinearGradient(
//     colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
//     begin: Alignment.centerLeft,
//     end: Alignment.centerRight,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F9F7),
//       bottomNavigationBar: _buildBottomNav(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               const SizedBox(height: 20),

//               /// Adjust Budget Allocation
//               _sectionCard(
//                 title: "Adjust Budget Allocation",
//                 child: Column(
//                   children: [
//                     _budgetSlider("Healthcare", healthcare, (val) {
//                       setState(() => healthcare = val);
//                     }),
//                     _budgetSlider("Defense", defense, (val) {
//                       setState(() => defense = val);
//                     }),
//                     _budgetSlider("Agriculture", agriculture, (val) {
//                       setState(() => agriculture = val);
//                     }),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               /// Impact Projection
//               _sectionCard(
//                 title: "Impact Projection (5 Years)",
//                 child: _mockChart(),
//               ),

//               const SizedBox(height: 20),

//               /// Trade-offs Analysis
//               _sectionCard(
//                 title: "Trade-offs Analysis",
//                 child: Column(
//                   children: [
//                     _infoTile(
//                       title: "Economic Impact",
//                       subtitle: "+0% GDP growth by 2028",
//                       gradient: primaryGradient,
//                     ),
//                     const SizedBox(height: 12),
//                     _infoTile(
//                       title: "Social Welfare",
//                       subtitle:
//                           "Healthcare improvement affects life expectancy +0 years",
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF66BB6A), Color(0xFFA5D6A7)],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// ---------------- HEADER ----------------
//   Widget _buildHeader() {
//     return Row(
//       children: const [
//         Icon(Icons.arrow_back, size: 22),
//         SizedBox(width: 10),
//         Text(
//           "Scenario Simulation",
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }

//   /// ---------------- SECTION CARD ----------------
//   Widget _sectionCard({required String title, required Widget child}) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style:
//                   const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//           const SizedBox(height: 16),
//           child,
//         ],
//       ),
//     );
//   }

//   /// ---------------- SLIDER ----------------
//   Widget _budgetSlider(
//       String label, double value, Function(double) onChanged) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(label,
//                 style:
//                     const TextStyle(fontSize: 14, color: Colors.black54)),
//             Text("${value.toInt()}%",
//                 style:
//                     const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//           ],
//         ),
//         SliderTheme(
//           data: SliderThemeData(
//             activeTrackColor: Colors.green,
//             inactiveTrackColor: Colors.green.shade100,
//             thumbColor: Colors.green,
//             overlayColor: Colors.green.withOpacity(0.2),
//           ),
//           child: Slider(
//             value: value,
//             min: 0,
//             max: 100,
//             onChanged: onChanged,
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }

//   /// ---------------- MOCK CHART ----------------
//   Widget _mockChart() {
//     return Container(
//       height: 180,
//       decoration: BoxDecoration(
//         color: const Color(0xFFF1F8F4),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: const Center(
//         child: Text(
//           "Line Chart Placeholder\n(Economic Growth & Public Satisfaction)",
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.black45),
//         ),
//       ),
//     );
//   }

//   /// ---------------- INFO TILE ----------------
//   Widget _infoTile({
//     required String title,
//     required String subtitle,
//     required Gradient gradient,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         gradient: gradient,
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: const TextStyle(
//                   color: Colors.white, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 6),
//           Text(subtitle,
//               style: const TextStyle(color: Colors.white70, fontSize: 13)),
//         ],
//       ),
//     );
//   }

//   /// ---------------- BOTTOM NAV ----------------
//   Widget _buildBottomNav() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, -2))
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _navItem(Icons.dashboard, "Dashboard", false),
//           _navItem(Icons.show_chart, "Simulation", true),
//           _navItem(Icons.lightbulb_outline, "AI Insights", false),
//           _navItem(Icons.location_on_outlined, "Regions", false),
//           _navItem(Icons.settings, "Settings", false),
//         ],
//       ),
//     );
//   }

//   Widget _navItem(IconData icon, String label, bool active) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon,
//             color: active ? Colors.green : Colors.grey, size: 22),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 11,
//             color: active ? Colors.green : Colors.grey,
//           ),
//         )
//       ],
//     );
//   }
// }
import 'package:budegt_iq/view/gov_bottm_nav.dart';
import 'package:flutter/material.dart';


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

  void _onNavTap(int index) {
    setState(() => currentIndex = index);

    /// 👉 Hook into your existing routes here
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
              /// Header
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

              /// Adjust Budget Allocation
              _card(
                "Adjust Budget Allocation",
                Column(
                  children: [
                    _slider("Healthcare", healthcare,
                        (v) => setState(() => healthcare = v)),
                    _slider("Defense", defense,
                        (v) => setState(() => defense = v)),
                    _slider("Agriculture", agriculture,
                        (v) => setState(() => agriculture = v)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Impact Projection
              _card(
                "Impact Projection (5 Years)",
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Line Chart Placeholder\n(Economic Growth & Public Satisfaction)",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Trade-offs Analysis
              _card(
                "Trade-offs Analysis",
                Column(
                  children: [
                    _infoTile(
                      "Economic Impact",
                      "+0% GDP growth by 2028",
                      Colors.green,
                    ),
                    const SizedBox(height: 12),
                    _infoTile(
                      "Social Welfare",
                      "Healthcare improvement affects life expectancy +0 years",
                      Colors.green.shade400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Card UI
  Widget _card(String title, Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          child
        ],
      ),
    );
  }

  /// Slider
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

  /// Info Tile
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
              style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }
}