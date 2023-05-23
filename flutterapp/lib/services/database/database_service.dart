import 'dart:async';
import 'dart:convert';

import 'package:flutterapp/domain/models/description_pokemon_model.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';
import 'package:flutterapp/services/api/models/api_filtered_pokemon.dart';
import 'package:flutterapp/services/api/models/api_pokemon_model.dart';
import 'package:flutterapp/services/database/models/database_pokemon_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'constants/database_constants.dart';
import 'exceptions/database_exceptions.dart';

class PokemonService {
  Database? _db;

  static final PokemonService _pokemonService =
      PokemonService._sharedInstance();

  factory PokemonService() {
    return _pokemonService;
  }

  PokemonService._sharedInstance();

  Future<void> _ensureDbIsOpen() async {
    try {
      await open();
    } on DatabaseAlreadyOpen {
      //empty
    }
  }

  Database getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      return db;
    }
  }

  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpen();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;

      await db.execute(createPokemonTable);
      await db.execute(createDescriptionTable);
      await db.execute(createFavoriteTable);
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      await db.close();
      _db = null;
    }
  }

  Future<void> insertPokemon({required FilteredPokemonModel pokemon}) async {
    await _ensureDbIsOpen();
    final db = getDatabaseOrThrow();
    await db.insert(pokemonTable, {
      nameColumn: pokemon.name,
      speciesColumn: jsonEncode(pokemon.species.toJson()),
      spritesColumn: jsonEncode(pokemon.sprites.toJson()),
      statsColumn: jsonEncode(pokemon.stats),
      typesColumn: jsonEncode(pokemon.types),
      heightColumn: pokemon.height,
      weightColumn: pokemon.weight
    });
  }

  Future<void> insertDescriptions(
      {required DescriptionModel description}) async {
    await _ensureDbIsOpen();
    final db = getDatabaseOrThrow();
    await db.insert(descriptionTable,
        {descriptionColumn: jsonEncode(description.descriptions)});
  }

  Future<Iterable<PokemonDatabaseModel>> getPokemonByName(
      {required String name}) async {
    await _ensureDbIsOpen();
    final db = getDatabaseOrThrow();

    final results = await db.query(
      pokemonTable,
      where: "name LIKE ?",
      whereArgs: ["%$name%"],
    );

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }
}
