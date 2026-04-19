import 'package:budegt_iq/controller/auth_controller.dart';
import 'package:budegt_iq/view/customsnackbar.dart';
import 'package:budegt_iq/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
//import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isLoading = false;

  String selectedNationality = "Select Nationality";

  List<String> nationalityList = [
    "Select Nationality",
    "Indian",
    "American",
    "Canadian",
    "Australian",
    "Other"
  ];

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final AuthController authController = AuthController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController citizenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white, // Purple top
              Colors.white, // White bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: 1,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 800),
                  offset: const Offset(0, 0),
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 150,
                      //   child: Image.asset("assets/images/home_services_header.png"),
                      // ),
                      const SizedBox(height: 10),

                      Text(
                        'Register',
                        style: GoogleFonts.poppins(
                          color: Colors.green,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),

                            const SizedBox(height: 12),

                            _buildTextField(
                              Icons.person,
                              "Enter Your Name",
                              firstNameController,
                            ),
                            _buildTextField(
                              Icons.email_outlined,
                              "Email ID",
                              emailController,
                            ),
                            _buildTextField(
                              Icons.phone,
                              "Mobile Number",
                              mobileController,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: DropdownButtonFormField<String>(
                                value: selectedNationality,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.apartment, color: Colors.grey[700]),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                items: nationalityList.map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedNationality = value!;
                                    citizenController.text = value; // ✅ keep your old logic working
                                  });
                                },
                              ),
                            ),
                        
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: TextField(
                                controller: dobController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.cake,
                                    color: Colors.grey[700],
                                  ),
                                  hintText: "Date of Birth",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2025),
                                  );
                                  if (pickedDate != null) {
                                    dobController.text = DateFormat.yMMMd()
                                        .format(pickedDate);
                                  }
                                },
                              ),
                            ),

                            _buildPasswordField(
                              "Password",
                              _obscurePassword,
                              passwordController,
                              (v) => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                            ),
                            _buildPasswordField(
                              "Confirm Password",
                              _obscureConfirmPassword,
                              confirmPasswordController,
                              (v) => setState(
                                () => _obscureConfirmPassword =
                                    !_obscureConfirmPassword,
                              ),
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isLoading ? null : _handleRegister,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
  if (!_isFormValid()) {
    CustomSnackbar().showCustomSnackbar(
      context,
      'Please fill all fields correctly.',
      bgColor: Colors.red,
    );
    return;
  }

  // ✅ NEW: Nationality Check (ONLY ADDITION)
  if (!citizenController.text.trim().toLowerCase().contains("india")) {
    CustomSnackbar().showCustomSnackbar(
      context,
      'User must be Indian',
      bgColor: Colors.red,
    );
    return;
  }

  if (passwordController.text.trim() !=
      confirmPasswordController.text.trim()) {
    CustomSnackbar().showCustomSnackbar(
      context,
      'Passwords do not match.',
      bgColor: Colors.red,
    );
    return;
  }

  setState(() => isLoading = true);

  try {
    // ✅ MODIFIED: Capture result
    bool success = await authController.signup(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    // ✅ NEW: Stop if signup fails
    if (!success) {
      CustomSnackbar().showCustomSnackbar(
        context,
        'Registration Failed',
        bgColor: Colors.red,
      );
      return;
    }

    // ✅ SAME: Firestore logic (unchanged)
    await _firebaseFirestore.collection("UserData").add({
      'Name': firstNameController.text.trim(),
      'dob': dobController.text.trim(),
      'emailId': emailController.text.trim(),
      'Nationality': citizenController.text.trim(),
      'phone': mobileController.text.trim(),
    });

    CustomSnackbar().showCustomSnackbar(
      context,
      'Registered Successfully!',
      bgColor: Colors.green,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  } catch (e) {
    CustomSnackbar().showCustomSnackbar(
      context,
      'Registration failed: $e',
      bgColor: Colors.red,
    );
  } finally {
    setState(() => isLoading = false);
  }
}

  bool _isFormValid() {
  return emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      confirmPasswordController.text.isNotEmpty &&
      firstNameController.text.isNotEmpty &&
      dobController.text.isNotEmpty &&
      mobileController.text.isNotEmpty &&
      selectedNationality != "Select Nationality"; // ✅ added
  }

  Widget _buildTextField(
    IconData icon,
    String hintText,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey[700]),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    String hintText,
    bool obscure,
    TextEditingController controller,
    Function(bool) toggle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () => toggle(obscure),
          ),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
