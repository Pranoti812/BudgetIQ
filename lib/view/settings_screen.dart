import 'package:budegt_iq/view/gov_bottm_nav.dart';
import 'package:flutter/material.dart';

class DataIntegrationScreen extends StatefulWidget {
  const DataIntegrationScreen({super.key});

  @override
  State<DataIntegrationScreen> createState() =>
      _DataIntegrationScreenState();
}

class _DataIntegrationScreenState extends State<DataIntegrationScreen> {
  int currentIndex = 4; // Settings tab active

  void _onNavTap(int index) {
    setState(() => currentIndex = index);

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/simulation');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/ai');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/regions');
        break;
      case 4:
        break; // already here
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
                    "Data Integration",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Connected Data Sources
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.storage, color:Color(0xff00d641)),
                        SizedBox(width: 10),
                        Text(
                          "Connected Data Sources",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Manage AI data pipeline",
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _statBox(
                            "4",
                            "Active Sources",
                            Colors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _statBox(
                            "5",
                            "Total Sources",
                            Colors.blueGrey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// DATA ITEMS
              _dataItem(
                title: "Census Data",
                subtitle: "Population demographics and statistics",
                lastSync: "Last sync: 2 hours ago",
                active: true,
              ),
              _dataItem(
                title: "Economic Indicators",
                subtitle: "GDP, inflation, employment data",
                lastSync: "Last sync: 1 day ago",
                active: true,
              ),
              _dataItem(
                title: "Health Records",
                subtitle: "Disease prevalence and healthcare metrics",
                lastSync: "Last sync: 3 hours ago",
                active: true,
              ),
              _dataItem(
                title: "Education Statistics",
                subtitle: "Literacy rates and school enrollment",
                lastSync: "Last sync: 7 days ago",
                active: false,
              ),
              _dataItem(
                title: "Infrastructure Data",
                subtitle: "Roads, utilities, and public facilities",
                lastSync: "Last sync: 5 hours ago",
                active: true,
              ),

              const SizedBox(height: 20),

              /// ADD BUTTON
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF43A047), Color(0xFF81C784)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.storage, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Add New Data Source",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- CARD ----------
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10)
        ],
      ),
      child: child,
    );
  }

  /// ---------- STAT BOX ----------
  Widget _statBox(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  /// ---------- DATA ITEM ----------
  Widget _dataItem({
    required String title,
    required String subtitle,
    required String lastSync,
    required bool active,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(width: 6),
                  Icon(
                    active ? Icons.check_circle : Icons.info_outline,
                    color: active ? Colors.green : Colors.grey,
                    size: 18,
                  )
                ],
              ),
              _statusBadge(active),
            ],
          ),

          const SizedBox(height: 6),

          Text(subtitle, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 4),
          Text(lastSync,
              style:
                  const TextStyle(color: Colors.black38, fontSize: 12)),

          const SizedBox(height: 12),

          if (active)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, size: 18),
                  SizedBox(width: 6),
                  Text("Sync Now"),
                ],
              ),
            )
        ],
      ),
    );
  }

  /// ---------- STATUS BADGE ----------
  Widget _statusBadge(bool active) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: active
            ? Colors.green.withOpacity(0.1)
            : Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        active ? "Active" : "Inactive",
        style: TextStyle(
          color: active ? Colors.green : Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}