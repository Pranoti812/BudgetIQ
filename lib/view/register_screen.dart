// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:socio_hub/controller/auth_controller.dart';
// import 'package:socio_hub/model/data_model.dart';
// import 'package:socio_hub/view/customsnackbar.dart';
// import 'package:socio_hub/view/login_screen.dart';
// import 'package:socio_hub/view/splash_screen.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//   bool isLoading = false;
//   final TextEditingController flatNoController = TextEditingController();
//   final TextEditingController parkingNoController = TextEditingController();
//   final TextEditingController floorNoController = TextEditingController();
//   final TextEditingController dateController = TextEditingController();
//   selectDate(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2025),
//     );
//     if (pickedDate != null) {
//       String strDate = DateFormat.yMMMMd().format(pickedDate!);
//       dateController.text = strDate;
//     }
//   }

//   final FirebaseFirestore _firebaseFirestoreObj = FirebaseFirestore.instance;
//   List<DataModel> dataList = [];

//   AuthController authController = AuthController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController dobController = TextEditingController();
//   TextEditingController flatController = TextEditingController();
//   TextEditingController floorController = TextEditingController();
//   TextEditingController parkingController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController mobileController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEAF3FF),
//       body: Container(
//         width: 450,
//         height: 800,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFF5F9FF), Color(0xFFEAF3FF)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(30),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 15,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Register',
//                       style: GoogleFonts.poppins(
//                         color: Color(0xFF8A3FFC),
//                         fontSize: 25,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 24),
//                   const Text(
//                     "Create Account",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const Text(
//                     "Fill the details to register",
//                     style: TextStyle(color: Colors.black54),
//                   ),

//                   const SizedBox(height: 20),

//                   // Form Fiel
//                    _buildTextField(firstNameController,Icons.person, "First Name"),
//                    _buildTextField(lastNameController,Icons.person_outline, "Last Name"),
                  
//                   TextField(
//                     controller: dateController,
//                   _buildTextField(Icons.person, "First Name",firstNameController),
//                   _buildTextField(Icons.person_outline, "Last Name",lastNameController),
//                   TextField(
//                     controller: dobController,

//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.cake, color: Colors.grey[700]),
//                       hintText: "Enter DOB",
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 18,
//                         horizontal: 20,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: const BorderSide(color: Colors.transparent),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.grey[300]!),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: const BorderSide(
//                           color: Color(0xFF9C27F0),
//                           width: 1.4,
//                         ),
//                       ),
//                     ),
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2025),
//                       );
//                       dobController.text = DateFormat.yMMMd().format(
//                         pickedDate!,
//                       );
//                     },
//                   ),
//                   // _buildTextField(Icons.cake, "Date of Birth (DD/MM/YYYY)",dobController),
//                   _buildTextField(Icons.email_outlined, "Email ID",emailController),
//                   _buildTextField(Icons.location_on, "Address", addressController),
//                   _buildTextField(Icons.phone, "Mobile Number", mobileController),
//                   _buildTextField(Icons.home, "Flat No",flatController),
//                   _buildTextField(Icons.apartment, "Floor No",floorController),
//                   _buildTextField(Icons.local_parking, "Parking No",parkingController),

//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.cake, color: Colors.grey[700]),
//                       hintText: "Enter DOB",
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 18,
//                         horizontal: 20,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: const BorderSide(color: Colors.transparent),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.grey[300]!),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: const BorderSide(
//                           color: Color(0xFF9C27F0),
//                           width: 1.4,
//                         ),
//                       ),
//                     ),
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2025),
//                       );
//                       dateController.text = DateFormat.yMMMd().format(
//                         pickedDate!,
//                       );
//                     },
//                   ),
                  
//                   _buildTextField(emailController,
//                     Icons.email_outlined, "Email ID"),
//                   _buildTextField(flatNoController,
//                     Icons.home, "Flat No"),
//                   _buildTextField(floorNoController,
//                     Icons.apartment, "Floor No"),
//                   _buildTextField(parkingNoController,
//                     Icons.local_parking, "Parking No"),

//                   _buildPasswordField("Password", _obscurePassword, (value) {
//                     setState(() => _obscurePassword = !_obscurePassword);
//                   }),
//                   _buildPasswordField(
//                     "Confirm Password",
//                     _obscureConfirmPassword,
//                     (value) {
//                       setState(
//                         () =>
//                             _obscureConfirmPassword = !_obscureConfirmPassword,
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 25),
//                   // Register Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(

//                       onPressed: () async{
//                         if(emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty && firstNameController.text.trim().isNotEmpty && lastNameController.text.trim().isNotEmpty && dobController.text.trim().isNotEmpty && flatController.text.trim().isNotEmpty && floorController.text.trim().isNotEmpty && confirmPasswordController.text.trim().isNotEmpty && parkingController.text.trim().isNotEmpty && addressController.text.trim().isNotEmpty) {
                          
                          
//                         try{
//                           authController.signup(emailController.text, passwordController.text, context);
                        
//                         CustomSnackbar().showCustomSnackbar(context,'Register Successfully',bgColor: Colors.green);
//                         Navigator.of(context).pop();
//                         }catch(e){
//                           CustomSnackbar().showCustomSnackbar(context,'Please Fill the details',bgColor: Colors.red);
//                         }
//                         Map<String,dynamic> obj = {
//                             'firstName': firstNameController.text,
//                             'lastName': lastNameController.text,
//                             'dob': dobController.text,
//                             'emailId': emailController.text,
//                             'flatNo': flatController.text,
//                             'floorNo': floorController.text,
//                             'parkingNo': parkingController.text,
//                             'Address': addressController.text,
//                             'phone': mobileController.text
//                           };
//                         await _firebaseFirestoreObj.collection("UserData").add(obj);
//                         log("Data Added Successfully");

//                         setState(() {
                          
//                         });
                        
//                       }
//                       emailController.clear();
//                       passwordController.clear();
//                       firstNameController.clear();
//                       lastNameController.clear();
//                       dobController.clear();
//                       flatController.clear();
//                       floorController.clear();
//                       parkingController.clear();
//                       confirmPasswordController.clear();
//                       addressController.clear();
//                       },
// >>>>>>> 1cd56c1 (nineth commit)
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF9C27F0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         elevation: 4,
//                         shadowColor: Colors.purpleAccent.withOpacity(0.4),
//                       ),
//                       child: const Text(
//                         "Register →",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller,
//     IconData icon, String hintText) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: TextField(
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.grey[700]),
//           hintText: hintText,
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 18,
//             horizontal: 20,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: const BorderSide(color: Colors.transparent),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(color: Colors.grey[300]!),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: const BorderSide(color: Color(0xFF9C27F0), width: 1.4),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPasswordField(
//     String hintText,
//     bool obscure,
//     Function(bool) toggle,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: TextField(
//         obscureText: obscure,
//         decoration: InputDecoration(
//           prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
//           suffixIcon: IconButton(
//             icon: Icon(
//               obscure ? Icons.visibility_off : Icons.visibility,
//               color: Colors.grey,
//             ),
//             onPressed: () => toggle(obscure),
//           ),
//           hintText: hintText,
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 18,
//             horizontal: 20,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: const BorderSide(color: Colors.transparent),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(color: Colors.grey[300]!),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: const BorderSide(color: Color(0xFF9C27F0), width: 1.4),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:budegt_iq/controller/auth_controller.dart';
import 'package:budegt_iq/view/customsnackbar.dart';
import 'package:budegt_iq/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
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

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final AuthController authController = AuthController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController parkingController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController familyMemberController = TextEditingController();
  final TextEditingController vehicleCountController = TextEditingController();

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
              Color(0xFF8A3FFC), // Purple top
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
                          color: Colors.white,
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
                                color: Color(0xFF4A148C),
                              ),
                            ),

                            const SizedBox(height: 12),

                            _buildTextField(Icons.person, "First Name", firstNameController),
                            _buildTextField(Icons.person_outline, "Last Name", lastNameController),
                            _buildTextField(Icons.email_outlined, "Email ID", emailController),
                            _buildTextField(Icons.phone, "Mobile Number", mobileController),
                            _buildTextField(Icons.home, "Flat No", flatController),
                            _buildTextField(Icons.apartment, "Floor No", floorController),
                            _buildTextField(Icons.location_on, "Address", addressController),
                            _buildTextField(Icons.local_parking, "Parking No", parkingController),
                            _buildTextField(Icons.local_parking, "Members in Family", familyMemberController),
                            _buildTextField(Icons.local_parking, "Vehicle Count", vehicleCountController),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: TextField(
                                controller: dobController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.cake, color: Colors.grey[700]),
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
                                    dobController.text = DateFormat.yMMMd().format(pickedDate);
                                  }
                                },
                              ),
                            ),

                            _buildPasswordField(
                              "Password",
                              _obscurePassword,
                              passwordController,
                              (v) => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            _buildPasswordField(
                              "Confirm Password",
                              _obscureConfirmPassword,
                              confirmPasswordController,
                              (v) => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isLoading ? null : _handleRegister,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8A3FFC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: isLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : const Text(
                                        "Register →",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white70),
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
      CustomSnackbar().showCustomSnackbar(context, 'Please fill all fields correctly.', bgColor: Colors.red);
      return;
    }
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      CustomSnackbar().showCustomSnackbar(context, 'Passwords do not match.', bgColor: Colors.red);
      return;
    }

    setState(() => isLoading = true);

    try {
      await authController.signup(emailController.text.trim(), passwordController.text.trim(), context);

      await _firebaseFirestore.collection("UserData").add({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'dob': dobController.text.trim(),
        'emailId': emailController.text.trim(),
        'flatNo': flatController.text.trim(),
        'floorNo': floorController.text.trim(),
        'parkingNo': parkingController.text.trim(),
        'Address': addressController.text.trim(),
        'phone': mobileController.text.trim(),
        'familyMembers': familyMemberController.text.trim(),
        'vehicleCount': vehicleCountController.text.trim(),
      });

      CustomSnackbar().showCustomSnackbar(context, 'Registered Successfully!', bgColor: Colors.green);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    } catch (e) {
      CustomSnackbar().showCustomSnackbar(context, 'Registration failed: $e', bgColor: Colors.red);
    } finally {
      setState(() => isLoading = false);
    }
  }

  bool _isFormValid() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        flatController.text.isNotEmpty &&
        floorController.text.isNotEmpty &&
        parkingController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        mobileController.text.isNotEmpty;
  }

  Widget _buildTextField(IconData icon, String hintText, TextEditingController controller) {
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
      String hintText, bool obscure, TextEditingController controller, Function(bool) toggle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
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
