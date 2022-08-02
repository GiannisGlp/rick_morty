import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import "../blocs/models/single_char.model.dart";
import "../blocs/single_character/single_char_bloc.dart";
import '../layout/loading_indicator.dart';
import '../layout/custom_text.dart';

class SingleCharScreen extends StatefulWidget {
  final String data;
  const SingleCharScreen({Key? key, required this.data}) : super(key: key);

  @override
  SingleCharScreenState createState() => SingleCharScreenState();
}

class SingleCharScreenState extends State<SingleCharScreen> {
  final SingleCharacterBloc _newsBloc = SingleCharacterBloc();

  @override
  void initState() {
    _newsBloc.add(GetSingleCharacter(widget.data));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildSingleChar(),
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

  typeDisplay(String text) {
    if (text == "") {
      return "None";
    } else {
      return text;
    }
  }

  Widget _buildSingleChar() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<SingleCharacterBloc, SingleCharacterState>(
          listener: (context, state) {
            if (state is SingleCharacterError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<SingleCharacterBloc, SingleCharacterState>(
            builder: (
              context,
              state,
            ) {
              if (state is SingleCharacterInitial) {
                return const LoadingIndicator();
              } else if (state is SingleCharacterLoading) {
                return const LoadingIndicator();
              } else if (state is SingleCharacterLoaded) {
                return _buildCard(context, state.singleModel);
              } else if (state is SingleCharacterError) {
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

  Widget _buildCard(
    BuildContext context,
    SingleCharacterModel model,
  ) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: CustomText(
          text: "${model.name}",
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: 600,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color(0xFF202428),
        ),
        child: Column(
          children: <Widget>[
            Image.network(
              model.image as String,
              width: 400,
              height: 300,
              fit: BoxFit.fill,
            ),
            Wrap(children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Wrap(
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          color: aliveColor(model.status as String),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 5,
                      ),
                      child: CustomText(
                        text: "${model.status} - ${model.species}",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: CustomText(
                text: typeDisplay(model.type as String),
                fontSize: 16,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: CustomText(
                text: model.gender ?? 'Unknown',
                fontSize: 16,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: CustomText(
                text: model.location?.name ?? 'Unknown',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
