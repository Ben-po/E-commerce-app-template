import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// FirebaseService class to handle authentication-related operations
class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // For mobile, do not supply a clientId – just use the default constructor
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  int _failedAttempts = 0; // Counter for failed login attempts

  // Method to log in using email and password
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      debugPrint('User logged in successfully');
      _failedAttempts = 0;
    } on FirebaseAuthException catch (_) {
      _failedAttempts++;
      debugPrint('Login failed: Incorrect email or password');
      throw Exception('Incorrect email or password');
    }
  }

  // Method to register a new user
  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      debugPrint('User registered successfully');
    } on FirebaseAuthException catch (e) {
      debugPrint('Registration failed: ${e.message}');
      throw Exception(e.message);
    }
  }

  // Method to send a password reset email
  Future<void> sendForgetPasswordEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      debugPrint('Password reset email sent to $email');
    } catch (e) {
      debugPrint('Failed to send password reset email: $e');
      throw Exception('Failed to send password reset email');
    }
  }

  // Method to sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      // Start the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('Google Sign-In canceled by user');
        return;
      }
      // Retrieve the authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      // Create a new credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Use the credential to sign in
      await _auth.signInWithCredential(credential);
      debugPrint('User signed in with Google successfully');
    } catch (e) {
      debugPrint('Google Sign-In failed: $e');
      throw Exception('Google Sign-In failed');
    }
  }

  // Getter to retrieve the number of failed login attempts
  int get failedAttempts => _failedAttempts; // Getter for failed attempts
}