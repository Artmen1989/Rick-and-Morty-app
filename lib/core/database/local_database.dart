import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/characters/data/models/character_model.dart';

class LocalDatabase {
  static Isar? _isar;

  static Future<Isar> get instance async {
    if (_isar != null) return _isar!;
    
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [CharacterModelSchema],
      directory: dir.path,
    );
    return _isar!;
  }
}