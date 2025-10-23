import '../entities/character_entity.dart';

abstract class CharacterRepository {
  Future<List<CharacterEntity>> getCharacters(int page);
  Future<List<CharacterEntity>> searchCharacters(String query);
  Future<List<CharacterEntity>> getFavoriteCharacters();
  Future<void> toggleFavorite(CharacterEntity character);
  Future<bool> isFavorite(int characterId);
}