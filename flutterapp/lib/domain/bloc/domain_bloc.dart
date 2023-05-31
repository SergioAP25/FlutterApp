import 'package:bloc/bloc.dart';
import 'package:flutterapp/domain/add_favorite.dart';
import 'package:flutterapp/domain/bloc/domain_event.dart';
import 'package:flutterapp/domain/bloc/domain_state.dart';
import 'package:flutterapp/domain/get_favorite_pokemon.dart';
import 'package:flutterapp/domain/get_pokemons_by_name_filtered_by_multi_type_za.dart';
import 'package:flutterapp/domain/get_pokemons_by_name_filtered_by_type_za.dart';
import 'package:flutterapp/domain/get_pokemons_descriptions.dart';
import 'package:flutterapp/domain/get_random_pokemon.dart';
import 'package:flutterapp/domain/is_favorite.dart';
import 'package:flutterapp/domain/remove_favorite.dart';
import '../exists.dart';
import '../get_favorite_pokemon_az.dart';
import '../get_favorite_pokemon_by_name_filtered_by_multi_type.dart';
import '../get_favorite_pokemon_by_name_filtered_by_multi_type_az.dart';
import '../get_favorite_pokemon_by_name_filtered_by_multi_type_za.dart';
import '../get_favorite_pokemon_by_name_filtered_by_type.dart';
import '../get_favorite_pokemon_by_name_filtered_by_type_az.dart';
import '../get_favorite_pokemon_by_name_filtered_by_type_za.dart';
import '../get_favorite_pokemon_za.dart';
import '../get_pokemons.dart';
import '../get_pokemons_by_name.dart';
import '../get_pokemons_by_name_az.dart';
import '../get_pokemons_by_name_filtered_by_multi_type.dart';
import '../get_pokemons_by_name_filtered_by_multi_type_az.dart';
import '../get_pokemons_by_name_filtered_by_type.dart';
import '../get_pokemons_by_name_filtered_by_type_az.dart';
import '../get_pokemons_by_name_za.dart';
import '../models/filtered_pokemon_model.dart';

class DomainBloc extends Bloc<DomainEvent, DomainState> {
  final GetPokemons _getPokemons = GetPokemons();
  final GetPokemonsByName _getPokemonsByName = GetPokemonsByName();
  final GetPokemonsByNameAZ _getPokemonsByNameAZ = GetPokemonsByNameAZ();
  final GetPokemonsByNameZA _getPokemonsByNameZA = GetPokemonsByNameZA();
  final GetPokemonsByNameFilteredByType _getPokemonsByNameFilteredByType =
      GetPokemonsByNameFilteredByType();
  final GetPokemonsByNameFilteredByTypeAZ _getPokemonsByNameFilteredByTypeAZ =
      GetPokemonsByNameFilteredByTypeAZ();
  final GetPokemonsByNameFilteredByTypeZA _getPokemonsByNameFilteredByTypeZA =
      GetPokemonsByNameFilteredByTypeZA();
  final GetPokemonsByNameFilteredByMultiType
      _getPokemonsByNameFilteredByMultiType =
      GetPokemonsByNameFilteredByMultiType();
  final GetPokemonsByNameFilteredByMultiTypeAZ
      _getPokemonsByNameFilteredByMultiTypeAZ =
      GetPokemonsByNameFilteredByMultiTypeAZ();
  final GetPokemonsByNameFilteredByMultiTypeZA
      _getPokemonsByNameFilteredByMultiTypeZA =
      GetPokemonsByNameFilteredByMultiTypeZA();

  final GetFavoritePokemon _getFavoritePokemon = GetFavoritePokemon();
  final GetFavoritePokemonAZ _getFavoritePokemonAZ = GetFavoritePokemonAZ();
  final GetFavoritePokemonZA _getFavoritePokemonZA = GetFavoritePokemonZA();
  final GetFavoritePokemonByNameFilteredByType
      _getFavoritePokemonByNameFilteredByType =
      GetFavoritePokemonByNameFilteredByType();
  final GetFavoritePokemonByNameFilteredByTypeAZ
      _getFavoritePokemonsByNameFilteredByTypeAZ =
      GetFavoritePokemonByNameFilteredByTypeAZ();
  final GetFavoritePokemonByNameFilteredByTypeZA
      _getFavoritePokemonByNameFilteredByTypeZA =
      GetFavoritePokemonByNameFilteredByTypeZA();
  final GetFavoritePokemonByNameFilteredByMultiType
      _getFavoritePokemonByNameFilteredByMultiType =
      GetFavoritePokemonByNameFilteredByMultiType();
  final GetFavoritePokemonByNameFilteredByMultiTypeAZ
      _getFavoritePokemonByNameFilteredByMultiTypeAZ =
      GetFavoritePokemonByNameFilteredByMultiTypeAZ();
  final GetFavoritePokemonByNameFilteredByMultiTypeZA
      _getFavoritePokemonByNameFilteredByMultiTypeZA =
      GetFavoritePokemonByNameFilteredByMultiTypeZA();

  final GetPokemonsDescriptions _getPokemonsDescriptions =
      GetPokemonsDescriptions();

  final GetRandomPokemon _getRandomPokemon = GetRandomPokemon();

  final AddFavorite _addFavorite = AddFavorite();
  final RemoveFavorite _removeFavorite = RemoveFavorite();
  final IsFavorite _isFavorite = IsFavorite();

  DomainBloc() : super(const DomainStateInitial()) {
    on<GetPokemonsEvent>((event, emit) async {
      try {
        await _getPokemons.getPokemons();
        emit(const DomainStateLoaded());
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });

    on<GetPokemonList>((event, emit) async {
      try {
        emit(const DomainStateLoading());
        final pokemons = await selectAssignSearchType(
            event.query, event.ordering, event.types, event.view);
        emit(DomainStateLoadedPokemonList(pokemons));
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });

    on<GetRandomPokemonEvent>((event, emit) async {
      try {
        emit(const DomainStateLoading());
        final pokemon = await _getRandomPokemon.getRandomPokemon();
        emit(DomainStateLoadedRandomPokemon(pokemon));
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });

    on<GetDescriptionEvent>((event, emit) async {
      try {
        emit(const DomainStateLoading());
        final description =
            await _getPokemonsDescriptions.getPokemonsDescriptions(event.name);
        emit(DomainStateLoadedDescription(description));
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });

    on<AddFavoriteEvent>((event, emit) async {
      try {
        emit(const DomainStateLoading());
        _addFavorite.addFavorite(event.name);
        final favorite = await _isFavorite.isFavorite(event.name);
        emit(DomainStateLoadedIsFavorite(favorite));
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });

    on<RemoveFavoriteEvent>((event, emit) async {
      try {
        emit(const DomainStateLoading());
        _removeFavorite.removeFavorite(event.name);
        final favorite = await _isFavorite.isFavorite(event.name);
        emit(DomainStateLoadedIsFavorite(favorite));
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });

    on<IsFavoriteEvent>((event, emit) async {
      try {
        emit(const DomainStateLoading());
        final favorite = await _isFavorite.isFavorite(event.name);
        emit(DomainStateLoadedIsFavorite(favorite));
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });
  }

  Future<List<FilteredPokemonModel>>? selectAssignSearchType(
      String query, String ordering, List<String> types, String view) {
    Future<List<FilteredPokemonModel>>? aux;
    switch (view) {
      case "POKEDEX":
        switch (ordering) {
          case "":
            switch (types.length) {
              case 0:
                aux = _getPokemonsByName.getPokemonsByName(query);
                break;
              case 1:
                aux = _getPokemonsByNameFilteredByType
                    .getPokemonsByNameFilteredByType(query, types[0]);
                break;
              case 2:
                aux = _getPokemonsByNameFilteredByMultiType
                    .getPokemonsByNameFilteredByMultiType(
                        query, types[0], types[1]);
                break;
            }
            break;
          case "az":
            switch (types.length) {
              case 0:
                aux = _getPokemonsByNameAZ.getPokemonsByNameAZ(query);
                break;

              case 1:
                aux = _getPokemonsByNameFilteredByTypeAZ
                    .getPokemonsByNameFilteredByTypeAZ(query, types[0]);
                break;
              case 2:
                aux = _getPokemonsByNameFilteredByMultiTypeAZ
                    .getPokemonsByNameFilteredByMultiTypeAZ(
                        query, types[0], types[1]);
                break;
            }
            break;
          case "za":
            switch (types.length) {
              case 0:
                aux = _getPokemonsByNameZA.getPokemonsByNameZA(query);
                break;
              case 1:
                aux = _getPokemonsByNameFilteredByTypeZA
                    .getPokemonsByNameFilteredByTypeZA(query, types[0]);
                break;
              case 2:
                aux = _getPokemonsByNameFilteredByMultiTypeZA
                    .getPokemonsByNameFilteredByMultiTypeZA(
                        query, types[0], types[1]);
                break;
            }
            break;
        }
        break;
      case "FAVORITES":
        switch (ordering) {
          case "":
            switch (types.length) {
              case 0:
                aux = _getFavoritePokemon.getFavoritePokemon(query);
                break;
              case 1:
                aux = _getFavoritePokemonByNameFilteredByType
                    .getFavoritePokemonByNameFilteredByType(query, types[0]);
                break;
              case 2:
                aux = _getFavoritePokemonByNameFilteredByMultiType
                    .getFavoritePokemonByNameFilteredByMultiType(
                        query, types[0], types[1]);
                break;
            }
            break;
          case "az":
            switch (types.length) {
              case 0:
                aux = _getFavoritePokemonAZ.getFavoritePokemonAZ(query);
                break;

              case 1:
                aux = _getFavoritePokemonsByNameFilteredByTypeAZ
                    .getFavoritePokemonByNameFilteredByTypeAZ(query, types[0]);
                break;
              case 2:
                aux = _getFavoritePokemonByNameFilteredByMultiTypeAZ
                    .getFavoritePokemonByNameFilteredByMultiTypeAZ(
                        query, types[0], types[1]);
                break;
            }
            break;
          case "za":
            switch (types.length) {
              case 0:
                aux = _getFavoritePokemonZA.getFavoritePokemonZA(query);
                break;
              case 1:
                aux = _getFavoritePokemonByNameFilteredByTypeZA
                    .getFavoritePokemonByNameFilteredByTypeZA(query, types[0]);
                break;
              case 2:
                aux = _getFavoritePokemonByNameFilteredByMultiTypeZA
                    .getFavoritePokemonByNameFilteredByMultiTypeZA(
                        query, types[0], types[1]);
                break;
            }
            break;
        }
        break;
    }

    return aux;
  }
}
