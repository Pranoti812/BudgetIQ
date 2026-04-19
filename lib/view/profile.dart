// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'BudgetIQ',
//       home: const NotificationsScreen(),
//     );
//   }
// }

// class NotificationsScreen extends StatelessWidget {
//   const NotificationsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FA),

//       body: SafeArea(
//         child: Column(
//           children: [
//             // 🔹 HEADER
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: Row(
//                 children: const [
//                   Icon(Icons.arrow_back_ios, size: 18),
//                   SizedBox(width: 10),
//                   Text(
//                     "Notifications",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 10),

//             // 🔹 LIST
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 children: const [
//                   NotificationCard(
//                     icon: Icons.trending_up,
//                     iconColor: Colors.green,
//                     title: "New Healthcare Policy",
//                     subtitle:
//                         "Government announces ₹500B increase in healthcare spending for rural areas",
//                     time: "2 hours ago",
//                     tag: "policy",
//                   ),
//                   NotificationCard(
//                     icon: Icons.notifications_none,
//                     iconColor: Colors.blue,
//                     title: "Budget Alert",
//                     subtitle:
//                         "Education budget revised from ₹2.1T to ₹2.5T for FY 2026-27",
//                     time: "1 day ago",
//                     tag: "budget",
//                   ),
//                   NotificationCard(
//                     icon: Icons.error_outline,
//                     iconColor: Colors.orange,
//                     title: "Transparency Update",
//                     subtitle:
//                         "New district-level budget data now available for Karnataka",
//                     time: "3 days ago",
//                     tag: "alert",
//                   ),

//                   SizedBox(height: 30),

//                   Center(
//                     child: Text(
//                       "You're all caught up!",
//                       style: TextStyle(color: Colors.grey, fontSize: 13),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),

//       // 🔹 BOTTOM NAV BAR
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.teal,
//         unselectedItemColor: Colors.grey,
//         currentIndex: 4,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.map_outlined),
//             label: "Regions",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.compare_arrows),
//             label: "Compare",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat_bubble_outline),
//             label: "AI Chat",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }

// // 🔥 CARD WIDGET
// class NotificationCard extends StatelessWidget {
//   final IconData icon;
//   final Color iconColor;
//   final String title;
//   final String subtitle;
//   final String time;
//   final String tag;

//   const NotificationCard({
//     super.key,
//     required this.icon,
//     required this.iconColor,
//     required this.title,
//     required this.subtitle,
//     required this.time,
//     required this.tag,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),

//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),

//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ICON
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: iconColor.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(icon, color: iconColor, size: 20),
//           ),

//           const SizedBox(width: 12),

//           // TEXT
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // TITLE + TAG
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         title,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ),

//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         tag,
//                         style: const TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 6),

//                 Text(
//                   subtitle,
//                   style: const TextStyle(fontSize: 13, color: Colors.grey),
//                 ),

//                 const SizedBox(height: 8),

//                 Text(
//                   time,
//                   style: const TextStyle(fontSize: 11, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:budegt_iq/view/home_screen.dart'; // 🔥 ADDED IMPORT
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  // 🔥 HANDLE SYSTEM BACK BUTTON — navigates back to CitizenHomeScreen
  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const CitizenHomeScreen()),
      (route) => false,
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 WRAPPED WITH WillPopScope TO INTERCEPT SYSTEM BACK BUTTON
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),

        body: SafeArea(
          child: Column(
            children: [
              // 🔹 HEADER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    // 🔥 BACK ARROW ALSO NAVIGATES TO CitizenHomeScreen
                    GestureDetector(
                      onTap: () => _onWillPop(context),
                      child: const Icon(Icons.arrow_back_ios, size: 18),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // 🔹 LIST
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    NotificationCard(
                      icon: Icons.trending_up,
                      iconColor: Colors.green,
                      title: "New Healthcare Policy",
                      subtitle:
                          "Government announces ₹500B increase in healthcare spending for rural areas",
                      time: "2 hours ago",
                      tag: "policy",
                    ),
                    NotificationCard(
                      icon: Icons.notifications_none,
                      iconColor: Colors.blue,
                      title: "Budget Alert",
                      subtitle:
                          "Education budget revised from ₹2.1T to ₹2.5T for FY 2026-27",
                      time: "1 day ago",
                      tag: "budget",
                    ),
                    NotificationCard(
                      icon: Icons.error_outline,
                      iconColor: Colors.orange,
                      title: "Transparency Update",
                      subtitle:
                          "New district-level budget data now available for Karnataka",
                      time: "3 days ago",
                      tag: "alert",
                    ),

                    SizedBox(height: 30),

                    Center(
                      child: Text(
                        "You're all caught up!",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 🔹 BOTTOM NAV BAR
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          currentIndex: 4,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: "Regions",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows),
              label: "Compare",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: "AI Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

// 🔥 CARD WIDGET
class NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;
  final String tag;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICON
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),

          const SizedBox(width: 12),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE + TAG
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),

                const SizedBox(height: 8),

                Text(
                  time,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
