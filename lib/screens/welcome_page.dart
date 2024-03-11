import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flash/components/Rounded_button.dart';
import 'login_page.dart';
import 'registration_page.dart';
 
class WelcomScreen extends StatefulWidget {
  const WelcomScreen({super.key});
  static String id = 'welcome_screen';

  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> with TickerProviderStateMixin{
  late AnimationController controller;
  late Animation animation;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit( // animation
                  animatedTexts: [
                    TypewriterAnimatedText(
                   'Flash Chat',
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.w900
                  ),
                  speed: const Duration(milliseconds: 250)
                )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              title: 'Log in',
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(color: Colors.blueAccent, onPressed:(){
              Navigator.pushNamed(context, RegistrationScreen.id);
            }, title: 'Register'),
          ],
        ),
      ),
    );
  }
}


