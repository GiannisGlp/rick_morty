import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../res/chars_api_repo.dart';
import "../models/all_chars_model.dart";

part 'characters_state.dart';
part 'characters_event.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc() : super(CharactersInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetCharacters>((event, emit) async {
      try {
        emit(CharactersLoading());
        final mList = await _apiRepository.fetchCharsList();
        emit(CharactersLoaded(mList));
        if (mList.error != null) {
          emit(CharactersError(mList.error));
        }
      } on NetworkError {
        emit(const CharactersError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
