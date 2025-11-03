import 'package:flutter/material.dart';

class CurrentListingsBox extends StatelessWidget {
  const CurrentListingsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Current listings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFD9AFA3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/NUS T-Shirt.png',
                  fit: BoxFit.cover,
                ),
              ),
              //current texts shown in the figma example 
              const SizedBox(height: 10),
              const Text("Price: \$10"),
              const Text("Condition: Slightly used"),
              const Text("Meet up location: Bishan MRT"),
              const Text("Description: NUS t-shirt"),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB0B0B0),
                  foregroundColor: Colors.black,
                ),
                child: const Text("Sold"),// text in the button
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit', arguments: {
                    'title': 'Edit Listing',
                    'listingId': 1,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB0B0B0),
                  foregroundColor: Colors.black,
                ),
                child: const Text("Edit listing"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}