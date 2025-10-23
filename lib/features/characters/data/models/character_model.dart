import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'character_model.g.dart';

@collection
class CharacterModel extends Equatable {
  Id id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String location;
  final String origin;
  final DateTime created;
  
  @enumerated
  final CharacterStatus characterStatus;

  CharacterModel({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.location,
    required this.origin,
    required this.created,
    required this.characterStatus,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
      location: json['location']['name'],
      origin: json['origin']['name'],
      created: DateTime.parse(json['created']),
      characterStatus: CharacterStatus.notFavorite,
    );
  }

  CharacterModel copyWith({
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    String? image,
    String? location,
    String? origin,
    DateTime? created,
    CharacterStatus? characterStatus,
  }) {
    return CharacterModel(
      id: id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      location: location ?? this.location,
      origin: origin ?? this.origin,
      created: created ?? this.created,
      characterStatus: characterStatus ?? this.characterStatus,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        image,
        location,
        origin,
        created,
        characterStatus,
      ];
}

enum CharacterStatus {
  favorite,
  notFavorite,
}