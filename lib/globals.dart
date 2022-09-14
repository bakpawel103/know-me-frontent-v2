library globals;

import 'package:know_me_frontent_v2/entities/jwt-response.dart';

const String baseApiUri = 'https://know-me-backend.herokuapp.com/';
bool loggedIn = false;
late JwtResponse loggedInUser;
