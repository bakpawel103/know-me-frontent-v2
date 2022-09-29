import 'package:flutter/material.dart';

import '../entities/deck.dart';
import '../entities/jwt-response.dart';
import '../entities/question.dart';
import '../services/storage-service.dart';
import '../widgets/QuestionCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../globals.dart' as globals;
import 'package:know_me_frontend_v2/services/snackbar-service.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key, required this.currentDeck}) : super(key: key);

  final Deck currentDeck;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 10,
            runSpacing: 10,
            direction: Axis.horizontal,
            children: widget.currentDeck.questions.map((question) {
              return QuestionCardPage(
                question: question,
                onTap: _tappedQuestion,
              );
            }).toList() ?? [],
          ),
        ),
      ),
    );
  }

  Future _tappedQuestion(Question question) async {
    JwtResponse? loggedUser = StorageService.getLoggedUser();

    if (loggedUser == null) {
      return;
    }

    question.answered = !question.answered;

    var url = '${globals.baseApiUri}api/v1/questions/${question.id}';

    var response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${loggedUser.accessToken}',
      },
      body: json.encode(question),
    );

    if (response.statusCode != 200) {
      question.answered = !question.answered;
      SnackBarService.showSnackBar(
          context,
          "There is an error to flip card... Please try again later",
          Colors.red);
    }
  }
}