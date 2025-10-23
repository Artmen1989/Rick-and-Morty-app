import '../models/character.dart';

class ApiService {
  Future<List<Character>> getCharacters(int page) async {
    // Имитация API запроса
    await Future.delayed(const Duration(seconds: 2));
    
    // Временные данные для демонстрации
    return [
      Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      ),
      Character(
        id: 2,
        name: "Morty Smith", 
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
      ),
      Character(
        id: 3,
        name: "Summer Smith",
        status: "Alive", 
        species: "Human",
        type: "",
        gender: "Female",
        image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
      ),
    ];
  }

  Future<List<Character>> searchCharacters(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    final allCharacters = await getCharacters(1);
    return allCharacters
        .where((character) => character.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}