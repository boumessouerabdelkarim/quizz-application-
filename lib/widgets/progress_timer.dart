import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/controllers/quiz_controller.dart';

import '../constants.dart';

class ProgressTimer extends StatelessWidget {
  ProgressTimer({Key? key}) : super(key: key);

  // Récupération de l'instance du contrôleur de quiz avec Get.find
  final controller = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            // Indicateur de progression circulaire
            CircularProgressIndicator(
              value: 1 -
                  (controller.sec.value /
                      15), // Calcul de la progression en fonction du temps restant
              color: KPrimaryColor, // Couleur de la progression
              backgroundColor: Colors.grey, // Couleur de fond de l'indicateur
              strokeWidth: 8, // Épaisseur de la ligne de progression
            ),
            // Affichage du temps restant au centre de l'indicateur
            Center(
              child: Text(
                '${controller.sec.value}', // Valeur du temps restant
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: KPrimaryColor, // Couleur du texte
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
