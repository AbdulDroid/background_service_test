import 'package:flutter/material.dart';
import '../../ui/homescreen/homescreen.dart';
import '../../ui/login/loginscreen.dart';
import '../../ui/signup/signupscreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.HOME:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.LOGIN:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Routes.SIGNUP:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child:
                        Text("No screen implementation for ${settings.name}"),
                  ),
                ));
    }
  }
}

abstract class Routes {
  static const HOME = "homeScreen";
  static const LOGIN = "login";
  static const SIGNUP = "signup";
}
