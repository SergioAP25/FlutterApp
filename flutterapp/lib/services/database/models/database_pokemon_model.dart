import 'package:flutter/cupertino.dart';
import 'package:flutterapp/services/database/constants/database_constants.dart';

@immutable
class PokemonDatabaseModel {
  final int id;
  final String name;
  final String species;
  final String sprites;
  final String stats;
  final String types;
  final int height;
  final int weight;

  const PokemonDatabaseModel(this.id, this.name, this.species, this.sprites,
      this.stats, this.types, this.height, this.weight);

  PokemonDatabaseModel.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        name = map[nameColumn] as String,
        species = map[speciesColumn] as String,
        sprites = map[spritesColumn] as String,
        stats = map[statsColumn] as String,
        types = map[typesColumn] as String,
        height = map[heightColumn] as int,
        weight = map[heightColumn] as int;
}
