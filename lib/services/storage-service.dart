import 'dart:convert';

import 'package:know_me_frontent_v2/entities/jwt-response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool('loggedIn') ?? false;
  }

  static Future<JwtResponse?> getLoggedUser() async {
    final prefs = await SharedPreferences.getInstance();

    if(prefs.getString('loggedUser') == null) {
      return null;
    }

    return JwtResponse.fromJson(jsonDecode(prefs.getString('loggedUser') as String));
  }

  static Future<void> setLoggedUser(String jwtResponse) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('loggedIn', true);
    await prefs.setString('loggedUser', jwtResponse);
  }
}
