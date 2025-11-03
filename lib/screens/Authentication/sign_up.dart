import 'package:flutter/material.dart';
import '../../firebase_service.dart';
import '../../widgets/app_background.dart';
import '../../widgets/login_page/login_logo.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBE4C6), // Blend in with the background
        elevation: 0, // Ensure the app bar does not have a shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LoginLogo(),
              const SizedBox(height: 20),
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 60),
              _inputField(
                label: "Email",
                onChanged: (value) => setState(() => email = value),
              ),
              const SizedBox(height: 16),
              _inputField(
                label: "Password",
                obscureText: true,
                onChanged: (value) => setState(() => password = value),
              ),
              const SizedBox(height: 16),
              _inputField(
                label: "Confirm Password",
                obscureText: true,
                onChanged: (value) => setState(() => confirmPassword = value),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if (email.isEmpty || password.isEmpty) {
                      _showErrorPopup(context, "Please enter valid email and password.");
                      return;
                    }
                    if (password != confirmPassword) {
                      _showErrorPopup(context, "Passwords do not match!");
                      return;
                    }

                    final firebaseService = FirebaseService();
                    try {
                      await firebaseService.register(email, password);
                      _showSuccessPopup(context);
                    } catch (e) {
                      _showErrorPopup(context, e.toString());
                    }
                  },
                  child: const Text("Sign Up"),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Or sign up with"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/google.png', height: 40),
                  const SizedBox(width: 40),
                  Image.asset('assets/facebook.png', height: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String label,
    bool obscureText = false,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        TextField(
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            fillColor: Colors.pink[200],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('Your account has been created successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the popup
                Navigator.pushNamed(context, '/login'); // Navigate to login screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the popup
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

