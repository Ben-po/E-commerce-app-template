import 'package:flutter/material.dart';
import '../widgets/home_page/search_bar.dart';
import '../widgets/home_page/listing_card.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/home_page/donate.dart';
import '../widgets/home_page/recycle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0D5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD9AFA3),
        title: const Text(
          'ECO fashion',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        elevation: 0,
        leading:null, // remove back arrow 
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              SearchBarWidget(),
              SizedBox(height: 20),

              // Put the donate box and recycle box below once i make the widgets
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DonateBox(),
                  RecycleBox(),
                ],
              ),

              SizedBox(height: 20),
              ListingCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
