import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/character_entity.dart';
import '../../../domain/usecases/get_characters.dart';
import '../../../domain/usecases/toggle_favorite.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharacters getCharacters;
  final ToggleFavorite toggleFavorite;
  
  CharacterBloc({
    required this.getCharacters,
    required this.toggleFavorite,
  }) : super(CharacterInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharacterState> emit,
  ) async {
    try {
      final currentState = state;
      
      if (event.isRefresh) {
        emit(CharacterLoading([]));
      } else if (currentState is CharacterLoaded) {
        if (currentState.hasReachedMax) return;
        emit(CharacterLoading(currentState.characters));
      } else {
        emit(CharacterLoading([]));
      }

      // Здесь будет реальный вызов API
      await Future.delayed(const Duration(seconds: 2)); // Имитация загрузки
      
      // Временные данные для демонстрации
      final newCharacters = [
        CharacterEntity(
          id: 1,
          name: "Rick Sanchez",
          status: "Alive",
          species: "Human",
          type: "",
          gender: "Male",
          image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        ),
        CharacterEntity(
          id: 2,
          name: "Morty Smith",
          status: "Alive",
          species: "Human",
          type: "",
          gender: "Male",
          image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        ),
      ];

      emit(CharacterLoaded(newCharacters));
      
    } catch (e) {
      emit(CharacterError('Failed to load characters: ${e.toString()}'));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<CharacterState> emit,
  ) async {
    try {
      if (state is CharacterLoaded) {
        final currentState = state as CharacterLoaded;
        final updatedCharacter = await toggleFavorite(event.character);
        
        final updatedCharacters = currentState.characters.map((character) {
          return character.id == updatedCharacter.id ? updatedCharacter : character;
        }).toList();

        emit(currentState.copyWith(characters: updatedCharacters));
      }
    } catch (e) {
      emit(CharacterError('Failed to toggle favorite: ${e.toString()}'));
    }
  }
}