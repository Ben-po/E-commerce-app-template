import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:part2_benjaminpo_2404190g_p06/firebase_service.dart';

class ProfileInfoBox extends StatelessWidget {
  const ProfileInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4C6C6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Edit header
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(Icons.edit, size: 20),
              SizedBox(width: 4),
              Text("Click to edit", style: TextStyle(fontSize: 16)),
            ],
          ),
          // Profile info with avatar, username, and description
          Row(
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.white),
                    SizedBox(height: 4),
                    Text(
                      "Profile Picture",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Username: Test user"),
                    Text("Password: **********"),
                    Text("Email: be*********@gmail.com"),
                    Text("Description: I love to recycle!"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 2x2 Grid of Buttons
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3, // Adjust as needed for proper button sizing
            children: [
              // Check messages button
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Add check messages logic
                },
                icon: const Icon(Icons.message),
                label: const Text("Check messages"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9A5A5),
                  foregroundColor: Colors.black,
                ),
              ),
              // Change Password button
              ElevatedButton.icon(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null && user.email != null) {
                    try {
                      await FirebaseService().sendForgetPasswordEmail(user.email!);
                      _showPopup(
                        context,
                        'Password Reset Email Sent',
                        'A reset link has been sent to your email address. Please check your inbox.',
                      );
                    } catch (e) {
                      _showPopup(context, 'Error', e.toString());
                    }
                  } else {
                    _showPopup(
                        context, 'Error', 'No user is signed in or email is not available.');
                  }
                },
                icon: const Icon(Icons.lock_outline),
                label: const Text("Change Password"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9A5A5),
                  foregroundColor: Colors.black,
                ),
              ),
              // Verify Email button with Firebase logic
              ElevatedButton.icon(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null && !user.emailVerified) {
                    await user.sendEmailVerification();
                    _showPopup(context, 'Verification Email Sent',
                        'A verification email has been sent to your email address. Please check your inbox.');
                  } else if (user != null && user.emailVerified) {
                    _showPopup(
                        context, 'Already Verified', 'Your email is already verified.');
                  } else {
                    _showPopup(context, 'Error', 'No user is signed in.');
                  }
                },
                label: const Text("Verify Email"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9A5A5),
                  foregroundColor: Colors.black,
                ),
                icon: const Icon(Icons.email),
              ),
              // Logout button
              ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();
                  _showLogoutPopup(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9A5A5),
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPopup(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Successful'),
          content: const Text('You have been logged out successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the popup
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}