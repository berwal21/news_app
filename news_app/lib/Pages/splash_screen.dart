import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.sizeOf(context).height * 1; // get the height of the screen
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/splash_pic.jpg',
              fit: BoxFit.cover,
              height: height * .5,
            ),
            SizedBox(height: height * 0.04),
            Text(
              'Top HEADLINES',
              style: GoogleFonts.anton(
                letterSpacing: .6,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: height * 0.04),
            SpinKitChasingDots(color: Colors.blue, size: 40),
          ], // display the splash image
        ),
      ),
    );
  }
}
