import 'dart:async';
import 'dart:convert';

import 'package:flutterapp/domain/models/description_pokemon_model.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';
import 'package:flutterapp/data/services/database/models/database_description_model.dart';
import 'package:flutterapp/data/services/database/models/database_pokemon_model.dart';
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
      await _open();
    } on DatabaseAlreadyOpen {
      //empty
    }
  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      return db;
    }
  }

  Future<void> _open() async {
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
    final db = _getDatabaseOrThrow();
    await db.insert(
        pokemonTable,
        {
          nameColumn: pokemon.name,
          speciesColumn: jsonEncode(pokemon.species.toJson()),
          spritesColumn: jsonEncode(pokemon.sprites.toJson()),
          statsColumn: jsonEncode(pokemon.stats),
          typesColumn: jsonEncode(pokemon.types),
          heightColumn: pokemon.height,
          weightColumn: pokemon.weight
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertDescription(
      {required DescriptionModel description}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await db.insert(
      descriptionTable,
      {
        descriptionColumn: jsonEncode(
          description.description,
        )
      },
    );
  }

  Future<void> insertFavorite({required String name}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await db.insert(
      favoriteTable,
      {pokemonNameColumn: name},
    );
  }

  Future<void> deleteFavorite({required String name}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await db.delete(favoriteTable, where: "pokemonName = ?", whereArgs: [name]);
  }

  Future<Iterable<PokemonDatabaseModel>> getPokemonByName(
      {required String name}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.query(
      pokemonTable,
      where: "name LIKE ?",
      whereArgs: ["%$name%"],
    );

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>> getPokemonByNameAZ(
      {required String name}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.query(
      pokemonTable,
      where: "name LIKE ? ORDER BY name ASC",
      whereArgs: ["%$name%"],
    );

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>> getPokemonByNameZA(
      {required String name}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.query(
      pokemonTable,
      where: "name LIKE ? ORDER BY name DESC",
      whereArgs: ["%$name%"],
    );

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>> getPokemonByNameFilteredByType(
      {required String name, required String type}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.query(
      pokemonTable,
      where: "name LIKE ? AND types LIKE ?",
      whereArgs: ["%$name%", "%$type%"],
    );

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>> getPokemonByNameFilteredByMultiType(
      {required String name,
      required String type1,
      required String type2}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.query(
      pokemonTable,
      where: "name LIKE ? AND types LIKE ? AND types LIKE ?",
      whereArgs: ["%$name%", "%$type1%", "%$type2%"],
    );

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>> getPokemonByNameFilteredByTypeAZ(
      {required String name, required String type}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.query(
      pokemonTable,
      where: "name LIKE ? AND types LIKE ? ORDER BY name ASC",
      whereArgs: ["%$name%", "%$type%"],
    );

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>> getPokemonByNameFilteredByTypeZA(
      {required String name, required String type}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.query(
      pokemonTable,
      where: "name LIKE ? AND types LIKE ? ORDER BY name DESC",
      whereArgs: ["%$name%", "%$type%"],
    );

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>> getPokemonByNameFilteredByMultiTypeAZ(
      {required String name,
      required String type1,
      required String type2}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.query(
      pokemonTable,
      where: "name LIKE ? AND types LIKE ? AND types LIKE ? ORDER BY name ASC",
      whereArgs: ["%$name%", "%$type1%", "%$type2%"],
    );

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>> getPokemonByNameFilteredByMultiTypeZA(
      {required String name,
      required String type1,
      required String type2}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.query(
      pokemonTable,
      where: "name LIKE ? AND types LIKE ? AND types LIKE ? ORDER BY name DESC",
      whereArgs: ["%$name%", "%$type1%", "%$type2%"],
    );

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>> getFavoritePokemonByName({
    required String name,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.rawQuery(
        "SELECT * FROM pokemon p, favorite f WHERE p.name = f.pokemonName AND name LIKE ?",
        ["%$name%"]);

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>> getFavoritePokemonByNameAZ({
    required String name,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.rawQuery(
        "SELECT * FROM pokemon p, favorite f WHERE p.name = f.pokemonName AND name LIKE ? ORDER BY pokemonName ASC",
        ["%$name%"]);

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>> getFavoritePokemonByNameZA({
    required String name,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.rawQuery(
        "SELECT * FROM pokemon p, favorite f WHERE p.name = f.pokemonName AND name LIKE ? ORDER BY pokemonName DESC",
        ["%$name%"]);

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>> getFavoritePokemonByNameFilteredByType(
      {required String name, required String type}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.rawQuery(
        "SELECT * FROM pokemon p, favorite f WHERE p.name = f.pokemonName AND name LIKE ? AND types LIKE ?",
        ["%$name%", "%$type%"]);

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>>
      getFavoritePokemonByNameFilteredByMultiType(
          {required String name,
          required String type1,
          required String type2}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.rawQuery(
        "SELECT * FROM pokemon p, favorite f WHERE p.name = f.pokemonName AND name LIKE ? AND types LIKE ? AND types LIKE ?",
        ["%$name%", "%$type1%", "%$type2%"]);

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>>
      getFavoritePokemonByNameFilteredByTypeAZ(
          {required String name, required String type}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.rawQuery(
        "SELECT * FROM pokemon p, favorite f WHERE p.name = f.pokemonName AND name LIKE ? AND types LIKE ? ORDER BY pokemonName ASC",
        ["%$name%", "%$type%"]);

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>>
      getFavoritePokemonByNameFilteredByTypeZA(
          {required String name, required String type}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.rawQuery(
        "SELECT * FROM pokemon p, favorite f WHERE p.name = f.pokemonName AND name LIKE ? AND types LIKE ? ORDER BY pokemonName DESC",
        ["%$name%", "%$type%"]);

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>>
      getFavoritePokemonByNameFilteredByMultiTypeAZ(
          {required String name,
          required String type1,
          required String type2}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.rawQuery(
        "SELECT * FROM pokemon p, favorite f WHERE p.name = f.pokemonName AND name LIKE ? AND types LIKE ? AND types LIKE ? ORDER BY pokemonName ASC",
        ["%$name%", "%$type1%", "%$type2%"]);

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<Iterable<PokemonDatabaseModel>>
      getFavoritePokemonByNameFilteredByMultiTypeZA(
          {required String name,
          required String type1,
          required String type2}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.rawQuery(
        "SELECT * FROM pokemon p, favorite f WHERE p.name = f.pokemonName AND name LIKE ? AND types LIKE ? AND types LIKE ? ORDER BY pokemonName DESC",
        ["%$name%", "%$type1%", "%$type2%"]);

    return results
        .map((pokemonRow) => PokemonDatabaseModel.fromRow(pokemonRow));
  }

  Future<DescriptionDatabaseModel> getPokemonDescriptionByName({
    required String name,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.rawQuery(
        "SELECT * FROM pokemon p, description d WHERE p.id = d.description_id AND name = ?",
        [name]);
    return DescriptionDatabaseModel.fromRow(results.first);
  }

  Future<PokemonDatabaseModel> getRandomPokemon() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final result =
        await db.rawQuery("SELECT * FROM pokemon ORDER BY RANDOM () LIMIT 1.");

    return PokemonDatabaseModel.fromRow(result.first);
  }

  Future<int> countPokemons() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final result = await db.rawQuery("SELECT COUNT(*) FROM pokemon");
    return result.first["COUNT(*)"] as int;
  }

  Future<int> countDescriptions() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final result = await db.rawQuery("SELECT COUNT(*) FROM description");

    return result.first["COUNT(*)"] as int;
  }

  Future<bool> exists(String name) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final result = await db.rawQuery(
        "SELECT (SELECT COUNT(*) FROM pokemon WHERE name = ?) == 1", [name]);
    return result.first["(SELECT COUNT(*) FROM pokemon WHERE name = ?) == 1"]
                as int ==
            0
        ? false
        : true;
  }

  Future<bool> isFavorite(String name) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final result = await db.rawQuery(
        "SELECT (SELECT COUNT(*) FROM favorite WHERE pokemonName = ?) == 1",
        [name]);

    return result.first[
                    "(SELECT COUNT(*) FROM favorite WHERE pokemonName = ?) == 1"]
                as int ==
            0
        ? false
        : true;
  }
}
