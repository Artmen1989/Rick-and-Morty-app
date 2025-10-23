import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/character_bloc.dart';
import '../services/api_service.dart';
import '../services/favorite_service.dart';
import '../widgets/character_card.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final ApiService _apiService = ApiService();
  final FavoriteService _favoriteService = FavoriteService();
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    // Загружаем персонажей при инициализации
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharacterBloc>().add(LoadCharacters());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Characters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<CharacterBloc>().add(LoadCharacters(isRefresh: true));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search characters...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Можно добавить поиск позже
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                if (state is CharacterInitial) {
                  return const Center(child: Text('Pull to load characters'));
                } else if (state is CharacterLoading && state.isFirstFetch) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CharacterError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CharacterBloc>().add(LoadCharacters());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (state is CharacterLoaded) {
                  final characters = state.characters;
                  
                  if (characters.isEmpty) {
                    return const Center(child: Text('No characters found'));
                  }
                  
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<CharacterBloc>().add(LoadCharacters(isRefresh: true));
                    },
                    child: ListView.builder(
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        final character = characters[index];
                        return CharacterCard(
                          character: character,
                          onToggleFavorite: () async {
                            final updatedCharacter = await _favoriteService.toggleFavorite(character);
                            // Обновляем состояние в bloc
                            // context.read<CharacterBloc>().add(ToggleFavoriteEvent(updatedCharacter));
                          },
                          onTap: () {
                            // Навигация к деталям персонажа
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(character.name),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(character.image),
                                    const SizedBox(height: 16),
                                    Text('Status: ${character.status}'),
                                    Text('Species: ${character.species}'),
                                    Text('Gender: ${character.gender}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}