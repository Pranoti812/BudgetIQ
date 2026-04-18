import 'package:budegt_iq/view/dashboard_screen.dart';
import 'package:budegt_iq/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'view/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
    home:  DashboardScreen());
  }
}
