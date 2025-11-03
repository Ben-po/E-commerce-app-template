import 'package:flutter/material.dart';
import '../../screens/Authentication/forgot_screen.dart'; // Import ForgotScreen

class LoginInputBox extends StatelessWidget {
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;

  const LoginInputBox({
    super.key,
    required this.onEmailChanged,
    required this.onPasswordChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _inputField(label: "Username/Email", onChanged: onEmailChanged),
        const SizedBox(height: 16),
        _inputField(
          label: "Password",
          obscureText: true,
          onChanged: onPasswordChanged,
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotScreen(),
                ),
              );
            },
            child: const Text(
              "Forgot password?",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ],
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
}
