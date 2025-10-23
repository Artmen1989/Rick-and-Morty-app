import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/character_entity.dart';

// Events
abstract class FavoriteEvent {}

class LoadFavorites extends FavoriteEvent {}

class RemoveFavorite extends FavoriteEvent {
  final CharacterEntity character;
  
  RemoveFavorite(this.character);
}

// States
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<CharacterEntity> favorites;
  
  FavoriteLoaded(this.favorites);
}

class FavoriteError extends FavoriteState {
  final String message;
  
  FavoriteError(this.message);
}

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<RemoveFavorite>(_onRemoveFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      emit(FavoriteLoading());
      
      // Временные данные для демонстрации
      await Future.delayed(const Duration(seconds: 1));
      final favorites = [
        CharacterEntity(
          id: 1,
          name: "Rick Sanchez",
          status: "Alive",
          species: "Human",
          type: "",
          gender: "Male",
          image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
          isFavorite: true,
        ),
      ];
      
      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(FavoriteError('Failed to load favorites: ${e.toString()}'));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      if (state is FavoriteLoaded) {
        final currentState = state as FavoriteLoaded;
        final updatedFavorites = currentState.favorites
            .where((fav) => fav.id != event.character.id)
            .toList();
        
        emit(FavoriteLoaded(updatedFavorites));
      }
    } catch (e) {
      emit(FavoriteError('Failed to remove favorite: ${e.toString()}'));
    }
  }
}