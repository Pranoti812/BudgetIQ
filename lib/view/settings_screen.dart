import 'package:flutter/material.dart';
import 'package:budegt_iq/view/gov_bottm_nav.dart';


class DataSource {
  String name;
  String description;
  bool isActive;
  String lastSync;
  bool isLoading;

  DataSource({
    required this.name,
    required this.description,
    required this.isActive,
    required this.lastSync,
    this.isLoading = false,
  });
}

class DataIntegrationScreen extends StatefulWidget {
  const DataIntegrationScreen({super.key});

  @override
  State<DataIntegrationScreen> createState() =>
      _DataIntegrationScreenState();
}

class _DataIntegrationScreenState extends State<DataIntegrationScreen> {
  int currentIndex = 4;

  List<DataSource> sources = [
    DataSource(
      name: "Census Data",
      description: "Population demographics and statistics",
      isActive: true,
      lastSync: "2 hours ago",
    ),
  ];

  /// 🔁 NAVIGATION
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
        break;
    }
  }

  /// ➕ OPEN BOTTOM SHEET
  void _openAddBottomSheet() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();
    bool isActive = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Add Data Source",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 16),

                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Active"),
                      Switch(
                        value: isActive,
                        onChanged: (val) {
                          setModalState(() => isActive = val);
                        },
                      )
                    ],
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        setState(() {
                          sources.insert(
                            0,
                            DataSource(
                              name: nameController.text,
                              description: descController.text,
                              isActive: isActive,
                              lastSync: "Never",
                            ),
                          );
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Add"),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// 🔄 SYNC FUNCTION (WITH LOADING ANIMATION)
  void _syncData(int index) async {
    setState(() {
      sources[index].isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2)); // simulate API

    setState(() {
      sources[index].isLoading = false;
      sources[index].lastSync = "Just now";
    });
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
        child: Column(
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 10),
                  Text(
                    "Data Integration",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            /// LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: sources.length,
                itemBuilder: (context, index) {
                  final source = sources[index];

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TITLE + TOGGLE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(source.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Switch(
                              value: source.isActive,
                              onChanged: (val) {
                                setState(() {
                                  source.isActive = val;
                                });
                              },
                            )
                          ],
                        ),

                        const SizedBox(height: 6),

                        Text(source.description,
                            style:
                                const TextStyle(color: Colors.black54)),

                        const SizedBox(height: 4),

                        Text("Last sync: ${source.lastSync}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black38)),

                        const SizedBox(height: 12),

                        /// SYNC BUTTON / LOADING
                        if (source.isActive)
                          GestureDetector(
                            onTap: source.isLoading
                                ? null
                                : () => _syncData(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF43A047),
                                    Color(0xFF81C784)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: source.isLoading
                                    ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        "Sync Now",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

            /// ADD BUTTON
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: _openAddBottomSheet,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF43A047), Color(0xFF81C784)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      "Add New Data Source",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}