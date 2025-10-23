import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTap;

  const CharacterCard({
    Key? key,
    required this.character,
    required this.onToggleFavorite,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(character.image),
          radius: 30,
        ),
        title: Text(
          character.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${character.status}'),
            Text('Species: ${character.species}'),
            Text('Gender: ${character.gender}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            character.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: character.isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: onToggleFavorite,
        ),
        onTap: onTap,
      ),
    );
  }
}