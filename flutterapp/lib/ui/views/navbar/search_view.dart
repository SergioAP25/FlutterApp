import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/constants/routes.dart';
import 'package:flutterapp/domain/bloc/domain_event.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';
import 'package:flutterapp/ui/constants/view_selections.dart';
import '../../../domain/bloc/domain_bloc.dart';
import '../../../domain/bloc/domain_state.dart';

class SearchView extends StatefulWidget {
  final String view;
  const SearchView({super.key, required this.view});

  @override
  State<SearchView> createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  String? _view;
  List<FilteredPokemonModel>? _pokemons = [];
  List<FilteredPokemonModel>? _favoritesList = [];

  String _generalQuery = "";
  String _ordering = "";

  final List<String> _types = [];
  final DomainBloc _filtersBloc = DomainBloc();
  final DomainBloc _favoritesListBloc = DomainBloc();
  final DomainBloc _favoritesBloc = DomainBloc();

  PageStorageKey? _pokedexKey;
  PageStorageKey? _favoritesKey;
  PageStorageKey? _generalKey;

  late final TextEditingController _searchBarController;

  final List<bool> _isSelectedAZ = [false, false];
  final List<bool> _isSelectedTypes = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  Future<void> _pullRefresh() async {
    setState(() {});
  }

  bool _allowedSelection() {
    int total = 0;
    bool allowed = false;
    for (int i = 0; i < _isSelectedTypes.length; i++) {
      if (_isSelectedTypes[i]) {
        total++;
      }
      if (total == 2) {
        break;
      }
    }
    if (total < 2) {
      return allowed = true;
    }
    return allowed;
  }

  void _removeTypes(int index) {
    switch (index) {
      case 0:
        _types.remove("normal");
        break;
      case 1:
        _types.remove("fire");
        break;
      case 2:
        _types.remove("water");
        break;
      case 3:
        _types.remove("grass");
        break;
      case 4:
        _types.remove("electric");
        break;
      case 5:
        _types.remove("ice");
        break;
      case 6:
        _types.remove("ground");
        break;
      case 7:
        _types.remove("flying");
        break;
      case 8:
        _types.remove("poison");
        break;
      case 9:
        _types.remove("fighting");
        break;
      case 10:
        _types.remove("psychic");
        break;
      case 11:
        _types.remove("dark");
        break;
      case 12:
        _types.remove("rock");
        break;
      case 13:
        _types.remove("bug");
        break;
      case 14:
        _types.remove("ghost");
        break;
      case 15:
        _types.remove("steel");
        break;
      case 16:
        _types.remove("dragon");
        break;
      case 17:
        _types.remove("fairy");
        break;
    }
  }

  void _addTypes(int index) {
    switch (index) {
      case 0:
        _types.add("normal");
        break;
      case 1:
        _types.add("fire");
        break;
      case 2:
        _types.add("water");
        break;
      case 3:
        _types.add("grass");
        break;
      case 4:
        _types.add("electric");
        break;
      case 5:
        _types.add("ice");
        break;
      case 6:
        _types.add("ground");
        break;
      case 7:
        _types.add("flying");
        break;
      case 8:
        _types.add("poison");
        break;
      case 9:
        _types.add("fighting");
        break;
      case 10:
        _types.add("psychic");
        break;
      case 11:
        _types.add("dark");
        break;
      case 12:
        _types.add("rock");
        break;
      case 13:
        _types.add("bug");
        break;
      case 14:
        _types.add("ghost");
        break;
      case 15:
        _types.add("steel");
        break;
      case 16:
        _types.add("dragon");
        break;
      case 17:
        _types.add("fairy");
        break;
    }
  }

  void _assignKey() {
    switch (_view) {
      case pokedex:
        _pokedexKey ??= const PageStorageKey(pokedex);
        _generalKey = _pokedexKey;
        break;
      case favorites:
        _favoritesKey ??= const PageStorageKey(favorites);
        _generalKey = _favoritesKey;
        break;
    }
  }

  void _updateSearchView() {
    setState(() {});
  }

  @override
  void initState() {
    _view = widget.view;
    _searchBarController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _assignKey();
    if (!_filtersBloc.isClosed) {
      _filtersBloc
          .add(GetPokemonList(_generalQuery, _ordering, _types, _view!));
    }
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: _searchBarController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                hintText: "Search here",
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: Colors.grey,
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                  splashRadius: 25,
                  onPressed: () {
                    _searchBarController.clear();
                    _generalQuery = "";
                    if (!_filtersBloc.isClosed) {
                      _filtersBloc.add(GetPokemonList(
                          _generalQuery, _ordering, _types, _view!));
                    }
                  },
                )),
            onChanged: (query) {
              _generalQuery = query;
              if (!_filtersBloc.isClosed) {
                _filtersBloc.add(
                    GetPokemonList(_generalQuery, _ordering, _types, _view!));
              }
            },
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: 85,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ToggleButtons(
                          direction: Axis.vertical,
                          renderBorder: false,
                          isSelected: _isSelectedAZ,
                          onPressed: (index) {
                            for (int i = 0; i < _isSelectedAZ.length; i++) {
                              if (i == index) {
                                setState(() {
                                  _isSelectedAZ[i] = !_isSelectedAZ[i];
                                });
                              } else {
                                setState(() {
                                  _isSelectedAZ[i] = false;
                                });
                              }
                            }
                            if (index == 0 && _isSelectedAZ[index]) {
                              _ordering = "az";
                              if (!_filtersBloc.isClosed) {
                                _filtersBloc.add(GetPokemonList(
                                    _generalQuery, _ordering, _types, _view!));
                              }
                            } else if (index == 1 && _isSelectedAZ[index]) {
                              if (!_filtersBloc.isClosed) {
                                _ordering = "za";
                                _filtersBloc.add(GetPokemonList(
                                    _generalQuery, _ordering, _types, _view!));
                              }
                            } else if (!_isSelectedAZ[0] && !_isSelectedAZ[1]) {
                              if (!_filtersBloc.isClosed) {
                                _ordering = "";
                                _filtersBloc.add(GetPokemonList(
                                    _generalQuery, _ordering, _types, _view!));
                              }
                            }
                          },
                          children: [
                            Image.asset("assets/azfilled.png"),
                            Image.asset("assets/zafilled.png"),
                          ]),
                      SizedBox(
                          height: 35, child: Image.asset("assets/line.png")),
                      ToggleButtons(
                          direction: Axis.vertical,
                          renderBorder: false,
                          isSelected: _isSelectedTypes,
                          onPressed: (index) {
                            if (_isSelectedTypes[index]) {
                              setState(() {
                                _isSelectedTypes[index] =
                                    !_isSelectedTypes[index];
                              });

                              _removeTypes(index);
                              if (!_filtersBloc.isClosed) {
                                _filtersBloc.add(GetPokemonList(
                                    _generalQuery, _ordering, _types, _view!));
                              }
                            } else if (_allowedSelection()) {
                              setState(() {
                                _isSelectedTypes[index] =
                                    !_isSelectedTypes[index];
                              });

                              _addTypes(index);
                              if (!_filtersBloc.isClosed) {
                                _filtersBloc.add(GetPokemonList(
                                    _generalQuery, _ordering, _types, _view!));
                              }
                            }
                          },
                          children: [
                            Image.asset("assets/normal.png"),
                            Image.asset("assets/fire.png"),
                            Image.asset("assets/water.png"),
                            Image.asset("assets/grass.png"),
                            Image.asset("assets/electric.png"),
                            Image.asset("assets/ice.png"),
                            Image.asset("assets/ground.png"),
                            Image.asset("assets/flying.png"),
                            Image.asset("assets/poison.png"),
                            Image.asset("assets/fighting.png"),
                            Image.asset("assets/psychic.png"),
                            Image.asset("assets/dark.png"),
                            Image.asset("assets/rock.png"),
                            Image.asset("assets/bug.png"),
                            Image.asset("assets/ghost.png"),
                            Image.asset("assets/steel.png"),
                            Image.asset("assets/dragon.png"),
                            Image.asset("assets/fairy.png"),
                          ]),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                BlocProvider(
                  create: (context) => _filtersBloc,
                  child: BlocBuilder<DomainBloc, DomainState>(
                    builder: (context, state) {
                      if (state is DomainStateLoadedPokemonList) {
                        _pokemons = state.pokemons;
                        if (!_favoritesListBloc.isClosed) {
                          _favoritesListBloc
                              .add(const GetPokemonList("", "", [], favorites));
                        }
                        return BlocProvider.value(
                          value: _favoritesListBloc,
                          child: BlocBuilder<DomainBloc, DomainState>(
                            builder: (context, state) {
                              if (state is DomainStateLoadedPokemonList) {
                                _favoritesList = state.pokemons;
                                return Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: _pullRefresh,
                                    child: BlocProvider.value(
                                      value: _favoritesBloc,
                                      child: ListView.builder(
                                        key: _generalKey,
                                        padding: EdgeInsets.zero,
                                        itemCount: _pokemons!.length,
                                        itemBuilder: (context, index) {
                                          bool favorite = false;
                                          for (int i = 0;
                                              i < _favoritesList!.length;
                                              i++) {
                                            if (_pokemons![index].name ==
                                                _favoritesList![i].name) {
                                              favorite = true;
                                              break;
                                            }
                                          }

                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushNamed(detailRoute,
                                                          arguments: [
                                                        _pokemons![index],
                                                        _updateSearchView
                                                      ]);
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  247,
                                                                  242,
                                                                  242),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Column(
                                                      children: [
                                                        Column(children: [
                                                          SizedBox(
                                                            height: 55,
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                  width: 200,
                                                                ),
                                                                BlocBuilder<
                                                                    DomainBloc,
                                                                    DomainState>(
                                                                  builder:
                                                                      (context,
                                                                          state) {
                                                                    if (state
                                                                            is DomainStateInitial ||
                                                                        state
                                                                            is DomainStateLoadedIsFavorite) {
                                                                      return IconButton(
                                                                          splashColor: Colors
                                                                              .transparent,
                                                                          highlightColor: Colors
                                                                              .transparent,
                                                                          iconSize:
                                                                              50,
                                                                          onPressed:
                                                                              () {
                                                                            if (!favorite) {
                                                                              if (!_favoritesBloc.isClosed) {
                                                                                _favoritesBloc.add(AddFavoriteEvent(_pokemons![index].name));
                                                                                favorite = !favorite;
                                                                                _favoritesList!.add(_pokemons![index]);
                                                                              }
                                                                            } else {
                                                                              if (_view == pokedex) {
                                                                                if (!_favoritesBloc.isClosed) {
                                                                                  _favoritesBloc.add(RemoveFavoriteEvent(_pokemons![index].name));
                                                                                  favorite = !favorite;
                                                                                  _favoritesList!.remove(_pokemons![index]);
                                                                                }
                                                                              } else {
                                                                                setState(() {
                                                                                  if (!_favoritesBloc.isClosed) {
                                                                                    _favoritesBloc.add(RemoveFavoriteEvent(_pokemons![index].name));
                                                                                    favorite = !favorite;
                                                                                  }
                                                                                });
                                                                              }
                                                                            }
                                                                          },
                                                                          icon: favorite
                                                                              ? const Icon(
                                                                                  Icons.star,
                                                                                  color: Colors.yellow,
                                                                                )
                                                                              : const Icon(
                                                                                  Icons.star_border,
                                                                                  color: Colors.yellow,
                                                                                ));
                                                                    } else {
                                                                      return const Expanded(
                                                                          child: Align(
                                                                              alignment: Alignment.center,
                                                                              child: CircularProgressIndicator()));
                                                                    }
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ]),
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 85,
                                                            ),
                                                            Image.network(
                                                              _pokemons![index]
                                                                  .sprites
                                                                  .frontDefault!,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          82,
                                                                          207,
                                                                          86)
                                                                      .withOpacity(
                                                                          0.5),
                                                                  borderRadius: const BorderRadius
                                                                          .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              20),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              20))),
                                                              child: Row(
                                                                children: [
                                                                  const SizedBox(
                                                                    width: 35,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      _pokemons![
                                                                              index]
                                                                          .name,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 35,
                                                                  ),
                                                                  if (_pokemons![
                                                                              index]
                                                                          .types
                                                                          .length <
                                                                      2)
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Image.asset(
                                                                              "assets/${_pokemons![index].types[0].type!.name!}.png"),
                                                                          const SizedBox(
                                                                            width:
                                                                                55,
                                                                          )
                                                                        ],
                                                                      ), //
                                                                    )
                                                                  else
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Image.asset(
                                                                              "assets/${_pokemons![index].types[0].type!.name!}.png"),
                                                                          Image.asset(
                                                                              "assets/${_pokemons![index].types[1].type!.name!}.png"),
                                                                        ],
                                                                      ), //
                                                                    ),
                                                                  const SizedBox(
                                                                    width: 30,
                                                                  )
                                                                ],
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return const Expanded(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator()));
                              }
                            },
                          ),
                        );
                      } else {
                        return const Expanded(
                            child: Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator()));
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
