import 'package:flutter/foundation.dart';

class FavoriteService {
  static const String _favoritesKey = 'favorite_characters';

  Future<void> toggleFavorite(int characterId) async {
    if (kIsWeb) {
      // Для веба используем localStorage
      _toggleFavoriteWeb(characterId);
    } else {
      // Для мобильных используем SharedPreferences
      _toggleFavoriteMobile(characterId);
    }
  }

  Future<void> _toggleFavoriteWeb(int characterId) async {
    // Простая реализация для веба с localStorage
    final favorites = await getFavorites();
    
    if (favorites.contains(characterId)) {
      favorites.remove(characterId);
    } else {
      favorites.add(characterId);
    }
    
    // Сохраняем в localStorage
    if (favorites.isNotEmpty) {
      final favoritesString = favorites.join(',');
      // Используем dart:js для доступа к localStorage
      _saveToLocalStorage(favoritesString);
    } else {
      _saveToLocalStorage('');
    }
  }

  Future<void> _toggleFavoriteMobile(int characterId) async {
    // Для мобильных устройств
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    
    if (favorites.contains(characterId)) {
      favorites.remove(characterId);
    } else {
      favorites.add(characterId);
    }
    
    await prefs.setStringList(
      _favoritesKey, 
      favorites.map((id) => id.toString()).toList(),
    );
  }

  Future<List<int>> getFavorites() async {
    if (kIsWeb) {
      return _getFavoritesWeb();
    } else {
      return _getFavoritesMobile();
    }
  }

  Future<List<int>> _getFavoritesWeb() async {
    try {
      final favoritesString = _getFromLocalStorage();
      if (favoritesString.isEmpty) return [];
      
      return favoritesString
          .split(',')
          .where((id) => id.isNotEmpty)
          .map((id) => int.parse(id))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<int>> _getFavoritesMobile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesList = prefs.getStringList(_favoritesKey) ?? [];
      return favoritesList.map((id) => int.parse(id)).toList();
    } catch (e) {
      return [];
    }
  }

  // Заглушки для localStorage (в реальном проекте используйте package:js)
  String _getFromLocalStorage() {
    // Временная заглушка
    return '';
  }

  void _saveToLocalStorage(String value) {
    // Временная заглушка
  }
}