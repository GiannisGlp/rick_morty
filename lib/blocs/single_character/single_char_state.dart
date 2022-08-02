part of 'single_char_bloc.dart';

abstract class SingleCharacterState extends Equatable {
  const SingleCharacterState();

  @override
  List<Object?> get props => [];
}

class SingleCharacterInitial extends SingleCharacterState {}

class SingleCharacterLoading extends SingleCharacterState {}

class SingleCharacterLoaded extends SingleCharacterState {
  final SingleCharacterModel singleModel;
  const SingleCharacterLoaded(this.singleModel);
}

class SingleCharacterError extends SingleCharacterState {
  final String? message;
  const SingleCharacterError(this.message);
}
