import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutterapp/domain/constants/domain_constants.dart';
import 'package:flutterapp/domain/models/description_pokemon_model.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';
import 'package:flutterapp/data/services/api/models/api_pokemon_model.dart';

import '../data/services/api/models/api_description_model.dart';
import '../data/services/repository.dart';

class GetPokemons {
  final PokemonRepository _repository = PokemonRepository();

  List<Results> _apilist = [];

  Future<void> getPokemons() async {
    final list = await _repository.getAllPokemons();
    _apilist = list.results;
    bool exists =
        await _repository.exists(list.results.last.name!.capitalize());
    if (!exists) {
      _insertPokemonsIntoDatabase();
    }
  }

  void _insertPokemonsIntoDatabase() async {
    FilteredPokemonModel pokemon;
    DescriptionModel description;
    int startingIndex = await _repository.countPokemons();
    int totalPokemons = await _repository.countPokemons();
    int totalDescriptions = await _repository.countDescriptions();

    if (totalPokemons != totalDescriptions) {
      pokemon = await _repository.getPokemonByUrl(_apilist[startingIndex].url!);
      description =
          await _repository.getPokemonDescriptionByUrls(pokemon.species.url!);
    }

    for (var i = startingIndex; i < _apilist.length; i++) {
      pokemon = await _repository.getPokemonByUrl(_apilist[i].url!);
      description =
          await _repository.getPokemonDescriptionByUrls(pokemon.species.url!);
      pokemon.name = pokemon.name.capitalize();
      pokemon.sprites.frontDefault ??= defaultSprite;
      if (description.description.isEmpty) {
        description.description.add(FlavorTextEntries(
            flavorText: defaultDescription, language: Language(name: "en")));
      }
      await _repository.insertPokemon(pokemon);
      await _repository.insertDescriptions(description);
    }
  }
}
