part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object?> get props => [];
}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final CharactersModel charsModel;
  const CharactersLoaded(this.charsModel);
}

class CharactersError extends CharactersState {
  final String? message;
  const CharactersError(this.message);
}
