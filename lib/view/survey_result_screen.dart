import 'package:flutter/material.dart';

/*
============================
1. DOMAIN MODEL
============================
*/
class Domain {
  final String name;
  final IconData icon;

  Domain(this.name, this.icon);
}

final List<Domain> domains = [
  Domain("Education", Icons.school),
  Domain("Healthcare", Icons.local_hospital),
  Domain("Roads", Icons.alt_route),
  Domain("Water", Icons.water_drop),
  Domain("Electricity", Icons.bolt),
];

class ResultScreen extends StatelessWidget {
  final String domain;
  final String reason;
  final String sentiment;
  final double score;

  ResultScreen({
    required this.domain,
    required this.reason,
    required this.sentiment,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Analysis")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Domain: $domain", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("Reason: $reason"),
            Divider(),
            Card(
              child: ListTile(
                leading: Icon(Icons.psychology),
                title: Text("Sentiment: $sentiment"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.priority_high),
                title: Text(
                  "Priority Score: ${(score * 100).toInt()} / 100",
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              color: Colors.orange.shade100,
              child: Text("Status: Sent to Government"),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back"),
            )
          ],
        ),
      ),
    );
  }
}
