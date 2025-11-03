import 'package:flutter/material.dart';

class DonateBox extends StatelessWidget {
  const DonateBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to Donate screen when implemented
        // Navigator.pushNamed(context, '/donate');
      },
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFD9AFA3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Text(
            'Donate',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
