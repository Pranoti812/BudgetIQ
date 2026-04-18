import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FB),
      appBar: AppBar(
        title: Text("Citizen Dashboard"),
        backgroundColor: Color(0xFF1E3A8A),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📍 REGION
            Text(
              "Your Region: Nashik",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // 💰 TOTAL BUDGET CARD
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF6366F1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Budget", style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 5),
                  Text(
                    "₹ 10L Cr",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // 📊 SECTOR CARDS
            Text(
              "Sector Allocation",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sectorCard("Healthcare", "30%"),
                sectorCard("Education", "25%"),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sectorCard("Infrastructure", "28%"),
                sectorCard("Agriculture", "17%"),
              ],
            ),

            SizedBox(height: 20),

            // 📌 HIGHLIGHTS
            Text(
              "Quick Highlights",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            highlightTile("Healthcare spending increased"),
            highlightTile("Education underfunded"),
            highlightTile("Infrastructure stable"),

            SizedBox(height: 20),

            // 🔘 ACTION BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                actionButton("Compare"),
                actionButton("Insights"),
                actionButton("Feedback"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Sector Card Widget
  Widget sectorCard(String title, String value) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 14)),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Highlight Tile
  Widget highlightTile(String text) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.info, color: Color(0xFF6366F1)),
        title: Text(text),
      ),
    );
  }

  // 🔹 Action Button
  Widget actionButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1E3A8A)),
      onPressed: () {},
      child: Text(text),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomeScreen extends StatelessWidget {

//   // 🔹 Fetch Total Budget (sum of current_price)
//   Future<double> getTotalBudget() async {
//     var snapshot = await FirebaseFirestore.instance
//         .collection('gva_data')
//         .get();

//     double total = 0;

//     for (var doc in snapshot.docs) {
//       var value = doc['current_price'];

//       if (value != null) {
//         total += double.tryParse(value.toString()) ?? 0;
//       }
//     }

//     return total;
//   }

//   // 🔹 Fetch sector-wise percentage
//   Future<Map<String, double>> getSectorData() async {
//     var snapshot = await FirebaseFirestore.instance
//         .collection('gva_data')
//         .get();

//     Map<String, double> sectorTotals = {};
//     double grandTotal = 0;

//     for (var doc in snapshot.docs) {
//       String sector = doc['industry'] ?? "Other";
//       double value = double.tryParse(doc['current_price'].toString()) ?? 0;

//       sectorTotals[sector] = (sectorTotals[sector] ?? 0) + value;
//       grandTotal += value;
//     }

//     // Convert to %
//     sectorTotals.updateAll((key, value) => (value / grandTotal) * 100);

//     return sectorTotals;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF5F7FB),
//       appBar: AppBar(
//         title: Text("Citizen Dashboard"),
//         backgroundColor: Color(0xFF1E3A8A),
//         elevation: 0,
//       ),

//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 📍 REGION
//             Text(
//               "Your Region: Nashik",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             SizedBox(height: 10),

//             // 💰 TOTAL BUDGET CARD (Dynamic)
//             FutureBuilder<double>(
//               future: getTotalBudget(),
//               builder: (context, snapshot) {
//                 String value = "Loading...";

//                 if (snapshot.hasData) {
//                   double total = snapshot.data!;
//                   value = "₹ ${total.toStringAsFixed(0)}";
//                 }

//                 return Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF6366F1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Total Budget",
//                           style: TextStyle(color: Colors.white70)),
//                       SizedBox(height: 5),
//                       Text(
//                         value,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),

//             SizedBox(height: 20),

//             // 📊 SECTOR CARDS (Dynamic)
//             Text(
//               "Sector Allocation",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             SizedBox(height: 10),

//             FutureBuilder<Map<String, double>>(
//               future: getSectorData(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }

//                 var data = snapshot.data!;

//                 List keys = data.keys.toList();

//                 return Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         sectorCard(
//                             keys.length > 0 ? keys[0] : "NA",
//                             keys.length > 0
//                                 ? "${data[keys[0]]!.toStringAsFixed(1)}%"
//                                 : "0%"),
//                         sectorCard(
//                             keys.length > 1 ? keys[1] : "NA",
//                             keys.length > 1
//                                 ? "${data[keys[1]]!.toStringAsFixed(1)}%"
//                                 : "0%"),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         sectorCard(
//                             keys.length > 2 ? keys[2] : "NA",
//                             keys.length > 2
//                                 ? "${data[keys[2]]!.toStringAsFixed(1)}%"
//                                 : "0%"),
//                         sectorCard(
//                             keys.length > 3 ? keys[3] : "NA",
//                             keys.length > 3
//                                 ? "${data[keys[3]]!.toStringAsFixed(1)}%"
//                                 : "0%"),
//                       ],
//                     ),
//                   ],
//                 );
//               },
//             ),

//             SizedBox(height: 20),

//             // 📌 HIGHLIGHTS (Static as you had)
//             Text(
//               "Quick Highlights",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             SizedBox(height: 10),

//             highlightTile("Healthcare spending increased"),
//             highlightTile("Education underfunded"),
//             highlightTile("Infrastructure stable"),

//             SizedBox(height: 20),

//             // 🔘 ACTION BUTTONS
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 actionButton("Compare"),
//                 actionButton("Insights"),
//                 actionButton("Feedback"),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🔹 Sector Card Widget (UNCHANGED)
//   Widget sectorCard(String title, String value) {
//     return Container(
//       width: 150,
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
//       ),
//       child: Column(
//         children: [
//           Text(title, style: TextStyle(fontSize: 14)),
//           SizedBox(height: 5),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1E3A8A),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 Highlight Tile (UNCHANGED)
//   Widget highlightTile(String text) {
//     return Card(
//       child: ListTile(
//         leading: Icon(Icons.info, color: Color(0xFF6366F1)),
//         title: Text(text),
//       ),
//     );
//   }

//   // 🔹 Action Button (UNCHANGED)
//   Widget actionButton(String text) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1E3A8A)),
//       onPressed: () {},
//       child: Text(text),
//     );
//   }
// }
