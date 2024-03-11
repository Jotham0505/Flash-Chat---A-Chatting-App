import 'package:flash/firebase_options.dart';
import 'package:flash/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flash/screens/login_page.dart';
import 'package:flash/screens/registration_page.dart';
import 'package:flash/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      runApp( const MyApp());  

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomScreen.id,
      routes: {
        WelcomScreen.id:(context) => const WelcomScreen(),
        LoginScreen.id:(context) => const LoginScreen(),
        RegistrationScreen.id:(context) => const RegistrationScreen(),
        ChatScreen.id:(context) => const ChatScreen(),
      },
    );
  }
}

