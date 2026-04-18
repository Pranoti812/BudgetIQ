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
