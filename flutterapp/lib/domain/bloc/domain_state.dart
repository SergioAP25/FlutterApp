import 'package:flutter/cupertino.dart';
import 'package:flutterapp/domain/models/description_pokemon_model.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';

@immutable
abstract class DomainState {
  const DomainState();
}

class DomainStateInitial extends DomainState {
  const DomainStateInitial();
}

class DomainStateLoading extends DomainState {
  const DomainStateLoading();
}

class DomainStateLoaded extends DomainState {
  const DomainStateLoaded();
}

class DomainStateLoadedPokemonList extends DomainState {
  final List<FilteredPokemonModel>? pokemons;
  const DomainStateLoadedPokemonList(this.pokemons);
}

class DomainStateLoadedRandomPokemon extends DomainState {
  final FilteredPokemonModel pokemon;
  const DomainStateLoadedRandomPokemon(this.pokemon);
}

class DomainStateLoadedDescription extends DomainState {
  final DescriptionModel description;
  const DomainStateLoadedDescription(this.description);
}

class DomainError extends DomainState {
  final String? error;
  const DomainError(this.error);
}
