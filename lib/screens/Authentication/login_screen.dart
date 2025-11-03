import 'package:flutter/material.dart';
import '../../widgets/app_background.dart';
import '../../widgets/login_page/login_logo.dart';
import '../../widgets/login_page/login_input_box.dart';
import '../../widgets/login_page/login_button.dart';
import '../../firebase_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  final FirebaseService _firebaseService = FirebaseService(); // FirebaseService instance

  // Handle Google Sign-In logic
  Future<void> _handleGoogleSignIn() async {
    try {
      await _firebaseService.signInWithGoogle();
      Navigator.pushNamed(context, '/home'); // Navigate on successful sign in
    } catch (e) {
      debugPrint('Google Sign-In error: $e');
      _showErrorPopup('Google Sign-In failed. Please try again.');
    }
  }

  // Display error popup
  void _showErrorPopup(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginLogo(),
            const SizedBox(height: 40),
            LoginInputBox(
              onEmailChanged: (value) => setState(() => email = value),
              onPasswordChanged: (value) => setState(() => password = value),
            ),
            const SizedBox(height: 20),
            LoginButton(email: email, password: password),
            const SizedBox(height: 50),
            // Sign Up Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/SignUp');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text("Dont have an account? Sign Up"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _handleGoogleSignIn,
              icon: Image.asset(
                'assets/google.png',
                height: 24, // Adjust size as needed
              ),
              label: const Text('Sign in with Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

