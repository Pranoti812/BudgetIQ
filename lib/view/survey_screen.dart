import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyScreen extends StatefulWidget {
  final String region;

  const SurveyScreen({super.key, required this.region});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  String selectedSector = "Healthcare";
  double rating = 3;
  bool isLoading = false;

  final TextEditingController commentController = TextEditingController();

  final List<String> sectors = [
    "Healthcare",
    "Education",
    "Infrastructure",
    "Agriculture"
  ];

  /// 🔥 SUBMIT TO FIREBASE
  Future<void> submitSurvey() async {
    if (commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter feedback")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseFirestore.instance.collection("surveys").add({
        "region": widget.region,
        "sector": selectedSector,
        "rating": rating,
        "comment": commentController.text.trim(),
        "timestamp": FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Feedback Submitted")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() => isLoading = false);
  }

  /// 🔥 INPUT BOX
  Widget _inputBox({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2A44),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  /// 🔥 BUTTON
  Widget _button() {
    return GestureDetector(
      onTap: isLoading ? null : submitSurvey,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.deepPurple],
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  "Submit Feedback",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1A33),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1A33),
        elevation: 0,
        title: Text("Survey - ${widget.region}"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1C2A44),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Citizen Feedback",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Help improve budget allocation by sharing your feedback",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// SECTOR
            _inputBox(
              child: DropdownButtonFormField(
                value: selectedSector,
                dropdownColor: const Color(0xFF1C2A44),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Select Sector",
                  labelStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                items: sectors
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() => selectedSector = val.toString());
                },
              ),
            ),

            const SizedBox(height: 16),

            /// RATING CARD
            _inputBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Rate this sector",
                      style: TextStyle(color: Colors.white70)),
                  Slider(
                    value: rating,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: rating.toString(),
                    activeColor: Colors.purple,
                    onChanged: (val) => setState(() => rating = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// COMMENT BOX
            _inputBox(
              child: TextField(
                controller: commentController,
                style: const TextStyle(color: Colors.white),
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "Enter detailed feedback...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// BUTTON
            _button(),
          ],
        ),
      ),
    );
  }
}