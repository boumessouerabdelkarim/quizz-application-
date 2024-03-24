import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/controllers/quiz_controller.dart';

class AnswerOption extends StatelessWidget {
  const AnswerOption({
    Key? key,
    required this.text,
    required this.index,
    required this.questionId,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final int index;
  final int questionId;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: Get.find<QuizController>(),
      builder: (controller) => InkWell(
        // Désactive l'interaction si la question a déjà été répondue
        onTap:
            controller.checkIsQuestionAnswered(questionId) ? null : onPressed,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: controller.getColor(index)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    // Affiche le numéro de l'option suivi du texte de l'option
                    text: '${index + 1}. ',
                    style: Theme.of(context).textTheme.headlineSmall,
                    children: [
                      TextSpan(
                        text: text,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                // Affiche une icône si l'option a été sélectionnée et la question a été répondue
                if (controller.checkIsQuestionAnswered(questionId) &&
                    controller.selectAnswer == index)
                  Container(
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.getColor(index),
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      controller.getIcon(index),
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
