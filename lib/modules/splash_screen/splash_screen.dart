
import 'package:animate_do/animate_do.dart';
import 'package:evently/core/app_colors.dart';
import 'package:evently/modules/onboarding/start_screen.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3000),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> StartScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ThemeData theme=Theme.of(context);
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Expanded(child: Center(child: ZoomIn(
               duration: Duration(milliseconds: 800),
                 child: Hero(tag: "logo",
                 child: Image.asset("assets/images/logo/evently.png",color: theme.primaryColor,))))),
            FadeInUp(
              duration: Duration(milliseconds: 600),
                delay: Duration(milliseconds: 800),
                child: Image.asset("assets/images/logo/Logo (1).png"))
            ],
          ),
        ),
      ),
    );
  }
}
