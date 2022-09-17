import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:know_me_frontent_v2/login/login-screen.dart';
import 'package:know_me_frontent_v2/services/storage-service.dart';
import 'package:flip_card/flip_card.dart';

import 'entities/deck.dart';
import 'entities/question.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: FutureBuilder<bool>(
        future: StorageService.isLoggedIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return const HomePage();
          } else {
            return const LoginWidget();
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> cards = <Widget>[];
  List<Widget> questions = <Widget>[];
  Deck? currentDeck;

  @override
  Widget build(BuildContext context) {
    _loadDecks();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Decks"),
      ),
      body: getCurrentList(),
    );
  }

  Widget getCurrentList() {
    if (currentDeck == null) {
      return LayoutBuilder(builder: (context, constraints) {
        return GridView.count(
          primary: false,
          crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(20),
          children: cards,
        );
      });
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        return GridView.count(
          primary: false,
          crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(20),
          children: questions,
        );
      });
    }
  }

  void _loadDecks() {
    List<Widget> _cards = <Widget>[];

    StorageService.getLoggedUser().then((value) {
      if (value == null) {
        return;
      }

      for (Deck deck in value.decks) {
        _cards.add(generateDeckCard(deck));
      }

      setState(() {
        cards = _cards;
      });
    });
  }

  Card generateDeckCard(Deck deck) {
    return Card(
      elevation: 2.0,
      color: Colors.white,
      child: InkWell(
        highlightColor: Colors.white.withAlpha(30),
        splashColor: Colors.white.withAlpha(20),
        child: Center(
          child: Text(
            deck.name,
            textAlign: TextAlign.center,
          ),
        ),
        onTap: () {
          _tappedDeck(deck);
        },
      ),
    );
  }

  _tappedDeck(Deck deck) {
    setState(() {
      currentDeck = deck;
    });

    _loadQuestions();
  }

  void _loadQuestions() {
    List<Widget> _questions = <Widget>[];

    for (Question question in currentDeck!.questions) {
      _questions.add(generateQuestionCard(question));
    }

    setState(() {
      questions = _questions;
    });
  }

  Card generateQuestionCard(Question question) {
    return Card(
      elevation: 0.0,
      color: Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1000,
        onFlipDone: (status) {
          print(status);
        },
        front: Container(
          decoration: BoxDecoration(
            color: Color(0xFF006666),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(question.name),
            ],
          ),
        ),
        back: Container(
          decoration: BoxDecoration(
            color: Color(0xFF006666),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(question.description),
            ],
          ),
        ),
      ),
    );
  }
}
