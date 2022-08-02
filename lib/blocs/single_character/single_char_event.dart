part of 'single_char_bloc.dart';

abstract class SingleCharacterEvent extends Equatable {
  final String data;
  const SingleCharacterEvent(this.data);
  @override
  List<Object> get props => [data];
}

class GetSingleCharacter extends SingleCharacterEvent {
  const GetSingleCharacter(super.data);
}
