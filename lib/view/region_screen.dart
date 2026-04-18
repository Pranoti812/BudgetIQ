import 'package:flutter/material.dart';
import '../controller/region_controller.dart';
import '../model/region_model.dart';

class RegionScreen extends StatefulWidget {
  const RegionScreen({super.key});

  @override
  State<RegionScreen> createState() => _RegionScreenState();
}

class _RegionScreenState extends State<RegionScreen> {
  final controller = RegionController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await controller.loadRegions();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1A33),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Region Optimization"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _heatmap(),
                  const SizedBox(height: 20),
                  _regionList(),
                ],
              ),
            ),
    );
  }

  /// 🔥 HEATMAP
  Widget _heatmap() {
    return _card(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: controller.regions.map((region) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _priorityColor(region.priority).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _priorityColor(region.priority)),
            ),
            child: Column(
              children: [
                Text(region.name,
                    style: const TextStyle(color: Colors.white)),
                Text("₹${region.deficit}B",
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 🔥 REGION LIST
  Widget _regionList() {
    return Column(
      children: controller.regions.map((r) {
        return _regionCard(r);
      }).toList(),
    );
  }

  Widget _regionCard(RegionModel r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(r.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              _priorityBadge(r.priority),
            ],
          ),

          Text("Population: ${r.population}M",
              style: const TextStyle(color: Colors.white70)),

          const SizedBox(height: 10),

          /// Stats
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _row("Budget Deficit", "-₹${r.deficit}B", Colors.red),
                _row("Recommended Increase", "+₹${r.recommended}B", Colors.green),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// Suggestion
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.purple),
            ),
            child: Text(r.suggestion,
                style: const TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  Widget _row(String title, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70)),
        Text(value, style: TextStyle(color: color)),
      ],
    );
  }

  Widget _priorityBadge(String priority) {
    Color color = _priorityColor(priority);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(priority,
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }

  Color _priorityColor(String p) {
    switch (p) {
      case "HIGH":
        return Colors.red;
      case "MEDIUM":
        return Colors.orange;
      default:
        return Colors.yellow;
    }
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: child,
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFF142544),
      borderRadius: BorderRadius.circular(16),
    );
  }
}