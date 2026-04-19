import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

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
  List<DataSource> sources = [
    DataSource(
      name: "Census Data",
      description: "Population demographics and statistics",
      isActive: true,
      lastSync: "2 hours ago",
    ),
  ];

  /// ➕ ADD SOURCE (UNCHANGED LOGIC)
  void _openAddBottomSheet() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();
    bool isActive = true;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1C2A44),
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),

                  const SizedBox(height: 16),

                  _inputField("Name", nameController),
                  _inputField("Description", descController),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Active",
                          style: TextStyle(color: Colors.white)),
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
                      backgroundColor: Colors.purple,
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

  Widget _inputField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3A5A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }

  /// 🔄 SYNC (UNCHANGED)
  void _syncData(int index) async {
    setState(() {
      sources[index].isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      sources[index].isLoading = false;
      sources[index].lastSync = "Just now";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1A33),
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DashboardScreen()),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Data Integration",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
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

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C2A44),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TITLE + SWITCH
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(source.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
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
                            style: const TextStyle(
                                color: Colors.white70)),

                        const SizedBox(height: 4),

                        Text("Last sync: ${source.lastSync}",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white54)),

                        const SizedBox(height: 12),

                        /// BUTTON
                        if (source.isActive)
                          GestureDetector(
                            onTap: source.isLoading
                                ? null
                                : () => _syncData(index),
                            child: Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(
                                      vertical: 12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.purple,
                                    Colors.deepPurple
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: source.isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Sync Now",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight:
                                                FontWeight.bold),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.purple,
                        Colors.deepPurple
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      "Add New Data Source",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
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