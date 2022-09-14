import 'package:know_me_frontent_v2/entities/question.dart';

class Deck {
  final int id;
  final String secretId;
  final String name;
  final List<Question> questions;

  const Deck({
    required this.id,
    required this.secretId,
    required this.name,
    required this.questions,
  });

  factory Deck.fromJson(Map<String, dynamic> json) {
    return Deck(
      id: json['id'],
      secretId: json['secretId'],
      name: json['name'],
      questions: (json['questions'] as List)
          .map((question) => Question.fromJson(question))
          .toList(),
    );
  }
}