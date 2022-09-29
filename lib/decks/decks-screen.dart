import 'package:flutter/material.dart';
import 'package:know_me_frontend_v2/questions/questions-screen.dart';
import 'package:know_me_frontend_v2/services/storage-service.dart';
import 'package:know_me_frontend_v2/services/snackbar-service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../entities/jwt-response.dart';
import '../entities/question.dart';
import '../widgets/DeckCard.dart';
import '../entities/deck.dart';
import '../globals.dart' as globals;
import '../widgets/QuestionCard.dart';

class DecksScreen extends StatefulWidget {
  const DecksScreen({Key? key}) : super(key: key);

  @override
  State<DecksScreen> createState() => _DecksScreenState();
}

class _DecksScreenState extends State<DecksScreen> {
  Deck? currentDeck;

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
            children: getContent(),
          ),
        ),
      ),
    );
  }

  getContent() {
    List<Widget> result = [];

    if(currentDeck == null) {
      StorageService.getLoggedUser()?.decks.forEach((deck) {
        result.add(DeckCard(
          deck: deck,
          onTap: _tappedDeck,
        ));
      });
    } else {
      currentDeck!.questions.forEach((question) {
        result.add(QuestionCardPage(
          question: question,
          onTap: _tappedQuestion,
        ));
      });
    }

    return result;
  }

  void _tappedDeck(Deck deck) {
    setState(() {
      currentDeck = deck;
    });
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
