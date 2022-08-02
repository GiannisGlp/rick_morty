import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/blocs/characters/characters_bloc.dart';
import './screens/all_chars_screen.dart';
import './navigation/route_genarator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => CharactersBloc()),
      child: MaterialApp(
        title: "Rick And Morty",
        home: Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: const Text(
              "All Characters",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: AllCharsScreen(),
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
