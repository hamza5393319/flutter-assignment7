import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignmet_7/authintication/textFieldReusable.dart';

import 'AuthServices.dart';
import 'homeScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();
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
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: formKeySignIn,
                      child: Column(
                        children: [
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
                                if (formKeySignIn.currentState!.validate()) {
                                  authServices.signIn(
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
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Failed to Login"),
                                    ),
                                  );
                                }
                              } catch (e) {
                                print("Error in Sign In: $e");
                              }
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              // Navigate to Sign Up screen if needed
                            },
                            child: Text(
                              "Don't have an account? Sign Up",
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
