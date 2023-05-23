import 'package:flutter/cupertino.dart';
import '../../services/api/models/api_pokemon_model.dart';

@immutable
class PokemonModel {
  final List<Results> results;

  const PokemonModel(this.results);

  static PokemonModel fromApi(PokemonApiModel pokemon) {
    return PokemonModel(pokemon.results!);
  }
}
