import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignmet_7/authintication/signinScreen.dart';
import 'package:flutter_assignmet_7/authintication/textFieldReusable.dart';

import 'AuthServices.dart';
import 'homeScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  final GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();
  final AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[100],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: formKeySignUp,
                      child: Column(
                        children: [
                          TextFieldReusable(
                            controller: nameController,
                            labelText: 'Name',
                            hintText: 'Enter your full name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Name";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          TextFieldReusable(
                            controller: emailController,
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Email";
                              } else if (!value.contains('@')) {
                                return "Enter a valid Email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          TextFieldReusable(
                            controller: passController,
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Password";
                              } else if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          TextFieldReusable(
                            controller: confirmPassController,
                            labelText: 'Confirm Password',
                            hintText: 'Re-enter your password',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Confirm Password";
                              } else if (value != passController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 50,
                              ),
                            ),
                            onPressed: () async {
                              try {
                                if (formKeySignUp.currentState!.validate()) {
                                  authServices.signUp(
                                    emailController.text.trim(),
                                    passController.text.trim(),
                                  );
                                }
                                User? currentUser =
                                authServices.getCurrentUSer();
                                if (currentUser != null) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignInScreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Failed to Sign Up"),
                                    ),
                                  );
                                }
                              } catch (e) {
                                print("Error in Sign Up: $e");
                              }
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              // Implement navigation to login screen if needed
                            },
                            child: Text(
                              "Already have an account? Login",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
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
    );
  }
}
