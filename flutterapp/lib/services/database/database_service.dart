import 'dart:async';
import 'dart:convert';

import 'package:flutterapp/domain/models/description_pokemon_model.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';
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
    final db = getDatabaseOrThrow();
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
    final db = getDatabaseOrThrow();
    await db.insert(
      favoriteTable,
      {pokemonNameColumn: name},
    );
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

  Future<PokemonDatabaseModel> getRandomPokemon() async {
    await _ensureDbIsOpen();
    final db = getDatabaseOrThrow();

    final result =
        await db.rawQuery("SELECT * FROM pokemon ORDER BY RANDOM () LIMIT 1.");

    return PokemonDatabaseModel.fromRow(result.first);
  }

  Future<int> countPokemons() async {
    await _ensureDbIsOpen();
    final db = getDatabaseOrThrow();

    final result = await db.rawQuery("SELECT COUNT(*) FROM pokemon");
    return result.first["COUNT(*)"] as int;
  }

  Future<int> countDescriptions() async {
    await _ensureDbIsOpen();
    final db = getDatabaseOrThrow();

    final result = await db.rawQuery("SELECT COUNT(*) FROM description");

    return result.first["COUNT(*)"] as int;
  }

  Future<bool> exists(String name) async {
    await _ensureDbIsOpen();
    final db = getDatabaseOrThrow();

    final result = await db.rawQuery(
        "SELECT (SELECT COUNT(*) FROM pokemon WHERE name = ?) == 1", ["$name"]);
    String aux = jsonEncode(result.first);
    int integer = int.parse(aux[aux.length - 2]);
    bool boolean = integer == 0 ? false : true;
    return boolean;
  }
}
