import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quizz_app/models/question_model.dart';
import 'package:quizz_app/screens/result_screen/result_screen.dart';
import 'package:quizz_app/screens/welcome_screen.dart';

// Contrôleur pour gérer le quiz
class QuizController extends GetxController {
  // Nom du joueur
  String name = '';
  // Liste des questions utilisées pour le quiz
  final _questions = <QuestionModel>[].obs;
  // Retourne la liste des questions utilisées pour le quiz
  List<QuestionModel> get questionsList => _questions;
  // Retourne le nombre de questions dans le quiz
  int get countOfQuestion => questionsList.length;
  // Booléen pour vérifier si la réponse a été pressée
  bool _isPressed = false;
// Retourne true si la réponse a été pressée, sinon false
  bool get isPressed => _isPressed;
  // Numéro de la question actuelle
  double _numberOfQuestion = 1;
  // Retourne le numéro de la question actuelle
  double get numberOfQuestion => _numberOfQuestion;
  // Index de la réponse sélectionnée par l'utilisateur
  int? _selectAnswer;
  // Retourne l'index de la réponse sélectionnée par l'utilisateur
  int? get selectAnswer => _selectAnswer;
  // Index de la réponse correcte à la question
  int? _correctAnswer;
  // Nombre de réponses correctes
  int _countOfCorrectAnswers = 0;
  // Retourne le nombre de réponses correctes
  int get countOfCorrectAnswers => _countOfCorrectAnswers;
  // Map pour vérifier si la question a été répondue
  final Map<int, bool> _questionIsAnswerd = {};
  // Contrôleur de page pour gérer le défilement des questions
  late PageController pageController;
  // Minuterie pour le compte à rebours
  Timer? _timer;
  // Durée maximale du compte à rebours
  final maxSec = 15;
  // Compteur de secondes avec Rx pour permettre la réactivité
  final RxInt _sec = 15.obs;
  // Retourne le compteur de secondes
  RxInt get sec => _sec;

  //fonction qui retourne 10 questions aleatoire de la liste complete des questions
  List<QuestionModel> getRandomQuestions(List<QuestionModel> questions) {
    // Mélange les questions
    questions.shuffle();
    // Prend les 10 premières questions
    final List<QuestionModel> randomQuestions = questions.sublist(0, 10);
    return randomQuestions;
  }

//fonction qui lit la liste des question a partir de fichier json
  Future<List<QuestionModel>> getQuestionsFromJson() async {
    final jsonString = await rootBundle.loadString('ressources/data.json');
    final data = await jsonDecode(jsonString) as List<dynamic>;
    final questions = data.map((questionData) {
      final options = questionData['options'].cast<String>();
      return QuestionModel(
        id: questionData['id'] as int,
        question: questionData['question'] as String,
        answer: questionData['answer'] as int,
        options: options,
      );
    }).toList();
    // Génération des questions aléatoires
    final randomQuestions = getRandomQuestions(questions);
    return randomQuestions;
  }

  @override
  void onInit() async {
    super.onInit();
      // Chargement de toutes les questions du fichier JSON
      _questions.assignAll(await getQuestionsFromJson());
    // Initialisation du contrôleur de page
    pageController = PageController(initialPage: 0);
    // Réinitialisation des réponses
    resetAnswer();
  }
  @override
  void onClose() {
    // Libération des ressources du contrôleur de page
    pageController.dispose();
    super.onClose();
  }
  // Calcul du résultat final du quiz
  double get scoreResult {
    return _countOfCorrectAnswers * 100 / questionsList.length;
  }
  // Retourne le message de résultat du quiz
  String result() {
    final score = _countOfCorrectAnswers * 100 / questionsList.length;
    if (score > 50) {
      return "Vous avez gagné !";
    } else {
      return "Vous avez perdu !";
    }
  }

  // Vérifie la réponse à une question donnée
  void checkAnswer(QuestionModel questionModel, int selectAnswer) {
    _isPressed = true;
    _selectAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;
    if (_correctAnswer == _selectAnswer) {
      _countOfCorrectAnswers++;
    }
    stopTimer();
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    update();
  }
  // Vérifie si la question a été répondue
  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }
  // Passe à la question suivante
  void nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }

    if (pageController.page == questionsList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);

      startTimer();
    }
    _numberOfQuestion = pageController.page! + 2;
    update();
  }
  // Réinitialise les réponses et les paramètres du quiz
  void resetAnswer() {
    for (var element in questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

  // Retourne la couleur en fonction de la validité de la réponse
  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Colors.red.shade700;
      }
    }
    return const Color.fromARGB(255, 70, 69, 69);
  }

  // Retourne l'icône en fonction de la validité de la réponse
  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  // Démarre le compte à rebours
  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec.value > 0) {
        _sec.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }
  // Réinitialise le compte à rebours
  void resetTimer() => _sec.value = maxSec;

  // Arrête le compte à rebours
  void stopTimer() => _timer!.cancel();

  // Réinitialise le quiz pour recommencer
  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswers = 0;
    resetAnswer();
    _selectAnswer = null;
    _numberOfQuestion = 1;
    Get.offAllNamed(WelcomeScreen.routeName);
  }
}
