import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/services/api/models/api_filtered_pokemon.dart';
import 'package:flutterapp/services/database/models/database_pokemon_model.dart';

@immutable
class FilteredPokemonModel {
  final int id;
  final String name;
  final Species species;
  final Sprites sprites;
  final List<Stats> stats;
  final List<Types> types;
  final int height;
  final int weight;

  const FilteredPokemonModel(this.id, this.name, this.species, this.sprites,
      this.stats, this.types, this.height, this.weight);

  static List<Stats> _decodeStatsList(PokemonDatabaseModel pokemon) {
    final List<Stats> aux = [];
    final List<dynamic> stats = jsonDecode(pokemon.stats);
    for (var i = 0; i < stats.length; i++) {
      aux.add(Stats.fromJson(stats[i]));
    }
    return aux;
  }

  static List<Types> _decodeTypesList(PokemonDatabaseModel pokemon) {
    final List<Types> aux = [];
    final List<dynamic> types = jsonDecode(pokemon.types);
    for (var i = 0; i < types.length; i++) {
      aux.add(Types.fromJson(types[i]));
    }
    return aux;
  }

  static FilteredPokemonModel fromDatabase(PokemonDatabaseModel pokemon) {
    final id = pokemon.id;
    final name = pokemon.name;
    final species = Species.fromJson(jsonDecode(pokemon.species));
    final sprites = Sprites.fromJson(jsonDecode(pokemon.sprites));
    final List<Stats> statsList = _decodeStatsList(pokemon);
    final List<Types> typesList = _decodeTypesList(pokemon);
    final height = pokemon.height;
    final weight = pokemon.weight;

    return FilteredPokemonModel(
        id, name, species, sprites, statsList, typesList, height, weight);
  }
}
