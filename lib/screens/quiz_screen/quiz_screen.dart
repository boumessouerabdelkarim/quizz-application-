import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/controllers/quiz_controller.dart';
import 'package:quizz_app/widgets/custom_button.dart';
import 'package:quizz_app/widgets/progress_timer.dart';
import 'package:quizz_app/widgets/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});
  // Définition de la route de l'écran du quiz
  static const routeName = '/quiz_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Définition de la couleur de fond
      backgroundColor: const Color.fromARGB(255, 102, 96, 139),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SafeArea(
            child: GetBuilder<QuizController>(
              init: QuizController(),
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Affichage du numéro de la question et de la barre de progression du temps
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Question ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                            children: [
                              TextSpan(
                                text: controller.numberOfQuestion
                                    .round()
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              TextSpan(
                                text: '/',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              TextSpan(
                                text: controller.countOfQuestion.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        ProgressTimer(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Affichage de la carte de la question courante
                  SizedBox(
                    height: 450,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => QuestionCard(
                        questionModel: controller.questionsList[index],
                      ),
                      controller: controller.pageController,
                      itemCount: controller.questionsList.length,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
      // Bouton pour passer à la question suivante
      floatingActionButton: GetBuilder<QuizController>(
        init: QuizController(),
        builder: (controller) => CustomButton(
          onPressed: () => controller.nextQuestion(),
          text: 'Suivant',
        ),
      ),
    );
  }
}
