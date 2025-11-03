import 'dart:async';
import 'package:flutter/material.dart';
import '../../firebase_service.dart';

class LoginButton extends StatefulWidget {
  final String email;
  final String password;

  const LoginButton({super.key, required this.email, required this.password});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _isLocked = false; // Lockout state
  int _lockoutTime = 10; // Lockout duration in seconds
  Timer? _timer;

  void _startLockoutTimer() {
    setState(() {
      _isLocked = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _lockoutTime--;
      });

      if (_lockoutTime == 0) {
        timer.cancel();
        setState(() {
          _isLocked = false;
          _lockoutTime = 10; // Reset lockout time
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseService();
    final remainingAttempts = 3 - firebaseService.failedAttempts;

    return ElevatedButton(
      onPressed: _isLocked
          ? null // Disable the button if locked
          : () async {
              if (widget.email.isEmpty || widget.password.isEmpty) {
                _showErrorPopup(context, "Please enter both email and password.");
                return;
              }

              try {
                await firebaseService.login(widget.email, widget.password);

                // If login is successful, reset failed attempts and show 2FA popup
                if (firebaseService.failedAttempts < 3) {
                  show2FAPopup(context);
                }
              } catch (e) {
                if (firebaseService.failedAttempts >= 3) {
                  _startLockoutTimer(); // Start lockout timer after 3 failed attempts
                }
                _showErrorPopup(
                  context,
                  firebaseService.failedAttempts >= 3
                      ? "Too many failed attempts. Please wait 10 seconds."
                      : "Incorrect email or password. Remaining attempts: $remainingAttempts",
                );
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: _isLocked ? Colors.grey : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50),
      ),
      child: Text(
        _isLocked
            ? "Locked ($_lockoutTime s)"
            : remainingAttempts > 0
                ? "Login (3 Attempts)"
                : "Login",
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  void show2FAPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TwoFAPopup();
      },
    );
  }

  void _showErrorPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Failed'),
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

class TwoFAPopup extends StatefulWidget {
  const TwoFAPopup({super.key});

  @override
  State<TwoFAPopup> createState() => _TwoFAPopupState();
}

class _TwoFAPopupState extends State<TwoFAPopup> {
  final TextEditingController _controller = TextEditingController(); // Controller for the input box
  String? _errorMessage; // Error message to display if verification fails

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }

  void _verifyCode() {
    final enteredCode = _controller.text.trim();
    if (enteredCode == '111111') {
      debugPrint('2FA verification successful');
      Navigator.pushNamed(context, '/home', arguments: {
        'message': 'Login successful!',
      });
    } else {
      setState(() {
        _errorMessage = 'Invalid 2FA code. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFFF5E4C3), // Background color of the popup page
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Two-Factor Authentication',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              maxLength: 6, // Limit input to 6 characters
              decoration: InputDecoration(
                counterText: '', // Remove the character counter
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter 2FA Code',
              ),
              keyboardType: TextInputType.number, // Allow only numbers
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                padding: const EdgeInsets.symmetric(horizontal: 50),
              ),
              child: const Text(
                'Verify',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
