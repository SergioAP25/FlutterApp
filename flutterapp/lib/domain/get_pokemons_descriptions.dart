import 'package:flutterapp/domain/models/description_pokemon_model.dart';
import '../data/services/repository.dart';

class GetPokemonsDescriptions {
  final PokemonRepository _repository = PokemonRepository();

  Future<DescriptionModel> getPokemonsDescriptions(String name) async {
    return await _repository.getPokemonDescriptionByNameFromDatabase(name);
  }
}
