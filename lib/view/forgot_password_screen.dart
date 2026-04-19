import 'package:budegt_iq/controller/auth_controller.dart';
import 'package:budegt_iq/view/customsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String email;

  const ForgotPasswordScreen({super.key, required this.email});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final AuthController authController = AuthController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email; // ✅ prefill email
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reset Your Password",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Enter your registered email. We will send a password reset link.",
              style: GoogleFonts.poppins(
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter Email",
                prefixIcon: const Icon(Icons.email_outlined),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleReset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Send Reset Link",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleReset() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      CustomSnackbar().showCustomSnackbar(
        context,
        'Enter email',
        bgColor: Colors.red,
      );
      return;
    }

    setState(() => isLoading = true);

    bool success = await authController.resetPassword(email);

    setState(() => isLoading = false);

    if (success) {
      CustomSnackbar().showCustomSnackbar(
        context,
        'Reset link sent to your email',
        bgColor: Colors.green,
      );
      Navigator.pop(context);
    } else {
      CustomSnackbar().showCustomSnackbar(
        context,
        'Failed to send reset link',
        bgColor: Colors.red,
      );
    }
  }
}