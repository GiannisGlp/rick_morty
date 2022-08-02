import "package:flutter/material.dart";
import '../screens/single_char_screen.dart';
import '../screens/all_chars_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const AllCharsScreen(),
        );
      case 'singleCharScreen':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => SingleCharScreen(data: args),
          );
        }

        return _wrongRoute();

      default:
        return _wrongRoute();
    }
  }

  static Route<dynamic> _wrongRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Wrong route'),
        ),
        body: const Center(
            child: Text("Can not find or does not exist this Character")),
      );
    });
  }
}
