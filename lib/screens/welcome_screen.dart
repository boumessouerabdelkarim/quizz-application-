import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/controllers/quiz_controller.dart';
import 'package:quizz_app/screens/quiz_screen/quiz_screen.dart';
import 'package:quizz_app/widgets/custom_button.dart';
import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  // Définition de la route de l'écran d'accueil
  static const routeName = '/welcome_screen';
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Contrôleur pour le champ de texte du nom
  final _nameController = TextEditingController();
  // Clé pour le formulaire
  final GlobalKey<FormState> _formkey = GlobalKey();
  // Méthode pour soumettre le formulaire
  void _submit(context) {
    // Fermer le clavier virtuel
    FocusScope.of(context).unfocus();
    // Valider le formulaire
    if (!_formkey.currentState!.validate()) return;
    // Sauvegarder les données du formulaire
    _formkey.currentState!.save();
    // Passer à l'écran du quiz
    Get.offAndToNamed(QuizScreen.routeName);
    // Démarrer le minuteur dans le contrôleur du quiz
    Get.find<QuizController>().startTimer();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [KPrimaryColor, kSecondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  // Titre de l'écran d'accueil
                  Text(
                    'Commençons le Quiz',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(flex: 2),
                  // Message demandant à l'utilisateur d'entrer son nom
                  Text(
                    'Entrez votre nom pour commencer',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(flex: 1),
                  // Champ de texte pour le nom de l'utilisateur
                  Form(
                    key: _formkey,
                    child: GetBuilder<QuizController>(
                      init: Get.find<QuizController>(),
                      builder: (controller) => TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Nom Complet',
                          labelStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'Le nom ne doit pas être vide';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? val) {
                          controller.name = val!.trim().toUpperCase();
                        },
                        onFieldSubmitted: (_) => _submit(context),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  // Bouton pour commencer le quiz
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      width: double.infinity,
                      onPressed: () => _submit(context),
                      text: 'Commençons le Quiz',
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
