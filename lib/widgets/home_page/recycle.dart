import 'package:flutter/material.dart';

class RecycleBox extends StatelessWidget {
  const RecycleBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to Recycle screen when implemented
        // Navigator.pushNamed(context, '/recycle');
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
            'Recycle',
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
