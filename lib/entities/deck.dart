import 'dart:convert';

import 'package:know_me_frontent_v2/entities/question.dart';

class Deck {
  final String secretId;
  String name;
  List<Question> questions;

  Deck({
    required this.secretId,
    required this.name,
    this.questions = const [],
  });

  factory Deck.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      var questionObjsJson = json['questions'] as List;
      List<Question> _questions = questionObjsJson
          .map((questionTag) => Question.fromJson(questionTag))
          .toList();

      return Deck(
          secretId: json['secretId'] as String,
          name: json['name'] as String,
          questions: _questions);
    } else {
      return Deck(
        secretId: json['secretId'] as String,
        name: json['name'] as String,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        'secretId': secretId,
        'name': name,
        'questions':
            jsonEncode(questions.map((question) => question.toJson()).toList()),
      };
}
