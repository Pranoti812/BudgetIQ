import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> messages = [
    {
      "role": "bot",
      "text":
          "Hello! I'm your budget assistant.\nAsk me anything about government spending!"
    }
  ];

  // 🔑 Replace with your Gemini API Key
  final String apiKey = "AIzaSyDHOmUlbZ8HDo1OVSXaGbcAyn_mOCCTnWw";

  // 🔥 API CALL
  // Future<String> getAIResponse(String userInput) async {
  //   const String url =
  //       "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent";

  //   try {
  //     final response = await http.post(
  //       Uri.parse("$url?key=$apiKey"),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "contents": [
  //           {
  //             "parts": [
  //               {
  //                 "text":
  //                     "You are a government budget assistant. Answer clearly.\n\nUser: $userInput"
  //               }
  //             ]
  //           }
  //         ]
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return data["candidates"][0]["content"]["parts"][0]["text"];
  //     } else {
  //       return "Error: Unable to fetch response (${response.statusCode})";
  //     }
  //   } catch (e) {
  //     return "Error: $e";
  //   }
  // }

Future<String> getAIResponse(String userInput) async {
  try {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );

    final response = await model.generateContent([
      Content.text(
        "You are a government budget assistant. Answer clearly.\n\n$userInput",
      )
    ]);

    if (response.candidates.isEmpty) {
      return "No response generated.";
    }

    final text = response.candidates.first.content.parts
        .whereType<TextPart>()
        .map((e) => e.text)
        .join();

    return text.isNotEmpty ? text : "Empty response";
  } catch (e) {
    return "Error: $e";
  }
}
  // 🔥 SEND MESSAGE
  void sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({"role": "user", "text": text});
      messages.add({"role": "bot", "text": "Typing..."});
    });

    _controller.clear();
    scrollToBottom();

    String reply = await getAIResponse(text);

    setState(() {
      messages.removeLast(); // remove typing
      messages.add({"role": "bot", "text": reply});
    });

    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // 🔹 CHIP WIDGET
  Widget buildChip(String text) {
    return GestureDetector(
      onTap: () => sendMessage(text),
      child: Container(
        width: (MediaQuery.of(context).size.width - 48) / 2,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.teal.shade200),
        ),
        child: Text(text, style: const TextStyle(fontSize: 13)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F4),
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 HEADER
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.teal),
                  SizedBox(width: 10),
                  Text(
                    "AI Assistant",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            // 🔹 SUGGESTIONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  buildChip("What's the healthcare budget?"),
                  buildChip("Compare states spending"),
                  buildChip("Where does my tax go?"),
                  buildChip("Education budget trends"),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 CHAT LIST
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isUser = msg["role"] == "user";

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth:
                            MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Colors.teal.shade100
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(msg["text"] ?? ""),
                    ),
                  );
                },
              ),
            ),

            // 🔹 INPUT BAR
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: "Ask about budget allocation...",
                          border: InputBorder.none,
                        ),
                        onSubmitted: sendMessage,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.mic, color: Colors.grey),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.teal),
                      onPressed: () => sendMessage(_controller.text),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}