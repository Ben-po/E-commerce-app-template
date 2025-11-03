import 'package:flutter/material.dart';

class ListingCard extends StatelessWidget {
  const ListingCard({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFD9AFA3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Image.asset('assets/NUS T-Shirt.png', height: 180), 
            const SizedBox(height: 8),
            //current texts shown in the figma example 
            const Text("Price: \$10", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Condition: Slightly used"),
            const Text("Meet up location: Bishan MRT"),
            const Text("Brand: NA"),
            const Text("Description: NUS t-shirt"),
            const Align(
              alignment: Alignment.bottomRight,
              child: Text("By: Test user", style: TextStyle(fontSize: 12)),
            ),
            const Text("Click for more info", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
