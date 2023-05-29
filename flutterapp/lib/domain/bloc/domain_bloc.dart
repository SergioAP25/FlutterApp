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
import '../get_pokemons_by_name.dart';
import '../get_pokemons_by_name_az.dart';
import '../get_pokemons_by_name_filtered_by_multi_type.dart';
import '../get_pokemons_by_name_filtered_by_multi_type_az.dart';
import '../get_pokemons_by_name_filtered_by_type.dart';
import '../get_pokemons_by_name_filtered_by_type_az.dart';
import '../get_pokemons_by_name_za.dart';
import '../models/filtered_pokemon_model.dart';

class DomainBloc extends Bloc<DomainEvent, DomainState> {
  final GetPokemonsByName getPokemonsByName = GetPokemonsByName();
  final GetPokemonsByNameAZ getPokemonsByNameAZ = GetPokemonsByNameAZ();
  final GetPokemonsByNameZA getPokemonsByNameZA = GetPokemonsByNameZA();
  final GetPokemonsByNameFilteredByType getPokemonsByNameFilteredByType =
      GetPokemonsByNameFilteredByType();
  final GetPokemonsByNameFilteredByTypeAZ getPokemonsByNameFilteredByTypeAZ =
      GetPokemonsByNameFilteredByTypeAZ();
  final GetPokemonsByNameFilteredByTypeZA getPokemonsByNameFilteredByTypeZA =
      GetPokemonsByNameFilteredByTypeZA();
  final GetPokemonsByNameFilteredByMultiType
      getPokemonsByNameFilteredByMultiType =
      GetPokemonsByNameFilteredByMultiType();
  final GetPokemonsByNameFilteredByMultiTypeAZ
      getPokemonsByNameFilteredByMultiTypeAZ =
      GetPokemonsByNameFilteredByMultiTypeAZ();
  final GetPokemonsByNameFilteredByMultiTypeZA
      getPokemonsByNameFilteredByMultiTypeZA =
      GetPokemonsByNameFilteredByMultiTypeZA();

  final GetFavoritePokemon getFavoritePokemon = GetFavoritePokemon();
  final GetFavoritePokemonAZ getFavoritePokemonAZ = GetFavoritePokemonAZ();
  final GetFavoritePokemonZA getFavoritePokemonZA = GetFavoritePokemonZA();
  final GetFavoritePokemonByNameFilteredByType
      getFavoritePokemonByNameFilteredByType =
      GetFavoritePokemonByNameFilteredByType();
  final GetFavoritePokemonByNameFilteredByTypeAZ
      getFavoritePokemonsByNameFilteredByTypeAZ =
      GetFavoritePokemonByNameFilteredByTypeAZ();
  final GetFavoritePokemonByNameFilteredByTypeZA
      getFavoritePokemonByNameFilteredByTypeZA =
      GetFavoritePokemonByNameFilteredByTypeZA();
  final GetFavoritePokemonByNameFilteredByMultiType
      getFavoritePokemonByNameFilteredByMultiType =
      GetFavoritePokemonByNameFilteredByMultiType();
  final GetFavoritePokemonByNameFilteredByMultiTypeAZ
      getFavoritePokemonByNameFilteredByMultiTypeAZ =
      GetFavoritePokemonByNameFilteredByMultiTypeAZ();
  final GetFavoritePokemonByNameFilteredByMultiTypeZA
      getFavoritePokemonByNameFilteredByMultiTypeZA =
      GetFavoritePokemonByNameFilteredByMultiTypeZA();

  final GetPokemonsDescriptions getPokemonsDescriptions =
      GetPokemonsDescriptions();

  final GetRandomPokemon getRandomPokemon = GetRandomPokemon();

  final AddFavorite addFavorite = AddFavorite();
  final RemoveFavorite removeFavorite = RemoveFavorite();
  final IsFavorite isFavorite = IsFavorite();

  final Exists exists = Exists();

  DomainBloc() : super(const DomainStateInitial()) {
    on<GetPokemonList>((event, emit) async {
      try {
        emit(const DomainStateLoading());
        final pokemons = await selectAssignSearchType(
            event.query, event.ordering, event.types, event.favorite);
        emit(DomainStateLoadedPokemonList(pokemons));
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });

    on<GetRandomPokemonEvent>((event, emit) async {
      try {
        emit(const DomainStateLoading());
        final pokemon = await getRandomPokemon.getRandomPokemon();
        emit(DomainStateLoadedRandomPokemon(pokemon));
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });

    on<GetDescriptionEvent>((event, emit) async {
      try {
        emit(const DomainStateLoading());
        final description =
            await getPokemonsDescriptions.getPokemonsDescriptions(event.name);
        emit(DomainStateLoadedDescription(description));
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });

    on<AddFavoriteEvent>((event, emit) async {
      try {
        emit(const DomainStateLoading());
        addFavorite.addFavorite(event.name);
        emit(const DomainStateLoaded());
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });

    on<RemoveFavoriteEvent>((event, emit) async {
      try {
        emit(const DomainStateLoading());
        removeFavorite.removeFavorite(event.name);
        emit(const DomainStateLoaded());
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });

    on<IsFavoriteEvent>((event, emit) async {
      try {
        emit(const DomainStateLoading());
        isFavorite.isFavorite(event.name);
        emit(const DomainStateLoaded());
      } catch (e) {
        emit(const DomainError("An error ocurred"));
      }
    });
  }

  Future<List<FilteredPokemonModel>>? selectAssignSearchType(
      String query, String ordering, List<String> types, String favorite) {
    Future<List<FilteredPokemonModel>>? aux;
    switch (favorite) {
      case "NO":
        switch (ordering) {
          case "":
            switch (types.length) {
              case 0:
                aux = getPokemonsByName.getPokemonsByName(query);
                break;
              case 1:
                aux = getPokemonsByNameFilteredByType
                    .getPokemonsByNameFilteredByType(query, types[0]);
                break;
              case 2:
                aux = getPokemonsByNameFilteredByMultiType
                    .getPokemonsByNameFilteredByMultiType(
                        query, types[0], types[1]);
                break;
            }
            break;
          case "az":
            switch (types.length) {
              case 0:
                aux = getPokemonsByNameAZ.getPokemonsByNameAZ(query);
                break;

              case 1:
                aux = getPokemonsByNameFilteredByTypeAZ
                    .getPokemonsByNameFilteredByTypeAZ(query, types[0]);
                break;
              case 2:
                aux = getPokemonsByNameFilteredByMultiTypeAZ
                    .getPokemonsByNameFilteredByMultiTypeAZ(
                        query, types[0], types[1]);
                break;
            }
            break;
          case "za":
            switch (types.length) {
              case 0:
                aux = getPokemonsByNameZA.getPokemonsByNameZA(query);
                break;
              case 1:
                aux = getPokemonsByNameFilteredByTypeZA
                    .getPokemonsByNameFilteredByTypeZA(query, types[0]);
                break;
              case 2:
                aux = getPokemonsByNameFilteredByMultiTypeZA
                    .getPokemonsByNameFilteredByMultiTypeZA(
                        query, types[0], types[1]);
                break;
            }
            break;
        }
        break;
      case "YES":
        switch (ordering) {
          case "":
            switch (types.length) {
              case 0:
                aux = getFavoritePokemon.getFavoritePokemon(query);
                break;
              case 1:
                aux = getFavoritePokemonByNameFilteredByType
                    .getFavoritePokemonByNameFilteredByType(query, types[0]);
                break;
              case 2:
                aux = getFavoritePokemonByNameFilteredByMultiType
                    .getFavoritePokemonByNameFilteredByMultiType(
                        query, types[0], types[1]);
                break;
            }
            break;
          case "az":
            switch (types.length) {
              case 0:
                aux = getFavoritePokemonAZ.getFavoritePokemonAZ(query);
                break;

              case 1:
                aux = getFavoritePokemonsByNameFilteredByTypeAZ
                    .getFavoritePokemonByNameFilteredByTypeAZ(query, types[0]);
                break;
              case 2:
                aux = getFavoritePokemonByNameFilteredByMultiTypeAZ
                    .getFavoritePokemonByNameFilteredByMultiTypeAZ(
                        query, types[0], types[1]);
                break;
            }
            break;
          case "za":
            switch (types.length) {
              case 0:
                aux = getFavoritePokemonZA.getFavoritePokemonZA(query);
                break;
              case 1:
                aux = getFavoritePokemonByNameFilteredByTypeZA
                    .getFavoritePokemonByNameFilteredByTypeZA(query, types[0]);
                break;
              case 2:
                aux = getFavoritePokemonByNameFilteredByMultiTypeZA
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
