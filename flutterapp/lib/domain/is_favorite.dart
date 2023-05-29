import '../data/services/repository.dart';

class IsFavorite {
  final PokemonRepository _repository = PokemonRepository();

  Future<bool> isFavorite(String name) async {
    return await _repository.isFavorite(name);
  }
}
