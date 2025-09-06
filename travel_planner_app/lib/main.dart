import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/login_page.dart';
import 'pages/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? user = FirebaseAuth.instance.currentUser;

  runApp(MyApp(isLoggedIn: user != null, userEmail: user?.email));
}
class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userEmail;

  const MyApp({super.key, required this.isLoggedIn, this.userEmail});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn && userEmail != null
          ? WelcomePage(email: userEmail!)
          : LoginPage(),
    );
  }
}
