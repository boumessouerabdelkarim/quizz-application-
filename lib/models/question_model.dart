
// Définition de la classe QuestionModel
class QuestionModel {
  final int id, answer; // Identifiant de la question et index de la réponse correcte
  final String question; // Texte de la question
  final List<String> options; // Liste des options de réponse

  // Constructeur de la classe QuestionModel
  QuestionModel({
    required this.id, // Identifiant de la question
    required this.question, // Texte de la question
    required this.answer, // Index de la réponse correcte
    required this.options, // Liste des options de réponse
  });
}
 