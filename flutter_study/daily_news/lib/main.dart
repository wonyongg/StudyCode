import 'package:daily_news/screen/DetailScreen.dart';
import 'package:daily_news/screen/MainScreen.dart';
import 'package:daily_news/screen/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily News',
      routes: {
        '/' : (context) => SplashScreen(),
        '/main' : (context) => MainScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          dynamic newsItem = settings.arguments as dynamic;
          
          return MaterialPageRoute(builder: (context) {
            return DetailScreen(newsItem: newsItem);
          },);
        }
        return null;
      },
    );
  }
}