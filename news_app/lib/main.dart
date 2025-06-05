import 'package:flutter/material.dart';
import 'package:news_app/Pages/splash_screen.dart';

//988245b82aee4903861a574811e73a29

//headline
//GET https://newsapi.org/v2/top-headlines?country=us&apiKey=988245b82aee4903861a574811e73a29

//everything
//GET https://newsapi.org/v2/everything?q=bitcoin&apiKey=988245b82aee4903861a574811e73a29

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
