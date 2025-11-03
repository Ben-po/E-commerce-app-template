import 'package:flutter/material.dart';
import 'package:part2_benjaminpo_2404190g_p06/widgets/profile_page/current_listings.dart';
import 'package:part2_benjaminpo_2404190g_p06/widgets/profile_page/profile_info_box.dart';
import '../widgets/bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1DB),
      //Appbar is the thing at the top of the screen
      appBar: AppBar( 
        backgroundColor: const Color(0xFFD9A5A5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        title: const Text('ECO fashion'),
        centerTitle: true,
      ),

      //makes the main body of the app scrollable
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ProfileInfoBox(),
            SizedBox(height: 20),
            CurrentListingsBox(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}

