import 'deck.dart';

class JwtResponse {
  final String accessToken;
  final String tokenType;
  final int id;
  final String username;
  final String email;
  final List<String> roles;
  final List<Deck> decks;

  const JwtResponse({
    required this.accessToken,
    required this.tokenType,
    required this.id,
    required this.username,
    required this.email,
    required this.roles,
    required this.decks,
  });

  factory JwtResponse.fromJson(Map<String, dynamic> json) {
   return JwtResponse(
      accessToken: json['accessToken'],
      tokenType: json['tokenType'],
      id: json['id'],
      username: json['username'],
      email: json['email'],
      roles: (json['roles'] as List)
          .map((role) => role.toString())
          .toList(),
      decks: (json['decks'] as List)
          .map((deck) => Deck.fromJson(deck))
          .toList(),
    );
  }
}