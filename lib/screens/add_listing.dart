import 'package:flutter/material.dart';
import '../widgets/app_background.dart';
import '../widgets/add_listing/add_box.dart';
import '../widgets/bottom_nav.dart';

class AddListingScreen extends StatelessWidget {
  const AddListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD9AFA3),
        title: const Text('Add Listing'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, '/profile', arguments: {
            });
          },
        ),
      ),
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),


              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/camera.png',
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Add a photo',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              AddInfoBox(  //The text box for the title of the listing
                controller: TextEditingController(),
                hintText: 'Price of your listing',
              ),
              const SizedBox(height: 20), // spaces in between each box or button

              AddInfoBox(
                controller: TextEditingController(),
                hintText: 'Current condition of your item',
              ),
              const SizedBox(height: 20),

              AddInfoBox(
                controller: TextEditingController(),
                hintText: 'Meet up/pick up location',
              ),
              const SizedBox(height: 20),

              AddInfoBox(
                controller: TextEditingController(),
                hintText: 'Brand of your item (if applicable)',
              ),
              const SizedBox(height: 20),

              AddInfoBox(
                controller: TextEditingController(),
                hintText: 'Description of your item',
              ),
              const SizedBox(height: 30),

              //Button to confirm listing
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile', arguments: {
                    'message': 'Listing added successfully!',
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9AFA3),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 40),
                ),
                child: const Text("Confirm listing"),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
