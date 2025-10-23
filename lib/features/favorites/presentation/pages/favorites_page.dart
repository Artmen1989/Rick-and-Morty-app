import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/character_entity.dart';
import '../blocs/favorite_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Characters'),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteError) {
            return Center(child: Text(state.message));
          } else if (state is FavoriteLoaded) {
            final favorites = state.favorites;
            
            if (favorites.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No favorites yet',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
            
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final character = favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(character.image),
                      radius: 25,
                    ),
                    title: Text(character.name),
                    subtitle: Text('${character.species} • ${character.status}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        context.read<FavoriteBloc>().add(RemoveFavorite(character));
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Load favorites to see them here'));
          }
        },
      ),
    );
  }
}