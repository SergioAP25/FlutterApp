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
  final Stats stats;
  final Types types;
  final int height;
  final int weight;

  const FilteredPokemonModel(this.id, this.name, this.species, this.sprites,
      this.stats, this.types, this.height, this.weight);

  FilteredPokemonModel.fromDatabase(PokemonDatabaseModel pokemon)
      : id = pokemon.id,
        name = pokemon.name,
        species = Species.fromJson(jsonDecode(pokemon.species)),
        sprites = Sprites.fromJson(jsonDecode(pokemon.sprites)),
        stats = Stats.fromJson(jsonDecode(pokemon.stats)),
        types = Types.fromJson(jsonDecode(pokemon.types)),
        height = pokemon.height,
        weight = pokemon.weight;
}
