import 'dart:convert';

import 'package:know_me_frontend_v2/entities/jwt-response.dart';
import 'package:localstorage/localstorage.dart';

class StorageService {
  static final LocalStorage storage = LocalStorage('know-us-more');

  static bool isLoggedIn() {
    return storage.getItem('loggedIn') ?? false;
  }

  static JwtResponse? getLoggedUser() {
    var loggedUser = storage.getItem('loggedUser');

    if(loggedUser == null) {
      return null;
    }

    return JwtResponse.fromJson(jsonDecode(loggedUser));
  }

  static void setLoggedUser(String jwtResponse) {
    storage.setItem('loggedIn', true);
    storage.setItem('loggedUser', jwtResponse);
  }

  static void logOut() async {
    await storage.setItem('loggedIn', false);
    await storage.deleteItem('loggedUser');
  }
}
