import 'package:budegt_iq/view/settings_screen.dart';
import 'package:budegt_iq/view/simulation_screen.dart';
import 'package:budegt_iq/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Safe initialization (prevents duplicate-app error)
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCN7ctrjCKr7Pw2kjcWD4mGz3a2uKS2mKY",
        appId: "1:963191599541:android:8f0936e412a27e461369fc",
        messagingSenderId: "963191599541",
        projectId: "budgetiq-6c093",
      ),
    );
  } catch (e) {
    // If Firebase is already initialized, just use it
    if (e.toString().contains("duplicate-app")) {
      Firebase.app();
    } else {
      rethrow;
    }
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
     home:  SimulationScreen());
  }
}
