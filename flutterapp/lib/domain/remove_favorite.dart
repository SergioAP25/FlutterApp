import '../data/services/repository.dart';

class RemoveFavorite {
  final PokemonRepository _repository = PokemonRepository();

  void removeFavorite(String name) async {
    await _repository.deleteFavorite(name);
  }
}
