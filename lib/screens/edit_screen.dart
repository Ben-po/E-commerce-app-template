import 'package:flutter/material.dart';
import '../widgets/add_listing/add_box.dart';
import '../widgets/bottom_nav.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  
  Widget build(BuildContext context) { //controllers for text file basically what the user has already input (hard coded for now as database is not implemented)
    final TextEditingController priceController = TextEditingController(text: "\$10");
    final TextEditingController conditionController = TextEditingController(text: "slightly used");
    final TextEditingController locationController = TextEditingController(text: "Bishan MRT");
    final TextEditingController brandController = TextEditingController(text: "NA");
    final TextEditingController descriptionController = TextEditingController(text: "NUS t-shirt");

    return Scaffold(
      backgroundColor: const Color(0xFFFFF1DB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD9AFA3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, '/profile', arguments: {
            });
          },
        ),
        title: const Center(
          child: Text(
            'Edit listing',
            style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
          ),
        ),
        actions: const [
          Padding( 
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Icon(Icons.delete_outline, color: Colors.black),
                SizedBox(width: 4),
                Text("Delete listing", style: TextStyle(color: Colors.black)),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20), //padding around the body of the app
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/NUS T-Shirt.png',
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            //Text fields from add_box.dart as they are reusable
            AddInfoBox(
              controller: priceController,
              hintText: "Price",
            ),
            const SizedBox(height: 20),
            AddInfoBox(
              controller: conditionController,
              hintText: "Condition",
            ),
            const SizedBox(height: 20),
            AddInfoBox(
              controller: locationController,
              hintText: "Meet up location",
            ),
            const SizedBox(height: 20),
            AddInfoBox(
              controller: brandController,
              hintText: "Brand",
            ),
            const SizedBox(height: 20),
            AddInfoBox(
              controller: descriptionController,
              hintText: "Description",
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile', arguments: {
                  'message': 'Listing updated successfully!',
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD9AFA3),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Confirm listing"),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
