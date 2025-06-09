import 'package:flutter/material.dart';
import 'package:news_app/Pages/splash_screen.dart';



//headline
//GET https://newsapi.org/v2/top-headlines?country=us&apiKey= get it from news api.org
//everything
//GET https://newsapi.org/v2/everything?q=bitcoin&apiKey=

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
