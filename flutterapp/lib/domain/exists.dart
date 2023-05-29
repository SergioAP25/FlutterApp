import '../data/services/repository.dart';

class Exists {
  final PokemonRepository _repository = PokemonRepository();

  void exists(String name) async {
    await _repository.exists(name);
  }
}
