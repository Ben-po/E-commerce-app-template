import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) { //universal background for almost all screens
    return Container(
      color: const Color(0xFFFBE4C6),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SafeArea(child: child),
    );
  }
}
