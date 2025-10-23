import '../models/character.dart';

class FavoriteService {
  final List<Character> _favorites = [];

  List<Character> get favorites => _favorites;

  Future<Character> toggleFavorite(Character character) async {
    final isCurrentlyFavorite = _favorites.any((fav) => fav.id == character.id);
    
    if (isCurrentlyFavorite) {
      _favorites.removeWhere((fav) => fav.id == character.id);
    } else {
      _favorites.add(character.copyWith(isFavorite: true));
    }
    
    return character.copyWith(isFavorite: !isCurrentlyFavorite);
  }

  bool isFavorite(int characterId) {
    return _favorites.any((fav) => fav.id == characterId);
  }

  Future<List<Character>> getFavoriteCharacters() async {
    return _favorites;
  }
}