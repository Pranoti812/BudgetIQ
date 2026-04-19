import 'package:budegt_iq/controller/auth_controller.dart';
import 'package:budegt_iq/controller/user_controller.dart';
import 'package:budegt_iq/view/customsnackbar.dart';
import 'package:budegt_iq/view/dashboard_screen.dart';
import 'package:budegt_iq/view/forgot_password_screen.dart';
import 'package:budegt_iq/view/home_screen.dart';
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
      backgroundColor: Colors.white, // ✅ changed
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(25),
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white, // ✅ changed
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TOGGLE
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200, // ✅ light bg
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
                          color: Colors.green,
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
                                'Citizen',
                                style: GoogleFonts.poppins(
                                  color:
                                      isLogin ? Colors.white : Colors.black54,
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
                                'Government',
                                style: GoogleFonts.poppins(
                                  color:
                                      !isLogin ? Colors.white : Colors.black54,
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

              Text(
                'Welcome Back',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black, // ✅
                ),
              ),

              Text(
                'Sign in to continue',
                style: GoogleFonts.poppins(
                  color: Colors.black54, // ✅
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 25),

              // EMAIL
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: Colors.grey.shade100, // ✅
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // PASSWORD
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: const Icon(Icons.visibility_outlined),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ForgotPasswordScreen(
                            email: emailController.text.trim(), // ✅ pass email
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Register',
                    style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // BUTTON (logic unchanged)
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: GestureDetector(
                    // onTap: () async {
                    //   if (emailController.text.trim().isEmpty ||
                    //       passwordController.text.trim().isEmpty) {
                    //     CustomSnackbar().showCustomSnackbar(
                    //       context,
                    //       'Enter valid data',
                    //       bgColor: Colors.red,
                    //     );
                    //     return;
                    //   }

                    //   setState(() => isLoading = true);

                    //   bool success = await authController.login(
                    //     emailController.text.trim(),
                    //     passwordController.text.trim(),
                    //   );

                    //   setState(() => isLoading = false);

                    //   if (success) {
                    //     CustomSnackbar().showCustomSnackbar(
                    //       context,
                    //       'Login Successful',
                    //       bgColor: Colors.green,
                    //     );

                    //     Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(builder: (_) => CitizenHomeScreen()),
                    //     );
                    //   } else {
                    //     CustomSnackbar().showCustomSnackbar(
                    //       context,
                    //       'Invalid Email or Password',
                    //       bgColor: Colors.red,
                    //     );
                    //   }
                    // },

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

                      // 🏛️ GOVERNMENT LOGIN
                      if (!isLogin) {
                        if (emailController.text.trim() == "admin@gov.in" &&
                            passwordController.text.trim() == "123456") {
                          setState(() => isLoading = false);

                          CustomSnackbar().showCustomSnackbar(
                            context,
                            'Government Login Successful',
                            bgColor: Colors.green,
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    DashboardScreen()), // change to admin screen later
                          );
                        } else {
                          setState(() => isLoading = false);

                          CustomSnackbar().showCustomSnackbar(
                            context,
                            'Invalid Government Credentials',
                            bgColor: Colors.red,
                          );
                        }
                        return;
                      }

                      // 👤 CITIZEN LOGIN (Firebase)
                      bool success = await authController.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      setState(() => isLoading = false);

                      if (success) {
                        CustomSnackbar().showCustomSnackbar(
                          context,
                          'Login Successful',
                          bgColor: Colors.green,
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CitizenHomeScreen()),
                        );
                      } else {
                        CustomSnackbar().showCustomSnackbar(
                          context,
                          'Invalid Email or Password',
                          bgColor: Colors.red,
                        );
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
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
              SizedBox(height: 8),
              const SizedBox(height: 15),

              GestureDetector(
                onTap: () async {
                  setState(() => isLoading = true);

                  final user = await authController.signInWithGoogle();

                  setState(() => isLoading = false);

                  if (user != null) {
                    CustomSnackbar().showCustomSnackbar(
                      context,
                      'Google Sign-In Successful',
                      bgColor: Colors.green,
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => CitizenHomeScreen()),
                    );
                  } else {
                    CustomSnackbar().showCustomSnackbar(
                      context,
                      'Google Sign-In Failed',
                      bgColor: Colors.red,
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://cdn-icons-png.flaticon.com/512/2991/2991148.png",
                        height: 22,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Continue with Google",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
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
