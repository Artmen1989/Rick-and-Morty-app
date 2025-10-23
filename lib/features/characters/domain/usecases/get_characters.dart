import '../entities/character_entity.dart';

abstract class GetCharacters {
  Future<List<CharacterEntity>> call(int page);
}

class GetCharactersImpl implements GetCharacters {
  @override
  Future<List<CharacterEntity>> call(int page) async {
    // Реализация будет в data слое
    throw UnimplementedError('GetCharactersImpl not implemented');
  }
}