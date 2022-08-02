import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../res/single_api_repo.dart';
import "../models/single_char.model.dart";
part 'single_char_state.dart';
part 'single_char_event.dart';

class SingleCharacterBloc
    extends Bloc<SingleCharacterEvent, SingleCharacterState> {
  SingleCharacterBloc() : super(SingleCharacterInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetSingleCharacter>((event, emit) async {
      try {
        emit(SingleCharacterLoading());
        final mList = await _apiRepository.fetchSingleChar(event.data);
        emit(SingleCharacterLoaded(mList));
        if (mList.error != null) {
          emit(SingleCharacterError(mList.error));
        }
      } on NetworkError {
        emit(const SingleCharacterError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
