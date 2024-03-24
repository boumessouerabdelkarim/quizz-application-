import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/screens/quiz_screen/quiz_screen.dart';
import 'package:quizz_app/screens/result_screen/result_screen.dart';
import 'package:quizz_app/screens/welcome_screen.dart';
import 'package:quizz_app/util/bindings_app.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BilndingsApp(),
      title: 'Flutter Quiz App',
      // Page d'accueil de l'application
      home: WelcomeScreen(),
      // Définition des routes de l'application
      getPages: [
        GetPage(name: WelcomeScreen.routeName, page: () => WelcomeScreen()),
        GetPage(name: QuizScreen.routeName, page: () => QuizScreen()),
        GetPage(name: ResultScreen.routeName, page: () => ResultScreen()),
      ],
    );
  }
}
