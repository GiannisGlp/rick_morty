import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import "../blocs/models/all_chars_model.dart";
import "../blocs/characters/characters_bloc.dart";
import '../layout/custom_text.dart';
import '../layout/loading_indicator.dart';

class AllCharsScreen extends StatefulWidget {
  const AllCharsScreen({Key? key}) : super(key: key);

  @override
  _AllCharsScreenState createState() => _AllCharsScreenState();
}

class _AllCharsScreenState extends State<AllCharsScreen> {
  final CharactersBloc _newsBloc = CharactersBloc();

  @override
  void initState() {
    _newsBloc.add(GetCharacters());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildListChars(),
    );
  }

  aliveColor(String status) {
    if (status == "Alive") {
      return Colors.green;
    }
    if (status == "Dead") {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  Widget _buildListChars() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<CharactersBloc, CharactersState>(
          listener: (context, state) {
            if (state is CharactersError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<CharactersBloc, CharactersState>(
            builder: (context, state) {
              if (state is CharactersInitial) {
                return const LoadingIndicator();
              } else if (state is CharactersLoading) {
                return const LoadingIndicator();
              } else if (state is CharactersLoaded) {
                return _buildCard(context, state.charsModel);
              } else if (state is CharactersError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CharactersModel model) {
    return ListView.builder(
        itemCount: model.results!.length,
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              children: [
                Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "singleCharScreen",
                        arguments: model.results![index].url as String,
                      );
                    },
                    child: Image.network(
                      height: 150,
                      width: 150,
                      model.results![index].image as String,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 8, right: 4, bottom: 8),
                  alignment: Alignment.topLeft,
                  height: 150,
                  width: 216,
                  decoration: const BoxDecoration(color: Color(0xFF202428)),
                  child: Wrap(
                    children: <Widget>[
                      // Title
                      Wrap(children: [
                        InkWell(
                          // width: 210,
                          onTap: () {
                            Navigator.of(context).pushNamed("singleCharScreen",
                                arguments: model.results![index].url as String);
                          },
                          child: CustomText(
                            text: model.results![index].name as String,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          width: 210,
                          child: Wrap(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.only(
                                  top: 5,
                                ),
                                decoration: BoxDecoration(
                                    color: aliveColor(
                                        model.results![index].status as String),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 5,
                                ),
                                child: CustomText(
                                  text:
                                      "${model.results![index].status as String} - ${model.results![index].species as String}",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),

                      // Second Line
                      Wrap(children: [
                        Container(
                          width: 210,
                          margin: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: const CustomText(
                              text: "Last Seen Location:", color: Colors.grey),
                        ),
                        Container(
                          width: 210,
                          child: Wrap(
                            children: [
                              Container(
                                child: CustomText(
                                  text: model.results![index].location?.name
                                      as String,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),

                      //Third Line
                      Wrap(children: [
                        Container(
                          width: 210,
                          margin: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: const CustomText(
                              text: "First Seen In:", color: Colors.grey),
                        ),
                        Container(
                          width: 210,
                          child: Wrap(
                            children: [
                              Container(
                                child: CustomText(
                                  text: model.results![index].firstEpisode?.name
                                      as String,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
