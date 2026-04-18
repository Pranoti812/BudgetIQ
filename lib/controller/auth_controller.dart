
import 'package:budegt_iq/model/auth_model.dart';
import 'package:budegt_iq/view/customsnackbar.dart';
import 'package:budegt_iq/view/homescreen.dart';
import 'package:budegt_iq/view/login_screen.dart';
import 'package:flutter/material.dart';

class AuthController {
  final AuthModel _model = AuthModel();

  Future<void> login(String email, String password, BuildContext context) async {
    try {
      await _model.login(email, password);
      CustomSnackbar().showCustomSnackbar(context, 'Login Successfully',bgColor: Colors.green);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context){
          return HomeScreen();
        })
      );
      // Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      CustomSnackbar().showCustomSnackbar(context, 'Login Failed!',bgColor: Colors.red);
    }
  }

  Future<void> signup(String email, String password, BuildContext context) async {
    try {
      await _model.signup(email, password);
      CustomSnackbar().showCustomSnackbar(context, 'Sign Up Successfully',bgColor: Colors.green);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context){
          return LoginScreen();
        })
      );
      // Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      CustomSnackbar().showCustomSnackbar(context, 'Please Enter Valid Details',bgColor: Colors.red);
    }
  }
}
