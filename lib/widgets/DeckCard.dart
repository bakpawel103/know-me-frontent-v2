import 'package:flutter/material.dart';

import '../entities/deck.dart';

class DeckCard extends StatelessWidget {
  const DeckCard({Key? key, required this.deck, required this.onTap})
      : super(key: key);

  final Deck deck;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      width: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.red,
      ),
      child: InkWell(
        child: Center(
          child: Text(
            deck.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
          onTap(deck);
        },
      ),
    );
  }
}
