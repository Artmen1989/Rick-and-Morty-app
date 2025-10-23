part of 'character_bloc.dart';

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {
  final List<dynamic> previousCharacters;
  final bool isFirstFetch;
  
  CharacterLoading(this.previousCharacters, {this.isFirstFetch = false});
}

class CharacterLoaded extends CharacterState {
  final List<dynamic> characters;
  final bool hasReachedMax;
  
  CharacterLoaded(this.characters, {this.hasReachedMax = false});
}

class CharacterError extends CharacterState {
  final String message;
  
  CharacterError(this.message);
}