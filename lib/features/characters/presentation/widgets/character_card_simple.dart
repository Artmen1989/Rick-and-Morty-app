import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/character_bloc.dart';
import '../../../domain/entities/character_entity.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                character.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Status: ${character.status}'),
                  Text('Species: ${character.species}'),
                  Text('Location: ${character.location}'),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                character.isFavorite ? Icons.star : Icons.star_border,
                color: character.isFavorite ? Colors.amber : null,
              ),
              onPressed: () {
                context.read<CharacterBloc>().add(
                  ToggleFavoriteEvent(character: character),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}