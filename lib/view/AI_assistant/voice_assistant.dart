// // // import 'package:flutter/material.dart';
// // // import 'package:speech_to_text/speech_to_text.dart' as stt;
// // // import 'package:flutter_tts/flutter_tts.dart';
// // // import 'package:flutter_dotenv/flutter_dotenv.dart';
// // // import 'openai_service.dart';

// // // class VoiceAssistant extends StatefulWidget {
// // //   const VoiceAssistant({super.key});

// // //   @override
// // //   State<VoiceAssistant> createState() => _VoiceAssistantState();
// // // }

// // // class _VoiceAssistantState extends State<VoiceAssistant>
// // //     with SingleTickerProviderStateMixin {
// // //   late stt.SpeechToText _speech;
// // //   late FlutterTts _tts;
// // //   late OpenAIService _openAI;
// // //   late AnimationController _pulseController;
// // //   late Animation<double> _pulseAnimation;

// // //   bool _isListening = false;
// // //   bool _isProcessing = false;
// // //   bool _isSpeaking = false;
// // //   String _userWords = '';
// // //   String _assistantReply = '';
// // //   String _statusMessage = 'Ready to assist you';

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _speech = stt.SpeechToText();
// // //     _tts = FlutterTts();

// // //     // Animation for pulse effect
// // //     _pulseController = AnimationController(
// // //       duration: const Duration(milliseconds: 1500),
// // //       vsync: this,
// // //     )..repeat(reverse: true);

// // //     _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
// // //       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
// // //     );

// // //     final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
// // //     if (apiKey.isEmpty) {
// // //       _statusMessage = 'Please add GEMINI_API_KEY to .env file';
// // //     }

// // //     _openAI = OpenAIService(apiKey: apiKey);
// // //     _initializeTTS();
// // //   }

// // //   Future<void> _initializeTTS() async {
// // //     await _tts.setLanguage("en-US");
// // //     await _tts.setSpeechRate(0.5);
// // //     await _tts.setPitch(1.0);
// // //     await _tts.setVolume(1.0);

// // //     _tts.setCompletionHandler(() {
// // //       setState(() => _isSpeaking = false);
// // //     });

// // //     _tts.setErrorHandler((msg) {
// // //       setState(() {
// // //         _isSpeaking = false;
// // //         _statusMessage = "Speech error";
// // //       });
// // //     });
// // //   }

// // //   Future<void> _listen() async {
// // //     if (_isProcessing || _isSpeaking) {
// // //       setState(() => _statusMessage = "Please wait...");
// // //       return;
// // //     }

// // //     if (!_isListening) {
// // //       bool available = await _speech.initialize(
// // //         onStatus: (status) {
// // //           if (status == 'done' || status == 'notListening') {
// // //             if (_isListening && mounted) {
// // //               _stopListening();
// // //             }
// // //           }
// // //         },
// // //         onError: (error) {
// // //           if (mounted) {
// // //             setState(() {
// // //               _isListening = false;
// // //               _statusMessage = "Microphone error: ${error.errorMsg}";
// // //             });
// // //           }
// // //         },
// // //       );

// // //       if (available) {
// // //         setState(() {
// // //           _isListening = true;
// // //           _userWords = '';
// // //           _statusMessage = 'Listening...';
// // //         });

// // //         _speech.listen(
// // //           onResult: (result) {
// // //             if (mounted) {
// // //               setState(() {
// // //                 _userWords = result.recognizedWords;
// // //                 if (result.finalResult) {
// // //                   _stopListening();
// // //                 }
// // //               });
// // //             }
// // //           },
// // //           listenFor: const Duration(minutes: 2),
// // //           pauseFor: const Duration(seconds: 5),
// // //           partialResults: true,
// // //           cancelOnError: true,
// // //           listenMode: stt.ListenMode.confirmation,
// // //         );
// // //       } else {
// // //         setState(() => _statusMessage = "Speech recognition not available");
// // //       }
// // //     } else {
// // //       _stopListening();
// // //     }
// // //   }

// // //   Future<void> _stopListening() async {
// // //     if (_isListening) {
// // //       await _speech.stop();

// // //       if (mounted) {
// // //         setState(() => _isListening = false);

// // //         if (_userWords.trim().isNotEmpty) {
// // //           await _sendToGPT();
// // //         } else {
// // //           setState(() => _statusMessage = "No speech detected");
// // //         }
// // //       }
// // //     }
// // //   }

// // //   Future<void> _sendToGPT() async {
// // //     if (_userWords.trim().isEmpty) return;

// // //     setState(() {
// // //       _isProcessing = true;
// // //       _assistantReply = "";
// // //       _statusMessage = "Thinking...";
// // //     });

// // //     try {
// // //       final reply = await _openAI.askGPT(_userWords);

// // //       if (mounted) {
// // //         setState(() {
// // //           _assistantReply = reply;
// // //           _statusMessage = "Response ready";
// // //         });
// // //         await _speak(reply);
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         setState(() {
// // //           _assistantReply = "Error: $e";
// // //           _statusMessage = "Error occurred";
// // //         });
// // //       }
// // //     } finally {
// // //       if (mounted) {
// // //         setState(() => _isProcessing = false);
// // //       }
// // //     }
// // //   }

// // //   Future<void> _speak(String text) async {
// // //     if (text.isEmpty || text.contains("Error")) return;

// // //     setState(() {
// // //       _isSpeaking = true;
// // //       _statusMessage = "Speaking...";
// // //     });

// // //     try {
// // //       await _tts.stop();
// // //       await Future.delayed(const Duration(milliseconds: 300));
// // //       await _tts.speak(text);
// // //     } catch (e) {
// // //       if (mounted) {
// // //         setState(() {
// // //           _isSpeaking = false;
// // //           _statusMessage = "TTS error";
// // //         });
// // //       }
// // //     }
// // //   }

// // //   Future<void> _stopSpeaking() async {
// // //     await _tts.stop();
// // //     if (mounted) {
// // //       setState(() {
// // //         _isSpeaking = false;
// // //         _statusMessage = "Stopped";
// // //       });
// // //     }
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _speech.cancel();
// // //     _tts.stop();
// // //     _pulseController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFF0A0A0A),
// // //       body: SafeArea(
// // //         child: Column(
// // //           children: [
// // //             // Top Header
// // //             _buildHeader(),

// // //             // Main Content
// // //             Expanded(
// // //               child: SingleChildScrollView(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 20),
// // //                 child: Column(
// // //                   children: [
// // //                     const SizedBox(height: 20),

// // //                     // Status Indicator
// // //                     _buildStatusIndicator(),

// // //                     const SizedBox(height: 30),

// // //                     // Voice Animation Circle
// // //                     _buildVoiceCircle(),

// // //                     const SizedBox(height: 40),

// // //                     // Conversation Area
// // //                     if (_userWords.isNotEmpty) _buildUserMessage(),
// // //                     if (_assistantReply.isNotEmpty) ...[
// // //                       const SizedBox(height: 20),
// // //                       _buildAssistantMessage(),
// // //                     ],
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),

// // //             // Bottom Control Panel
// // //             _buildBottomControls(),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildHeader() {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
// // //       decoration: BoxDecoration(
// // //         color: const Color(0xFF0A0A0A),
// // //         border: Border(
// // //           bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
// // //         ),
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           Container(
// // //             width: 40,
// // //             height: 40,
// // //             decoration: BoxDecoration(
// // //               gradient: const LinearGradient(
// // //                 colors: [Color(0xFF00D9FF), Color(0xFF0066FF)],
// // //               ),
// // //               borderRadius: BorderRadius.circular(10),
// // //             ),
// // //             child: const Icon(
// // //               Icons.auto_awesome,
// // //               color: Colors.white,
// // //               size: 24,
// // //             ),
// // //           ),
// // //           const SizedBox(width: 12),
// // //           const Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Text(
// // //                 "AI Copilot",
// // //                 style: TextStyle(
// // //                   color: Colors.white,
// // //                   fontSize: 18,
// // //                   fontWeight: FontWeight.bold,
// // //                 ),
// // //               ),
// // //               Text(
// // //                 "Voice Assistant",
// // //                 style: TextStyle(color: Colors.white54, fontSize: 12),
// // //               ),
// // //             ],
// // //           ),
// // //           const Spacer(),
// // //           IconButton(
// // //             onPressed: () {
// // //               setState(() {
// // //                 _userWords = '';
// // //                 _assistantReply = '';
// // //                 _statusMessage = 'Ready to assist you';
// // //               });
// // //               _openAI.clearHistory();
// // //             },
// // //             icon: const Icon(Icons.refresh_rounded, color: Colors.white70),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildStatusIndicator() {
// // //     Color statusColor;
// // //     IconData statusIcon;

// // //     if (_isListening) {
// // //       statusColor = const Color(0xFFFF4444);
// // //       statusIcon = Icons.mic;
// // //     } else if (_isProcessing) {
// // //       statusColor = const Color(0xFFFFAA00);
// // //       statusIcon = Icons.psychology;
// // //     } else if (_isSpeaking) {
// // //       statusColor = const Color(0xFF00D9FF);
// // //       statusIcon = Icons.volume_up;
// // //     } else {
// // //       statusColor = const Color(0xFF00FF88);
// // //       statusIcon = Icons.check_circle;
// // //     }

// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// // //       decoration: BoxDecoration(
// // //         color: statusColor.withOpacity(0.1),
// // //         borderRadius: BorderRadius.circular(30),
// // //         border: Border.all(color: statusColor.withOpacity(0.3), width: 1.5),
// // //       ),
// // //       child: Row(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           Icon(statusIcon, color: statusColor, size: 20),
// // //           const SizedBox(width: 10),
// // //           Text(
// // //             _statusMessage,
// // //             style: TextStyle(
// // //               color: statusColor,
// // //               fontSize: 14,
// // //               fontWeight: FontWeight.w600,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildVoiceCircle() {
// // //     return AnimatedBuilder(
// // //       animation: _pulseAnimation,
// // //       builder: (context, child) {
// // //         return Transform.scale(
// // //           scale: _isListening ? _pulseAnimation.value : 1.0,
// // //           child: Container(
// // //             width: 200,
// // //             height: 200,
// // //             decoration: BoxDecoration(
// // //               shape: BoxShape.circle,
// // //               gradient: LinearGradient(
// // //                 begin: Alignment.topLeft,
// // //                 end: Alignment.bottomRight,
// // //                 colors: _isListening
// // //                     ? [const Color(0xFFFF4444), const Color(0xFFFF8844)]
// // //                     : _isProcessing
// // //                     ? [const Color(0xFFFFAA00), const Color(0xFFFF6600)]
// // //                     : [const Color(0xFF00D9FF), const Color(0xFF0066FF)],
// // //               ),
// // //               boxShadow: [
// // //                 BoxShadow(
// // //                   color:
// // //                       (_isListening
// // //                               ? const Color(0xFFFF4444)
// // //                               : const Color(0xFF00D9FF))
// // //                           .withOpacity(0.5),
// // //                   blurRadius: 40,
// // //                   spreadRadius: 5,
// // //                 ),
// // //               ],
// // //             ),
// // //             child: Icon(
// // //               _isListening
// // //                   ? Icons.mic
// // //                   : _isProcessing
// // //                   ? Icons.auto_awesome
// // //                   : Icons.record_voice_over,
// // //               size: 80,
// // //               color: Colors.white,
// // //             ),
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   Widget _buildUserMessage() {
// // //     return Align(
// // //       alignment: Alignment.centerRight,
// // //       child: Container(
// // //         constraints: BoxConstraints(
// // //           maxWidth: MediaQuery.of(context).size.width * 0.8,
// // //         ),
// // //         padding: const EdgeInsets.all(16),
// // //         decoration: BoxDecoration(
// // //           gradient: const LinearGradient(
// // //             colors: [Color(0xFF0066FF), Color(0xFF00D9FF)],
// // //           ),
// // //           borderRadius: BorderRadius.circular(20),
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color: const Color(0xFF0066FF).withOpacity(0.3),
// // //               blurRadius: 15,
// // //               offset: const Offset(0, 5),
// // //             ),
// // //           ],
// // //         ),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Row(
// // //               mainAxisSize: MainAxisSize.min,
// // //               children: [
// // //                 Container(
// // //                   width: 24,
// // //                   height: 24,
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white.withOpacity(0.2),
// // //                     shape: BoxShape.circle,
// // //                   ),
// // //                   child: const Icon(
// // //                     Icons.person,
// // //                     size: 14,
// // //                     color: Colors.white,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(width: 8),
// // //                 const Text(
// // //                   "You",
// // //                   style: TextStyle(
// // //                     color: Colors.white70,
// // //                     fontSize: 12,
// // //                     fontWeight: FontWeight.w600,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 8),
// // //             Text(
// // //               _userWords,
// // //               style: const TextStyle(
// // //                 color: Colors.white,
// // //                 fontSize: 15,
// // //                 height: 1.4,
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildAssistantMessage() {
// // //     return Align(
// // //       alignment: Alignment.centerLeft,
// // //       child: Container(
// // //         constraints: BoxConstraints(
// // //           maxWidth: MediaQuery.of(context).size.width * 0.85,
// // //         ),
// // //         padding: const EdgeInsets.all(16),
// // //         decoration: BoxDecoration(
// // //           color: const Color(0xFF1A1A1A),
// // //           borderRadius: BorderRadius.circular(20),
// // //           border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
// // //         ),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Row(
// // //               mainAxisSize: MainAxisSize.min,
// // //               children: [
// // //                 Container(
// // //                   width: 24,
// // //                   height: 24,
// // //                   decoration: BoxDecoration(
// // //                     gradient: const LinearGradient(
// // //                       colors: [Color(0xFF00D9FF), Color(0xFF0066FF)],
// // //                     ),
// // //                     shape: BoxShape.circle,
// // //                   ),
// // //                   child: const Icon(
// // //                     Icons.auto_awesome,
// // //                     size: 14,
// // //                     color: Colors.white,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(width: 8),
// // //                 const Text(
// // //                   "AI Copilot",
// // //                   style: TextStyle(
// // //                     color: Colors.white70,
// // //                     fontSize: 12,
// // //                     fontWeight: FontWeight.w600,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 8),
// // //             Text(
// // //               _assistantReply,
// // //               style: const TextStyle(
// // //                 color: Colors.white,
// // //                 fontSize: 15,
// // //                 height: 1.5,
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildBottomControls() {
// // //     return Container(
// // //       padding: const EdgeInsets.all(20),
// // //       decoration: BoxDecoration(
// // //         color: const Color(0xFF0A0A0A),
// // //         border: Border(
// // //           top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
// // //         ),
// // //       ),
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           if (_isSpeaking)
// // //             _buildControlButton(
// // //               icon: Icons.stop_rounded,
// // //               color: const Color(0xFFFF6600),
// // //               onPressed: _stopSpeaking,
// // //             ),
// // //           if (_isSpeaking) const SizedBox(width: 16),
// // //           _buildMainButton(),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildControlButton({
// // //     required IconData icon,
// // //     required Color color,
// // //     required VoidCallback onPressed,
// // //   }) {
// // //     return Container(
// // //       width: 60,
// // //       height: 60,
// // //       decoration: BoxDecoration(
// // //         color: color.withOpacity(0.2),
// // //         shape: BoxShape.circle,
// // //         border: Border.all(color: color, width: 2),
// // //       ),
// // //       child: IconButton(
// // //         onPressed: onPressed,
// // //         icon: Icon(icon, color: color, size: 28),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildMainButton() {
// // //     return GestureDetector(
// // //       onTap: (_isProcessing || _isSpeaking) ? null : _listen,
// // //       child: Container(
// // //         width: 80,
// // //         height: 80,
// // //         decoration: BoxDecoration(
// // //           shape: BoxShape.circle,
// // //           gradient: LinearGradient(
// // //             begin: Alignment.topLeft,
// // //             end: Alignment.bottomRight,
// // //             colors: _isListening
// // //                 ? [const Color(0xFFFF4444), const Color(0xFFFF8844)]
// // //                 : (_isProcessing || _isSpeaking)
// // //                 ? [const Color(0xFF444444), const Color(0xFF666666)]
// // //                 : [const Color(0xFF00D9FF), const Color(0xFF0066FF)],
// // //           ),
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color:
// // //                   (_isListening
// // //                           ? const Color(0xFFFF4444)
// // //                           : const Color(0xFF00D9FF))
// // //                       .withOpacity(0.4),
// // //               blurRadius: 20,
// // //               spreadRadius: 2,
// // //             ),
// // //           ],
// // //         ),
// // //         child: Icon(
// // //           _isListening ? Icons.mic : Icons.mic_none_rounded,
// // //           size: 40,
// // //           color: Colors.white,
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;
// // import 'package:flutter_tts/flutter_tts.dart';
// // import 'package:flutter_dotenv/flutter_dotenv.dart';
// // import 'openai_service.dart';

// // class VoiceAssistant extends StatefulWidget {
// //   const VoiceAssistant({super.key});

// //   @override
// //   State<VoiceAssistant> createState() => _VoiceAssistantState();
// // }

// // class _VoiceAssistantState extends State<VoiceAssistant>
// //     with SingleTickerProviderStateMixin {
// //   late stt.SpeechToText _speech;
// //   late FlutterTts _tts;
// //   late OpenAIService _openAI;
// //   late AnimationController _pulseController;
// //   late Animation<double> _pulseAnimation;

// //   bool _isListening = false;
// //   bool _isProcessing = false;
// //   bool _isSpeaking = false;
// //   String _userWords = '';
// //   String _assistantReply = '';
// //   String _statusMessage = 'Ready to assist you';

// //   final TextEditingController _textController = TextEditingController();
// //   final ScrollController _scrollController = ScrollController();
// //   int _selectedNavIndex = 2; // AI Chat tab selected

// //   // Chat messages list: each item is {role: 'user'|'assistant', text: '...'}
// //   final List<Map<String, String>> _messages = [];

// //   final List<Map<String, String>> _suggestedQuestions = [
// //     {'text': "What's the healthcare budget?"},
// //     {'text': 'Compare states spending'},
// //     {'text': 'Where does my tax go?'},
// //     {'text': 'Education budget trends'},
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _speech = stt.SpeechToText();
// //     _tts = FlutterTts();

// //     _pulseController = AnimationController(
// //       duration: const Duration(milliseconds: 1500),
// //       vsync: this,
// //     )..repeat(reverse: true);

// //     _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
// //       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
// //     );

// //     final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
// //     if (apiKey.isEmpty) {
// //       _statusMessage = 'Please add GEMINI_API_KEY to .env file';
// //     }

// //     _openAI = OpenAIService(apiKey: apiKey);
// //     _initializeTTS();
// //   }

// //   Future<void> _initializeTTS() async {
// //     await _tts.setLanguage("en-US");
// //     await _tts.setSpeechRate(0.5);
// //     await _tts.setPitch(1.0);
// //     await _tts.setVolume(1.0);

// //     _tts.setCompletionHandler(() {
// //       setState(() => _isSpeaking = false);
// //     });

// //     _tts.setErrorHandler((msg) {
// //       setState(() {
// //         _isSpeaking = false;
// //         _statusMessage = "Speech error";
// //       });
// //     });
// //   }

// //   Future<void> _listen() async {
// //     if (_isProcessing || _isSpeaking) {
// //       setState(() => _statusMessage = "Please wait...");
// //       return;
// //     }

// //     if (!_isListening) {
// //       bool available = await _speech.initialize(
// //         onStatus: (status) {
// //           if (status == 'done' || status == 'notListening') {
// //             if (_isListening && mounted) {
// //               _stopListening();
// //             }
// //           }
// //         },
// //         onError: (error) {
// //           if (mounted) {
// //             setState(() {
// //               _isListening = false;
// //               _statusMessage = "Microphone error: ${error.errorMsg}";
// //             });
// //           }
// //         },
// //       );

// //       if (available) {
// //         setState(() {
// //           _isListening = true;
// //           _userWords = '';
// //           _statusMessage = 'Listening...';
// //         });

// //         _speech.listen(
// //           onResult: (result) {
// //             if (mounted) {
// //               setState(() {
// //                 _userWords = result.recognizedWords;
// //                 _textController.text = result.recognizedWords;
// //                 if (result.finalResult) {
// //                   _stopListening();
// //                 }
// //               });
// //             }
// //           },
// //           listenFor: const Duration(minutes: 2),
// //           pauseFor: const Duration(seconds: 5),
// //           partialResults: true,
// //           cancelOnError: true,
// //           listenMode: stt.ListenMode.confirmation,
// //         );
// //       } else {
// //         setState(() => _statusMessage = "Speech recognition not available");
// //       }
// //     } else {
// //       _stopListening();
// //     }
// //   }

// //   Future<void> _stopListening() async {
// //     if (_isListening) {
// //       await _speech.stop();

// //       if (mounted) {
// //         setState(() => _isListening = false);

// //         if (_userWords.trim().isNotEmpty) {
// //           await _sendToGPT();
// //         } else {
// //           setState(() => _statusMessage = "No speech detected");
// //         }
// //       }
// //     }
// //   }

// //   Future<void> _sendToGPT() async {
// //     if (_userWords.trim().isEmpty) return;

// //     final question = _userWords.trim();
// //     setState(() {
// //       _isProcessing = true;
// //       _assistantReply = "";
// //       _statusMessage = "Thinking...";
// //       _messages.add({'role': 'user', 'text': question});
// //       _userWords = '';
// //       _textController.clear();
// //     });

// //     _scrollToBottom();

// //     try {
// //       final reply = await _openAI.askGPT(question);

// //       if (mounted) {
// //         setState(() {
// //           _assistantReply = reply;
// //           _statusMessage = "Response ready";
// //           _messages.add({'role': 'assistant', 'text': reply});
// //         });
// //         _scrollToBottom();
// //         await _speak(reply);
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         setState(() {
// //           _assistantReply = "Error: $e";
// //           _statusMessage = "Error occurred";
// //           _messages.add({'role': 'assistant', 'text': "Error: $e"});
// //         });
// //       }
// //     } finally {
// //       if (mounted) {
// //         setState(() => _isProcessing = false);
// //       }
// //     }
// //   }

// //   void _sendTextMessage() {
// //     final text = _textController.text.trim();
// //     if (text.isEmpty) return;
// //     setState(() {
// //       _userWords = text;
// //     });
// //     _sendToGPT();
// //   }

// //   void _askSuggestedQuestion(String question) {
// //     setState(() {
// //       _userWords = question;
// //       _textController.text = question;
// //     });
// //     _sendToGPT();
// //   }

// //   void _scrollToBottom() {
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       if (_scrollController.hasClients) {
// //         _scrollController.animateTo(
// //           _scrollController.position.maxScrollExtent,
// //           duration: const Duration(milliseconds: 300),
// //           curve: Curves.easeOut,
// //         );
// //       }
// //     });
// //   }

// //   Future<void> _speak(String text) async {
// //     if (text.isEmpty || text.contains("Error")) return;

// //     setState(() {
// //       _isSpeaking = true;
// //       _statusMessage = "Speaking...";
// //     });

// //     try {
// //       await _tts.stop();
// //       await Future.delayed(const Duration(milliseconds: 300));
// //       await _tts.speak(text);
// //     } catch (e) {
// //       if (mounted) {
// //         setState(() {
// //           _isSpeaking = false;
// //           _statusMessage = "TTS error";
// //         });
// //       }
// //     }
// //   }

// //   Future<void> _stopSpeaking() async {
// //     await _tts.stop();
// //     if (mounted) {
// //       setState(() {
// //         _isSpeaking = false;
// //         _statusMessage = "Stopped";
// //       });
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _speech.cancel();
// //     _tts.stop();
// //     _pulseController.dispose();
// //     _textController.dispose();
// //     _scrollController.dispose();
// //     super.dispose();
// //   }

// //   // ─── COLOR CONSTANTS ───────────────────────────────────────────────
// //   static const Color _teal = Color(0xFF00BFA5);
// //   static const Color _tealLight = Color(0xFFE0F7FA);
// //   static const Color _bgColor = Color(0xFFF0F4F5);
// //   static const Color _white = Colors.white;
// //   static const Color _textDark = Color(0xFF1A1A2E);
// //   static const Color _textMuted = Color(0xFF7A8B9A);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: _bgColor,
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             _buildHeader(),
// //             Expanded(
// //               child: _messages.isEmpty ? _buildEmptyState() : _buildChatList(),
// //             ),
// //             _buildBottomInputBar(),
// //             _buildBottomNavBar(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildHeader() {
// //     return Container(
// //       color: _bgColor,
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //       child: Row(
// //         children: [
// //           GestureDetector(
// //             onTap: () {},
// //             child: const Icon(Icons.arrow_back, color: _teal, size: 24),
// //           ),
// //           const SizedBox(width: 12),
// //           const Text(
// //             'AI Assistant',
// //             style: TextStyle(
// //               fontSize: 20,
// //               fontWeight: FontWeight.w700,
// //               color: _textDark,
// //             ),
// //           ),
// //           const Spacer(),
// //           IconButton(
// //             onPressed: () {
// //               setState(() {
// //                 _messages.clear();
// //                 _userWords = '';
// //                 _assistantReply = '';
// //                 _statusMessage = 'Ready to assist you';
// //                 _textController.clear();
// //               });
// //               _openAI.clearHistory();
// //             },
// //             icon: const Icon(Icons.refresh_rounded, color: _textMuted),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildEmptyState() {
// //     return SingleChildScrollView(
// //       padding: const EdgeInsets.symmetric(horizontal: 16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const SizedBox(height: 12),
// //           const Text(
// //             'Suggested questions:',
// //             style: TextStyle(
// //               fontSize: 13,
// //               color: _textMuted,
// //               fontWeight: FontWeight.w500,
// //             ),
// //           ),
// //           const SizedBox(height: 12),
// //           _buildSuggestedGrid(),
// //           const SizedBox(height: 16),
// //           _buildWelcomeBubble(),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSuggestedGrid() {
// //     return GridView.count(
// //       crossAxisCount: 2,
// //       shrinkWrap: true,
// //       physics: const NeverScrollableScrollPhysics(),
// //       crossAxisSpacing: 10,
// //       mainAxisSpacing: 10,
// //       childAspectRatio: 3.2,
// //       children: _suggestedQuestions.map((q) {
// //         return GestureDetector(
// //           onTap: () => _askSuggestedQuestion(q['text']!),
// //           child: Container(
// //             decoration: BoxDecoration(
// //               color: _white,
// //               borderRadius: BorderRadius.circular(30),
// //               border: Border.all(color: _teal.withOpacity(0.4), width: 1.2),
// //             ),
// //             alignment: Alignment.centerLeft,
// //             padding: const EdgeInsets.symmetric(horizontal: 14),
// //             child: Text(
// //               q['text']!,
// //               style: const TextStyle(
// //                 fontSize: 12.5,
// //                 color: _textDark,
// //                 fontWeight: FontWeight.w500,
// //               ),
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //           ),
// //         );
// //       }).toList(),
// //     );
// //   }

// //   Widget _buildWelcomeBubble() {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //       decoration: BoxDecoration(
// //         color: _white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.04),
// //             blurRadius: 8,
// //             offset: const Offset(0, 2),
// //           ),
// //         ],
// //       ),
// //       child: const Text(
// //         "Hello! I'm your budget assistant. Ask me anything about government spending!",
// //         style: TextStyle(fontSize: 14, color: _textDark, height: 1.4),
// //       ),
// //     );
// //   }

// //   Widget _buildChatList() {
// //     return ListView.builder(
// //       controller: _scrollController,
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //       itemCount: _messages.length + (_isProcessing ? 1 : 0),
// //       itemBuilder: (context, index) {
// //         if (index == _messages.length && _isProcessing) {
// //           return _buildTypingIndicator();
// //         }
// //         final msg = _messages[index];
// //         final isUser = msg['role'] == 'user';
// //         return Padding(
// //           padding: const EdgeInsets.only(bottom: 12),
// //           child: isUser
// //               ? _buildUserBubble(msg['text']!)
// //               : _buildAssistantBubble(msg['text']!),
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildUserBubble(String text) {
// //     return Align(
// //       alignment: Alignment.centerRight,
// //       child: Container(
// //         constraints: BoxConstraints(
// //           maxWidth: MediaQuery.of(context).size.width * 0.75,
// //         ),
// //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //         decoration: BoxDecoration(
// //           gradient: const LinearGradient(
// //             colors: [Color(0xFF00BFA5), Color(0xFF0097A7)],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //           borderRadius: const BorderRadius.only(
// //             topLeft: Radius.circular(18),
// //             topRight: Radius.circular(18),
// //             bottomLeft: Radius.circular(18),
// //             bottomRight: Radius.circular(4),
// //           ),
// //           boxShadow: [
// //             BoxShadow(
// //               color: _teal.withOpacity(0.25),
// //               blurRadius: 8,
// //               offset: const Offset(0, 3),
// //             ),
// //           ],
// //         ),
// //         child: Text(
// //           text,
// //           style: const TextStyle(
// //             color: Colors.white,
// //             fontSize: 14,
// //             height: 1.4,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildAssistantBubble(String text) {
// //     return Align(
// //       alignment: Alignment.centerLeft,
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Container(
// //             width: 32,
// //             height: 32,
// //             decoration: BoxDecoration(
// //               color: _tealLight,
// //               shape: BoxShape.circle,
// //             ),
// //             child: const Icon(Icons.auto_awesome, size: 16, color: _teal),
// //           ),
// //           const SizedBox(width: 8),
// //           Flexible(
// //             child: Container(
// //               constraints: BoxConstraints(
// //                 maxWidth: MediaQuery.of(context).size.width * 0.75,
// //               ),
// //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //               decoration: BoxDecoration(
// //                 color: _white,
// //                 borderRadius: const BorderRadius.only(
// //                   topLeft: Radius.circular(4),
// //                   topRight: Radius.circular(18),
// //                   bottomLeft: Radius.circular(18),
// //                   bottomRight: Radius.circular(18),
// //                 ),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.05),
// //                     blurRadius: 6,
// //                     offset: const Offset(0, 2),
// //                   ),
// //                 ],
// //               ),
// //               child: Text(
// //                 text,
// //                 style: const TextStyle(
// //                   color: _textDark,
// //                   fontSize: 14,
// //                   height: 1.5,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildTypingIndicator() {
// //     return Align(
// //       alignment: Alignment.centerLeft,
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Container(
// //             width: 32,
// //             height: 32,
// //             decoration: BoxDecoration(
// //               color: _tealLight,
// //               shape: BoxShape.circle,
// //             ),
// //             child: const Icon(Icons.auto_awesome, size: 16, color: _teal),
// //           ),
// //           const SizedBox(width: 8),
// //           Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //             decoration: BoxDecoration(
// //               color: _white,
// //               borderRadius: BorderRadius.circular(18),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black.withOpacity(0.05),
// //                   blurRadius: 6,
// //                   offset: const Offset(0, 2),
// //                 ),
// //               ],
// //             ),
// //             child: Row(
// //               mainAxisSize: MainAxisSize.min,
// //               children: List.generate(3, (i) {
// //                 return AnimatedBuilder(
// //                   animation: _pulseController,
// //                   builder: (context, child) {
// //                     return Container(
// //                       margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
// //                       width: 8,
// //                       height: 8,
// //                       decoration: BoxDecoration(
// //                         color: _teal.withOpacity(
// //                           0.3 +
// //                               0.7 *
// //                                   (((_pulseController.value + i * 0.3) % 1.0)),
// //                         ),
// //                         shape: BoxShape.circle,
// //                       ),
// //                     );
// //                   },
// //                 );
// //               }),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildBottomInputBar() {
// //     return Container(
// //       margin: const EdgeInsets.fromLTRB(12, 6, 12, 8),
// //       decoration: BoxDecoration(
// //         color: _white,
// //         borderRadius: BorderRadius.circular(30),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.08),
// //             blurRadius: 12,
// //             offset: const Offset(0, 2),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           const SizedBox(width: 16),
// //           Expanded(
// //             child: TextField(
// //               controller: _textController,
// //               onSubmitted: (_) => _sendTextMessage(),
// //               style: const TextStyle(fontSize: 14, color: _textDark),
// //               decoration: const InputDecoration(
// //                 hintText: 'Ask about budget allocation...',
// //                 hintStyle: TextStyle(color: _textMuted, fontSize: 14),
// //                 border: InputBorder.none,
// //                 isDense: true,
// //                 contentPadding: EdgeInsets.symmetric(vertical: 14),
// //               ),
// //             ),
// //           ),
// //           // Mic button
// //           GestureDetector(
// //             onTap: (_isProcessing || _isSpeaking) ? null : _listen,
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 8),
// //               child: AnimatedBuilder(
// //                 animation: _pulseAnimation,
// //                 builder: (context, child) {
// //                   return Transform.scale(
// //                     scale: _isListening ? _pulseAnimation.value : 1.0,
// //                     child: Icon(
// //                       _isListening ? Icons.mic : Icons.mic_none_rounded,
// //                       color: _isListening ? Colors.redAccent : _textMuted,
// //                       size: 22,
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ),
// //           // Send button
// //           GestureDetector(
// //             onTap: _sendTextMessage,
// //             child: Container(
// //               margin: const EdgeInsets.only(right: 6),
// //               width: 36,
// //               height: 36,
// //               decoration: BoxDecoration(
// //                 color: _teal.withOpacity(0.12),
// //                 shape: BoxShape.circle,
// //               ),
// //               child: const Icon(Icons.send_rounded, color: _teal, size: 18),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildBottomNavBar() {
// //     final items = [
// //       {'icon': Icons.home_outlined, 'label': 'Home'},
// //       {'icon': Icons.map_outlined, 'label': 'Regions'},
// //       {'icon': Icons.compare_arrows_rounded, 'label': 'Compare'},
// //       {'icon': Icons.chat_bubble_outline_rounded, 'label': 'AI Chat'},
// //       {'icon': Icons.person_outline_rounded, 'label': 'Profile'},
// //     ];

// //     return Container(
// //       decoration: BoxDecoration(
// //         color: _white,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.06),
// //             blurRadius: 10,
// //             offset: const Offset(0, -2),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: List.generate(items.length, (i) {
// //           final isSelected = i == _selectedNavIndex;
// //           return Expanded(
// //             child: GestureDetector(
// //               onTap: () => setState(() => _selectedNavIndex = i),
// //               behavior: HitTestBehavior.opaque,
// //               child: Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 10),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Icon(
// //                       items[i]['icon'] as IconData,
// //                       color: isSelected ? _teal : _textMuted,
// //                       size: 22,
// //                     ),
// //                     const SizedBox(height: 3),
// //                     Text(
// //                       items[i]['label'] as String,
// //                       style: TextStyle(
// //                         fontSize: 10,
// //                         color: isSelected ? _teal : _textMuted,
// //                         fontWeight: isSelected
// //                             ? FontWeight.w600
// //                             : FontWeight.normal,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         }),
// //       ),
// //     );
// //   }
// // }

// import 'package:budegt_iq/view/home_screen.dart'; // 🔥 ADDED IMPORT
// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'openai_service.dart';

// class VoiceAssistant extends StatefulWidget {
//   const VoiceAssistant({super.key});

//   @override
//   State<VoiceAssistant> createState() => _VoiceAssistantState();
// }

// class _VoiceAssistantState extends State<VoiceAssistant>
//     with SingleTickerProviderStateMixin {
//   late stt.SpeechToText _speech;
//   late FlutterTts _tts;
//   late OpenAIService _openAI;
//   late AnimationController _pulseController;
//   late Animation<double> _pulseAnimation;

//   bool _isListening = false;
//   bool _isProcessing = false;
//   bool _isSpeaking = false;
//   String _userWords = '';
//   String _assistantReply = '';
//   String _statusMessage = 'Ready to assist you';

//   final TextEditingController _textController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   int _selectedNavIndex = 3; // AI Chat tab selected

//   // Chat messages list: each item is {role: 'user'|'assistant', text: '...'}
//   final List<Map<String, String>> _messages = [];

//   final List<Map<String, String>> _suggestedQuestions = [
//     {'text': "What's the healthcare budget?"},
//     {'text': 'Compare states spending'},
//     {'text': 'Where does my tax go?'},
//     {'text': 'Education budget trends'},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//     _tts = FlutterTts();

//     _pulseController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     )..repeat(reverse: true);

//     _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
//       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
//     );

//     final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
//     if (apiKey.isEmpty) {
//       _statusMessage = 'Please add GEMINI_API_KEY to .env file';
//     }

//     _openAI = OpenAIService(apiKey: apiKey);
//     _initializeTTS();
//   }

//   Future<void> _initializeTTS() async {
//     await _tts.setLanguage("en-US");
//     await _tts.setSpeechRate(0.5);
//     await _tts.setPitch(1.0);
//     await _tts.setVolume(1.0);

//     _tts.setCompletionHandler(() {
//       setState(() => _isSpeaking = false);
//     });

//     _tts.setErrorHandler((msg) {
//       setState(() {
//         _isSpeaking = false;
//         _statusMessage = "Speech error";
//       });
//     });
//   }

//   Future<void> _listen() async {
//     if (_isProcessing || _isSpeaking) {
//       setState(() => _statusMessage = "Please wait...");
//       return;
//     }

//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (status) {
//           if (status == 'done' || status == 'notListening') {
//             if (_isListening && mounted) {
//               _stopListening();
//             }
//           }
//         },
//         onError: (error) {
//           if (mounted) {
//             setState(() {
//               _isListening = false;
//               _statusMessage = "Microphone error: ${error.errorMsg}";
//             });
//           }
//         },
//       );

//       if (available) {
//         setState(() {
//           _isListening = true;
//           _userWords = '';
//           _statusMessage = 'Listening...';
//         });

//         _speech.listen(
//           onResult: (result) {
//             if (mounted) {
//               setState(() {
//                 _userWords = result.recognizedWords;
//                 _textController.text = result.recognizedWords;
//                 if (result.finalResult) {
//                   _stopListening();
//                 }
//               });
//             }
//           },
//           listenFor: const Duration(minutes: 2),
//           pauseFor: const Duration(seconds: 5),
//           partialResults: true,
//           cancelOnError: true,
//           listenMode: stt.ListenMode.confirmation,
//         );
//       } else {
//         setState(() => _statusMessage = "Speech recognition not available");
//       }
//     } else {
//       _stopListening();
//     }
//   }

//   Future<void> _stopListening() async {
//     if (_isListening) {
//       await _speech.stop();

//       if (mounted) {
//         setState(() => _isListening = false);

//         if (_userWords.trim().isNotEmpty) {
//           await _sendToGPT();
//         } else {
//           setState(() => _statusMessage = "No speech detected");
//         }
//       }
//     }
//   }

//   Future<void> _sendToGPT() async {
//     if (_userWords.trim().isEmpty) return;

//     final question = _userWords.trim();
//     setState(() {
//       _isProcessing = true;
//       _assistantReply = "";
//       _statusMessage = "Thinking...";
//       _messages.add({'role': 'user', 'text': question});
//       _userWords = '';
//       _textController.clear();
//     });

//     _scrollToBottom();

//     try {
//       final reply = await _openAI.askGPT(question);

//       if (mounted) {
//         setState(() {
//           _assistantReply = reply;
//           _statusMessage = "Response ready";
//           _messages.add({'role': 'assistant', 'text': reply});
//         });
//         _scrollToBottom();
//         await _speak(reply);
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _assistantReply = "Error: $e";
//           _statusMessage = "Error occurred";
//           _messages.add({'role': 'assistant', 'text': "Error: $e"});
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isProcessing = false);
//       }
//     }
//   }

//   void _sendTextMessage() {
//     final text = _textController.text.trim();
//     if (text.isEmpty) return;
//     setState(() {
//       _userWords = text;
//     });
//     _sendToGPT();
//   }

//   void _askSuggestedQuestion(String question) {
//     setState(() {
//       _userWords = question;
//       _textController.text = question;
//     });
//     _sendToGPT();
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   Future<void> _speak(String text) async {
//     if (text.isEmpty || text.contains("Error")) return;

//     setState(() {
//       _isSpeaking = true;
//       _statusMessage = "Speaking...";
//     });

//     try {
//       await _tts.stop();
//       await Future.delayed(const Duration(milliseconds: 300));
//       await _tts.speak(text);
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _isSpeaking = false;
//           _statusMessage = "TTS error";
//         });
//       }
//     }
//   }

//   Future<void> _stopSpeaking() async {
//     await _tts.stop();
//     if (mounted) {
//       setState(() {
//         _isSpeaking = false;
//         _statusMessage = "Stopped";
//       });
//     }
//   }

//   // 🔥 HANDLE SYSTEM BACK BUTTON — navigates back to CitizenHomeScreen
//   Future<bool> _onWillPop() async {
//     await _speech.cancel();
//     await _tts.stop();
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const CitizenHomeScreen()),
//       (route) => false,
//     );
//     return false;
//   }

//   @override
//   void dispose() {
//     _speech.cancel();
//     _tts.stop();
//     _pulseController.dispose();
//     _textController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   // ─── COLOR CONSTANTS ───────────────────────────────────────────────
//   static const Color _teal = Color(0xFF00BFA5);
//   static const Color _tealLight = Color(0xFFE0F7FA);
//   static const Color _bgColor = Color(0xFFF0F4F5);
//   static const Color _white = Colors.white;
//   static const Color _textDark = Color(0xFF1A1A2E);
//   static const Color _textMuted = Color(0xFF7A8B9A);

//   @override
//   Widget build(BuildContext context) {
//     // 🔥 WRAPPED WITH WillPopScope TO INTERCEPT SYSTEM BACK BUTTON
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         backgroundColor: _bgColor,
//         body: SafeArea(
//           child: Column(
//             children: [
//               _buildHeader(),
//               Expanded(
//                 child: _messages.isEmpty
//                     ? _buildEmptyState()
//                     : _buildChatList(),
//               ),
//               _buildBottomInputBar(),
//               _buildBottomNavBar(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       color: _bgColor,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       child: Row(
//         children: [
//           GestureDetector(
//             // 🔥 BACK ARROW ALSO NAVIGATES TO CitizenHomeScreen
//             onTap: _onWillPop,
//             child: const Icon(Icons.arrow_back, color: _teal, size: 24),
//           ),
//           const SizedBox(width: 12),
//           const Text(
//             'AI Assistant',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: _textDark,
//             ),
//           ),
//           const Spacer(),
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 _messages.clear();
//                 _userWords = '';
//                 _assistantReply = '';
//                 _statusMessage = 'Ready to assist you';
//                 _textController.clear();
//               });
//               _openAI.clearHistory();
//             },
//             icon: const Icon(Icons.refresh_rounded, color: _textMuted),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 12),
//           const Text(
//             'Suggested questions:',
//             style: TextStyle(
//               fontSize: 13,
//               color: _textMuted,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 12),
//           _buildSuggestedGrid(),
//           const SizedBox(height: 16),
//           _buildWelcomeBubble(),
//         ],
//       ),
//     );
//   }

//   Widget _buildSuggestedGrid() {
//     return GridView.count(
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       childAspectRatio: 3.2,
//       children: _suggestedQuestions.map((q) {
//         return GestureDetector(
//           onTap: () => _askSuggestedQuestion(q['text']!),
//           child: Container(
//             decoration: BoxDecoration(
//               color: _white,
//               borderRadius: BorderRadius.circular(30),
//               border: Border.all(color: _teal.withOpacity(0.4), width: 1.2),
//             ),
//             alignment: Alignment.centerLeft,
//             padding: const EdgeInsets.symmetric(horizontal: 14),
//             child: Text(
//               q['text']!,
//               style: const TextStyle(
//                 fontSize: 12.5,
//                 color: _textDark,
//                 fontWeight: FontWeight.w500,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildWelcomeBubble() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: _white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: const Text(
//         "Hello! I'm your budget assistant. Ask me anything about government spending!",
//         style: TextStyle(fontSize: 14, color: _textDark, height: 1.4),
//       ),
//     );
//   }

//   Widget _buildChatList() {
//     return ListView.builder(
//       controller: _scrollController,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       itemCount: _messages.length + (_isProcessing ? 1 : 0),
//       itemBuilder: (context, index) {
//         if (index == _messages.length && _isProcessing) {
//           return _buildTypingIndicator();
//         }
//         final msg = _messages[index];
//         final isUser = msg['role'] == 'user';
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 12),
//           child: isUser
//               ? _buildUserBubble(msg['text']!)
//               : _buildAssistantBubble(msg['text']!),
//         );
//       },
//     );
//   }

//   Widget _buildUserBubble(String text) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.75,
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF00BFA5), Color(0xFF0097A7)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(18),
//             topRight: Radius.circular(18),
//             bottomLeft: Radius.circular(18),
//             bottomRight: Radius.circular(4),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: _teal.withOpacity(0.25),
//               blurRadius: 8,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//             height: 1.4,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAssistantBubble(String text) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 32,
//             height: 32,
//             decoration: BoxDecoration(
//               color: _tealLight,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.auto_awesome, size: 16, color: _teal),
//           ),
//           const SizedBox(width: 8),
//           Flexible(
//             child: Container(
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width * 0.75,
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: _white,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(4),
//                   topRight: Radius.circular(18),
//                   bottomLeft: Radius.circular(18),
//                   bottomRight: Radius.circular(18),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 6,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Text(
//                 text,
//                 style: const TextStyle(
//                   color: _textDark,
//                   fontSize: 14,
//                   height: 1.5,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTypingIndicator() {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 32,
//             height: 32,
//             decoration: BoxDecoration(
//               color: _tealLight,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.auto_awesome, size: 16, color: _teal),
//           ),
//           const SizedBox(width: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             decoration: BoxDecoration(
//               color: _white,
//               borderRadius: BorderRadius.circular(18),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 6,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: List.generate(3, (i) {
//                 return AnimatedBuilder(
//                   animation: _pulseController,
//                   builder: (context, child) {
//                     return Container(
//                       margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
//                       width: 8,
//                       height: 8,
//                       decoration: BoxDecoration(
//                         color: _teal.withOpacity(
//                           0.3 +
//                               0.7 *
//                                   (((_pulseController.value + i * 0.3) % 1.0)),
//                         ),
//                         shape: BoxShape.circle,
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomInputBar() {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(12, 6, 12, 8),
//       decoration: BoxDecoration(
//         color: _white,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           const SizedBox(width: 16),
//           Expanded(
//             child: TextField(
//               controller: _textController,
//               onSubmitted: (_) => _sendTextMessage(),
//               style: const TextStyle(fontSize: 14, color: _textDark),
//               decoration: const InputDecoration(
//                 hintText: 'Ask about budget allocation...',
//                 hintStyle: TextStyle(color: _textMuted, fontSize: 14),
//                 border: InputBorder.none,
//                 isDense: true,
//                 contentPadding: EdgeInsets.symmetric(vertical: 14),
//               ),
//             ),
//           ),
//           // Mic button
//           GestureDetector(
//             onTap: (_isProcessing || _isSpeaking) ? null : _listen,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: AnimatedBuilder(
//                 animation: _pulseAnimation,
//                 builder: (context, child) {
//                   return Transform.scale(
//                     scale: _isListening ? _pulseAnimation.value : 1.0,
//                     child: Icon(
//                       _isListening ? Icons.mic : Icons.mic_none_rounded,
//                       color: _isListening ? Colors.redAccent : _textMuted,
//                       size: 22,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           // Send button
//           GestureDetector(
//             onTap: _sendTextMessage,
//             child: Container(
//               margin: const EdgeInsets.only(right: 6),
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                 color: _teal.withOpacity(0.12),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.send_rounded, color: _teal, size: 18),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomNavBar() {
//     final items = [
//       {'icon': Icons.home_outlined, 'label': 'Home'},
//       {'icon': Icons.map_outlined, 'label': 'Regions'},
//       {'icon': Icons.compare_arrows_rounded, 'label': 'Compare'},
//       {'icon': Icons.chat_bubble_outline_rounded, 'label': 'AI Chat'},
//       {'icon': Icons.person_outline_rounded, 'label': 'Profile'},
//     ];

//     return Container(
//       decoration: BoxDecoration(
//         color: _white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: List.generate(items.length, (i) {
//           final isSelected = i == _selectedNavIndex;
//           return Expanded(
//             child: GestureDetector(
//               onTap: () => setState(() => _selectedNavIndex = i),
//               behavior: HitTestBehavior.opaque,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       items[i]['icon'] as IconData,
//                       color: isSelected ? _teal : _textMuted,
//                       size: 22,
//                     ),
//                     const SizedBox(height: 3),
//                     Text(
//                       items[i]['label'] as String,
//                       style: TextStyle(
//                         fontSize: 10,
//                         color: isSelected ? _teal : _textMuted,
//                         fontWeight: isSelected
//                             ? FontWeight.w600
//                             : FontWeight.normal,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'openai_service.dart';

class VoiceAssistant extends StatefulWidget {
  /// Optional apiKey — if not passed, reads from .env
  final String? apiKey;

  const VoiceAssistant({super.key, this.apiKey});

  @override
  State<VoiceAssistant> createState() => _VoiceAssistantState();
}

class _VoiceAssistantState extends State<VoiceAssistant>
    with SingleTickerProviderStateMixin {
  late stt.SpeechToText _speech;
  late FlutterTts _tts;
  late OpenAIService _openAI;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  bool _isListening = false;
  bool _isProcessing = false;
  bool _isSpeaking = false;
  String _userWords = '';
  String _assistantReply = '';
  String _statusMessage = 'Ready to assist you';

  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _selectedNavIndex = 2;

  final List<Map<String, String>> _messages = [];

  final List<Map<String, String>> _suggestedQuestions = [
    {'text': "What's the healthcare budget?"},
    {'text': 'Compare states spending'},
    {'text': 'Where does my tax go?'},
    {'text': 'Education budget trends'},
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _tts = FlutterTts();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // 🔑 Use passed apiKey first, fall back to .env
    String resolvedKey = widget.apiKey ?? '';
    if (resolvedKey.isEmpty) {
      try {
        resolvedKey = dotenv.env['GEMINI_API_KEY'] ?? '';
      } catch (_) {
        resolvedKey = '';
      }
    }

    if (resolvedKey.isEmpty) {
      _statusMessage = 'Please add GEMINI_API_KEY to .env file';
    }

    _openAI = OpenAIService(apiKey: resolvedKey);
    _initializeTTS();
  }

  Future<void> _initializeTTS() async {
    await _tts.setLanguage("en-US");
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);

    _tts.setCompletionHandler(() {
      setState(() => _isSpeaking = false);
    });

    _tts.setErrorHandler((msg) {
      setState(() {
        _isSpeaking = false;
        _statusMessage = "Speech error";
      });
    });
  }

  Future<void> _listen() async {
    if (_isProcessing || _isSpeaking) {
      setState(() => _statusMessage = "Please wait...");
      return;
    }

    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            if (_isListening && mounted) {
              _stopListening();
            }
          }
        },
        onError: (error) {
          if (mounted) {
            setState(() {
              _isListening = false;
              _statusMessage = "Microphone error: ${error.errorMsg}";
            });
          }
        },
      );

      if (available) {
        setState(() {
          _isListening = true;
          _userWords = '';
          _statusMessage = 'Listening...';
        });

        _speech.listen(
          onResult: (result) {
            if (mounted) {
              setState(() {
                _userWords = result.recognizedWords;
                _textController.text = result.recognizedWords;
                if (result.finalResult) {
                  _stopListening();
                }
              });
            }
          },
          listenFor: const Duration(minutes: 2),
          pauseFor: const Duration(seconds: 5),
          partialResults: true,
          cancelOnError: true,
          listenMode: stt.ListenMode.confirmation,
        );
      } else {
        setState(() => _statusMessage = "Speech recognition not available");
      }
    } else {
      _stopListening();
    }
  }

  Future<void> _stopListening() async {
    if (_isListening) {
      await _speech.stop();

      if (mounted) {
        setState(() => _isListening = false);

        if (_userWords.trim().isNotEmpty) {
          await _sendToGPT();
        } else {
          setState(() => _statusMessage = "No speech detected");
        }
      }
    }
  }

  Future<void> _sendToGPT() async {
    if (_userWords.trim().isEmpty) return;

    final question = _userWords.trim();
    setState(() {
      _isProcessing = true;
      _assistantReply = "";
      _statusMessage = "Thinking...";
      _messages.add({'role': 'user', 'text': question});
      _userWords = '';
      _textController.clear();
    });

    _scrollToBottom();

    try {
      final reply = await _openAI.askGPT(question);

      if (mounted) {
        setState(() {
          _assistantReply = reply;
          _statusMessage = "Response ready";
          _messages.add({'role': 'assistant', 'text': reply});
        });
        _scrollToBottom();
        await _speak(reply);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _assistantReply = "Error: $e";
          _statusMessage = "Error occurred";
          _messages.add({'role': 'assistant', 'text': "Error: $e"});
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _sendTextMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _userWords = text;
    });
    _sendToGPT();
  }

  void _askSuggestedQuestion(String question) {
    setState(() {
      _userWords = question;
      _textController.text = question;
    });
    _sendToGPT();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _speak(String text) async {
    if (text.isEmpty || text.contains("Error")) return;

    setState(() {
      _isSpeaking = true;
      _statusMessage = "Speaking...";
    });

    try {
      await _tts.stop();
      await Future.delayed(const Duration(milliseconds: 300));
      await _tts.speak(text);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSpeaking = false;
          _statusMessage = "TTS error";
        });
      }
    }
  }

  Future<void> _stopSpeaking() async {
    await _tts.stop();
    if (mounted) {
      setState(() {
        _isSpeaking = false;
        _statusMessage = "Stopped";
      });
    }
  }

  @override
  void dispose() {
    _speech.cancel();
    _tts.stop();
    _pulseController.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ─── COLOR CONSTANTS ───────────────────────────────────────────────
  static const Color _teal = Color(0xFF00BFA5);
  static const Color _tealLight = Color(0xFFE0F7FA);
  static const Color _bgColor = Color(0xFFF0F4F5);
  static const Color _white = Colors.white;
  static const Color _textDark = Color(0xFF1A1A2E);
  static const Color _textMuted = Color(0xFF7A8B9A);

  @override
  Widget build(BuildContext context) {
    // 🔙 WillPopScope handles system back button → pops to home_screen
    return WillPopScope(
      onWillPop: () async {
        await _tts.stop();
        await _speech.cancel();
        return true; // allow pop
      },
      child: Scaffold(
        backgroundColor: _bgColor,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _messages.isEmpty
                    ? _buildEmptyState()
                    : _buildChatList(),
              ),
              _buildBottomInputBar(),
              _buildBottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: _bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // 🔙 Back arrow navigates back to home_screen
          GestureDetector(
            onTap: () async {
              await _tts.stop();
              await _speech.cancel();
              if (mounted) Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: _teal, size: 24),
          ),
          const SizedBox(width: 12),
          const Text(
            'AI Assistant',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _textDark,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              setState(() {
                _messages.clear();
                _userWords = '';
                _assistantReply = '';
                _statusMessage = 'Ready to assist you';
                _textController.clear();
              });
              _openAI.clearHistory();
            },
            icon: const Icon(Icons.refresh_rounded, color: _textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Text(
            'Suggested questions:',
            style: TextStyle(
              fontSize: 13,
              color: _textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          _buildSuggestedGrid(),
          const SizedBox(height: 16),
          _buildWelcomeBubble(),
        ],
      ),
    );
  }

  Widget _buildSuggestedGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 3.2,
      children: _suggestedQuestions.map((q) {
        return GestureDetector(
          onTap: () => _askSuggestedQuestion(q['text']!),
          child: Container(
            decoration: BoxDecoration(
              color: _white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: _teal.withOpacity(0.4), width: 1.2),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              q['text']!,
              style: const TextStyle(
                fontSize: 12.5,
                color: _textDark,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWelcomeBubble() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Text(
        "Hello! I'm your budget assistant. Ask me anything about government spending!",
        style: TextStyle(fontSize: 14, color: _textDark, height: 1.4),
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: _messages.length + (_isProcessing ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length && _isProcessing) {
          return _buildTypingIndicator();
        }
        final msg = _messages[index];
        final isUser = msg['role'] == 'user';
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: isUser
              ? _buildUserBubble(msg['text']!)
              : _buildAssistantBubble(msg['text']!),
        );
      },
    );
  }

  Widget _buildUserBubble(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00BFA5), Color(0xFF0097A7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(
              color: _teal.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildAssistantBubble(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: _tealLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, size: 16, color: _teal),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: _textDark,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: _tealLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, size: 16, color: _teal),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: _white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _teal.withOpacity(
                          0.3 +
                              0.7 *
                                  (((_pulseController.value + i * 0.3) % 1.0)),
                        ),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomInputBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 6, 12, 8),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: (_) => _sendTextMessage(),
              style: const TextStyle(fontSize: 14, color: _textDark),
              decoration: const InputDecoration(
                hintText: 'Ask about budget allocation...',
                hintStyle: TextStyle(color: _textMuted, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          GestureDetector(
            onTap: (_isProcessing || _isSpeaking) ? null : _listen,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _isListening ? _pulseAnimation.value : 1.0,
                    child: Icon(
                      _isListening ? Icons.mic : Icons.mic_none_rounded,
                      color: _isListening ? Colors.redAccent : _textMuted,
                      size: 22,
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: _sendTextMessage,
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _teal.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: _teal, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.map_outlined, 'label': 'Regions'},
      {'icon': Icons.compare_arrows_rounded, 'label': 'Compare'},
      {'icon': Icons.chat_bubble_outline_rounded, 'label': 'AI Chat'},
      {'icon': Icons.person_outline_rounded, 'label': 'Profile'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: _white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final isSelected = i == _selectedNavIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedNavIndex = i),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[i]['icon'] as IconData,
                      color: isSelected ? _teal : _textMuted,
                      size: 22,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      items[i]['label'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected ? _teal : _textMuted,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
