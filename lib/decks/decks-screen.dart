import 'package:flutter/material.dart';
import 'package:know_me_frontent_v2/questions/questions-screen.dart';
import 'package:know_me_frontent_v2/services/storage-service.dart';

import '../widgets/DeckCard.dart';
import '../entities/deck.dart';

class DecksScreen extends StatefulWidget {
  const DecksScreen({Key? key}) : super(key: key);

  @override
  State<DecksScreen> createState() => _DecksScreenState();
}

class _DecksScreenState extends State<DecksScreen> {
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
            children: StorageService.getLoggedUser()?.decks.map((deck) {
                  return DeckCard(
                    deck: deck,
                    onTap: _tappedDeck,
                  );
                }).toList() ??
                [],
          ),
        ),
      ),
    );
  }

  void _tappedDeck(Deck deck) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuestionsScreen(currentDeck: deck)));
  }
}
