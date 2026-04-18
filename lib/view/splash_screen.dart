import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 🔹 Animation (smooth fade)
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    // 🔹 Navigate after 3 sec
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        // 🎨 EXACT DARK BACKGROUND LIKE YOUR IMAGE
        decoration: BoxDecoration(
          //color:
          // Color.fromARGB(
          //   255,
          //   6,
          //   19,
          //   32,
          // ),
          color: Color.fromARGB(
            255,
            11,
            26,
            45,
          ), // deep navy (matches your logo bg)
        ),

        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔥 FULL LOGO IMAGE
              Image.asset(
                'assets/budegtIQLogo.png',
                width: 450,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 80),

              // 🔹 LOADING INDICATOR (SUBTLE)
              SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
