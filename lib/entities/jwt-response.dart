import 'dart:convert';

import 'deck.dart';

class JwtResponse {
  final String accessToken;
  final String tokenType;
  final int id;
  String username;
  String email;
  List<String> roles;
  List<Deck> decks;

  JwtResponse({
    required this.accessToken,
    required this.tokenType,
    required this.id,
    required this.username,
    required this.email,
    this.roles = const [],
    this.decks = const [],
  });

  factory JwtResponse.empty() {
    return JwtResponse(accessToken: "", tokenType: "", id: -1, username: "", email: "", roles: [], decks: []);
  }

  factory JwtResponse.fromJson(Map<String, dynamic> json) {
    List<String>? _roles;
    List<Deck>? _decks;

    if (json['roles'] != null) {
      var roleObjsJson = json['roles'] as List;
      _roles = roleObjsJson.map((roleTag) => roleTag.toString()).toList();
    }
    if (json['decks'] != null) {
      var deckObjsJson = json['decks'] as List;
      _decks = deckObjsJson.map((deckTag) => Deck.fromJson(deckTag)).toList();
    }

    if (_roles != null && _decks != null) {
      return JwtResponse(
          accessToken: json['accessToken'] as String,
          tokenType: json['tokenType'] as String,
          id: json['id'] as int,
          username: json['username'] as String,
          email: json['email'] as String,
          roles: _roles,
          decks: _decks);
    } else if (_roles != null) {
      return JwtResponse(
          accessToken: json['accessToken'] as String,
          tokenType: json['tokenType'] as String,
          id: json['id'] as int,
          username: json['username'] as String,
          email: json['email'] as String,
          roles: _roles);
    } else {
      return JwtResponse(
          accessToken: json['accessToken'] as String,
          tokenType: json['tokenType'] as String,
          id: json['id'] as int,
          username: json['username'] as String,
          email: json['email'] as String,
          decks: _decks!);
    }
  }

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'tokenType': tokenType,
        'id': id,
        'username': username,
        'email': email,
        'roles': jsonEncode(roles.map((role) => role).toList()),
        'decks': jsonEncode(decks.map((deck) => deck.toJson()).toList()),
      };
}
