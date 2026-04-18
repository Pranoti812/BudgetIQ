//import 'dart:developer';

import 'package:budegt_iq/controller/auth_controller.dart';
import 'package:budegt_iq/controller/user_controller.dart';
import 'package:budegt_iq/view/customsnackbar.dart';
import 'package:budegt_iq/view/register_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  bool isLoading = false;

  AuthController authController = AuthController();
  UserController userController = UserController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1A2F), // DARK BACKGROUND
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(25),
          width: 350,
          decoration: BoxDecoration(
            color: const Color(0xFF162544).withOpacity(0.9),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔹 TOGGLE BUTTON
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2E4F),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      alignment: isLogin
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        width: 170,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8A3FFC),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => isLogin = true),
                            child: Center(
                              child: Text(
                                'Resident',
                                style: GoogleFonts.poppins(
                                  color: isLogin
                                      ? Colors.white
                                      : Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => isLogin = false),
                            child: Center(
                              child: Text(
                                'Admin',
                                style: GoogleFonts.poppins(
                                  color: !isLogin
                                      ? Colors.white
                                      : Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // 🔹 TITLE
              Text(
                'Welcome Back',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Sign in to continue',
                style: GoogleFonts.poppins(color: Colors.white54, fontSize: 13),
              ),

              const SizedBox(height: 25),

              // 🔹 EMAIL FIELD
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: const TextStyle(color: Colors.white38),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.white70,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1E2E4F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // 🔹 PASSWORD FIELD
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  hintStyle: const TextStyle(color: Colors.white38),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.white70,
                  ),
                  suffixIcon: const Icon(
                    Icons.visibility_outlined,
                    color: Colors.white70,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1E2E4F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF8A3FFC),
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => RegisterScreen()));
                  },
                  child: Text(
                    'Register',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF8A3FFC),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // 🔹 LOGIN BUTTON
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8A3FFC), Color(0xFF6A5AE0)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8A3FFC).withOpacity(0.5),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (emailController.text.trim().isEmpty ||
                          passwordController.text.trim().isEmpty) {
                        CustomSnackbar().showCustomSnackbar(
                          context,
                          'Enter valid data',
                          bgColor: Colors.red,
                        );
                        return;
                      }

                      setState(() => isLoading = true);

                      try {
                        await authController.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          context,
                        );

                        String email = emailController.text.trim();
                        String pass = passwordController.text.trim();

                        if (email == 'admin@gmail.com' && pass == '123456') {
                          Map<String, dynamic> data = {
                            'email': email,
                            'password': pass,
                            'loginFlag': true,
                          };
                          userController.setSharedPrefData(data);

                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //       builder: (context) => HomeScreen()),
                          // );
                        } else {
                          await authController.login(email, pass, context);

                          Map<String, dynamic> data = {
                            'email': email,
                            'password': pass,
                            'loginFlag': true,
                          };
                          userController.setSharedPrefData(data);

                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //       builder: (context) => HomeScreen1()),
                          // );

                          CustomSnackbar().showCustomSnackbar(
                            context,
                            'Login Successful',
                            bgColor: Colors.green,
                          );
                        }
                      } on FirebaseAuthException catch (_) {
                        final pendingSnap = await FirebaseFirestore.instance
                            .collection('pending_requests')
                            .where(
                              'email',
                              isEqualTo: emailController.text.trim(),
                            )
                            .limit(1)
                            .get();

                        if (pendingSnap.docs.isNotEmpty) {
                          final userDoc = pendingSnap.docs.first.data();
                          if (userDoc['status'] == 'pending') {
                            CustomSnackbar().showCustomSnackbar(
                              context,
                              'Your account is pending admin approval.',
                              bgColor: Colors.orange,
                            );
                          } else if (userDoc['status'] == 'rejected') {
                            CustomSnackbar().showCustomSnackbar(
                              context,
                              'Your registration request was rejected.',
                              bgColor: Colors.red,
                            );
                          } else {
                            CustomSnackbar().showCustomSnackbar(
                              context,
                              'Please wait, your account is being processed.',
                              bgColor: Colors.grey,
                            );
                          }
                        } else {
                          CustomSnackbar().showCustomSnackbar(
                            context,
                            'No account found. Please register first.',
                            bgColor: Colors.red,
                          );
                        }
                      } finally {
                        setState(() => isLoading = false);
                      }

                      emailController.clear();
                      passwordController.clear();
                    },
                    child: isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Sign In',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Text(
                'Or continue with',
                style: GoogleFonts.poppins(color: Colors.white38, fontSize: 13),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialButton('Google'),
                  const SizedBox(width: 15),
                  _socialButton('Apple'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String label) {
    return Container(
      width: 120,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2E4F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
