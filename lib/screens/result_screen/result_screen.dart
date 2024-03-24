import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/controllers/quiz_controller.dart';
import 'package:quizz_app/widgets/custom_button.dart';
import '../../constants.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  // Définition de la route de l'écran de résultat
  static const routeName = '/result_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fond dégradé pour l'écran de résultat
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [KPrimaryColor, kSecondaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: GetBuilder<QuizController>(
              init: Get.find<QuizController>(),
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Affichage du résultat du quiz (gagné ou perdu)
                  Text(
                    controller.result(),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 50),
                  // Affichage du nom de l'utilisateur
                  Text(
                    controller.name,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: KPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 30),
                  // Message indiquant le score obtenu
                  Text(
                    'Ton score est',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 30),
                  // Affichage du score
                  Text(
                    '${controller.scoreResult.round()} /100',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: KPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 30),
                  // Bouton pour recommencer le quiz
                  CustomButton(
                    width: 200,
                    onPressed: () => controller.startAgain(),
                    text: 'Recommencer',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
