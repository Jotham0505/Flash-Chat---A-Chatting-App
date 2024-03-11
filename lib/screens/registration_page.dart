import 'package:flash/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash/components/Rounded_button.dart';
import 'package:flash/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email')
              ),
              const SizedBox(
                height: 8,
              ),TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password =value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password')
              ),
              const SizedBox(
                height: 24,
              ),
              RoundedButton(
                  color: Colors.blueAccent,
                  onPressed: () async{
                    setState(() {
                      showSpinner =true;
                    });
                  try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    
                    catch (e) {
                      print(e);
                    }
                   setState(() {
                     showSpinner = false;
                   });
                  },
                  title: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}