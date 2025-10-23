import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter.bloc.dart';
import '../../characters/presentation/widgets/character_card.dart';
import '../../characters/domain/entities/character_entity.dart';
import '../blocs/favorite_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String _sortBy = 'name';

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Characters'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _sortBy = value;
              });
              context.read<FavoriteBloc>().add(SortFavorites(by: value));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'name', child: Text('Sort by Name')),
              const PopupMenuItem(value: 'status', child: Text('Sort by Status')),
            ],
          ),
        ],
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteLoaded) {
            if (state.characters.isEmpty) {
              return const Center(
                child: Text('No favorite characters yet'),
              );
            }
            return ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                return CharacterCard(character: state.characters[index]);
              },
            );
          } else if (state is FavoriteError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}