import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:part2_benjaminpo_2404190g_p06/firebase_options.dart';
import 'package:part2_benjaminpo_2404190g_p06/firebase_service.dart';
import 'package:part2_benjaminpo_2404190g_p06/screens/Authentication/sign_up.dart';
import 'screens/Authentication/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_listing.dart';
import 'screens/profile_screen.dart';
import 'screens/edit_screen.dart'; //This is used for the navigaion of the app



void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures that the Flutter engine is initialized before running the app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initializes Firebase
  GetIt.instance.registerLazySingleton(() => FirebaseService()); // Registers FirebaseService as a singleton in GetIt
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //navigation 
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/add': (context) => AddListingScreen(),
        '/profile': (context) => ProfileScreen(),
        '/edit': (context) => const EditScreen(),
        '/SignUp': (context) => const SignUp(),
      },
    );
  }
}


