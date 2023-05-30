import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/constants/routes.dart';
import 'package:flutterapp/domain/bloc/domain_event.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';

import '../../../data/services/repository.dart';
import '../../../domain/bloc/domain_bloc.dart';
import '../../../domain/bloc/domain_state.dart';

class Pokedex extends StatefulWidget {
  const Pokedex({super.key});

  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  final DomainBloc _domainBloc = DomainBloc();
  final DomainBloc _domainBloc2 = DomainBloc();
  List<FilteredPokemonModel>? pokemons = [];
  String favorite = "NO";
  PokemonRepository repo = PokemonRepository();
  List<bool> isSelectedAZ = [false, false];
  List<bool> isSelectedTypes = [
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

  String ordering = "";
  List<String> types = [];
  String generalQuery = "";

  Future<void> _pullRefresh() async {
    setState(() {});
  }

  bool allowedSelection() {
    int total = 0;
    bool allowed = false;
    for (int i = 0; i < isSelectedTypes.length; i++) {
      if (isSelectedTypes[i]) {
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

  void removeTypes(int index) {
    switch (index) {
      case 0:
        types.remove("normal");
        break;
      case 1:
        types.remove("fire");
        break;
      case 2:
        types.remove("water");
        break;
      case 3:
        types.remove("grass");
        break;
      case 4:
        types.remove("electric");
        break;
      case 5:
        types.remove("ice");
        break;
      case 6:
        types.remove("ground");
        break;
      case 7:
        types.remove("flying");
        break;
      case 8:
        types.remove("poison");
        break;
      case 9:
        types.remove("fighting");
        break;
      case 10:
        types.remove("psychic");
        break;
      case 11:
        types.remove("dark");
        break;
      case 12:
        types.remove("rock");
        break;
      case 13:
        types.remove("bug");
        break;
      case 14:
        types.remove("ghost");
        break;
      case 15:
        types.remove("steel");
        break;
      case 16:
        types.remove("dragon");
        break;
      case 17:
        types.remove("fairy");
        break;
    }
  }

  void addTypes(int index) {
    switch (index) {
      case 0:
        types.add("normal");
        break;
      case 1:
        types.add("fire");
        break;
      case 2:
        types.add("water");
        break;
      case 3:
        types.add("grass");
        break;
      case 4:
        types.add("electric");
        break;
      case 5:
        types.add("ice");
        break;
      case 6:
        types.add("ground");
        break;
      case 7:
        types.add("flying");
        break;
      case 8:
        types.add("poison");
        break;
      case 9:
        types.add("fighting");
        break;
      case 10:
        types.add("psychic");
        break;
      case 11:
        types.add("dark");
        break;
      case 12:
        types.add("rock");
        break;
      case 13:
        types.add("bug");
        break;
      case 14:
        types.add("ghost");
        break;
      case 15:
        types.add("steel");
        break;
      case 16:
        types.add("dragon");
        break;
      case 17:
        types.add("fairy");
        break;
    }
  }

  @override
  void initState() {
    if (!_domainBloc.isClosed) {
      _domainBloc.add(GetPokemonList(generalQuery, ordering, types, favorite));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                hintText: "Search Here",
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: Colors.grey),
            onChanged: (query) {
              generalQuery = query;
              if (!_domainBloc.isClosed) {
                _domainBloc.add(
                    GetPokemonList(generalQuery, ordering, types, favorite));
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
                          isSelected: isSelectedAZ,
                          onPressed: (index) {
                            for (int i = 0; i < isSelectedAZ.length; i++) {
                              if (i == index) {
                                setState(() {
                                  isSelectedAZ[i] = !isSelectedAZ[i];
                                });
                              } else {
                                setState(() {
                                  isSelectedAZ[i] = false;
                                });
                              }
                            }
                            if (index == 0 && isSelectedAZ[index]) {
                              ordering = "az";
                              if (!_domainBloc.isClosed) {
                                _domainBloc.add(GetPokemonList(
                                    generalQuery, ordering, types, favorite));
                              }
                            } else if (index == 1 && isSelectedAZ[index]) {
                              if (!_domainBloc.isClosed) {
                                ordering = "za";
                                _domainBloc.add(GetPokemonList(
                                    generalQuery, ordering, types, favorite));
                              }
                            } else if (!isSelectedAZ[0] && !isSelectedAZ[1]) {
                              if (!_domainBloc.isClosed) {
                                ordering = "";
                                _domainBloc.add(GetPokemonList(
                                    generalQuery, ordering, types, favorite));
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
                          isSelected: isSelectedTypes,
                          onPressed: (index) {
                            if (isSelectedTypes[index]) {
                              setState(() {
                                isSelectedTypes[index] =
                                    !isSelectedTypes[index];
                              });

                              removeTypes(index);
                              if (!_domainBloc.isClosed) {
                                _domainBloc.add(GetPokemonList(
                                    generalQuery, ordering, types, favorite));
                              }
                            } else if (allowedSelection()) {
                              setState(() {
                                isSelectedTypes[index] =
                                    !isSelectedTypes[index];
                              });

                              addTypes(index);
                              if (!_domainBloc.isClosed) {
                                _domainBloc.add(GetPokemonList(
                                    generalQuery, ordering, types, favorite));
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
                  create: (context) => _domainBloc,
                  child: BlocListener<DomainBloc, DomainState>(
                    listener: (context, state) {},
                    child: BlocBuilder<DomainBloc, DomainState>(
                      builder: (context, state) {
                        if (state is DomainStateLoadedPokemonList) {
                          pokemons = state.pokemons;
                          return Expanded(
                            child: RefreshIndicator(
                              onRefresh: _pullRefresh,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: pokemons!.length,
                                itemBuilder: (context, index) {
                                  if (!_domainBloc2.isClosed) {
                                    _domainBloc2.add(
                                        IsFavoriteEvent(pokemons![index].name));
                                  }

                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              detailRoute,
                                              arguments: pokemons![index]);
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 247, 242, 242),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
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
                                                        BlocProvider(
                                                          create: (context) =>
                                                              _domainBloc2,
                                                          child: BlocListener<
                                                              DomainBloc,
                                                              DomainState>(
                                                            listener: (context,
                                                                state) {},
                                                            child: BlocBuilder<
                                                                DomainBloc,
                                                                DomainState>(
                                                              builder: (context,
                                                                  state) {
                                                                if (state
                                                                    is DomainStateLoadedIsFavorite) {
                                                                  return IconButton(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      iconSize:
                                                                          50,
                                                                      onPressed:
                                                                          () async {
                                                                        if (!state
                                                                            .favorite) {
                                                                          setState(
                                                                              () {
                                                                            repo.insertFavorite(pokemons![index].name);
                                                                          });
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            repo.deleteFavorite(pokemons![index].name);
                                                                          });
                                                                        }
                                                                      },
                                                                      icon: state
                                                                              .favorite
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
                                                                          alignment: Alignment
                                                                              .center,
                                                                          child:
                                                                              CircularProgressIndicator()));
                                                                }
                                                              },
                                                            ),
                                                          ),
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
                                                      pokemons![index]
                                                          .sprites
                                                          .frontDefault!,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  82,
                                                                  207,
                                                                  86)
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Row(
                                                        children: [
                                                          const SizedBox(
                                                            width: 35,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              pokemons![index]
                                                                  .name,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 35,
                                                          ),
                                                          if (pokemons![index]
                                                                  .types
                                                                  .length <
                                                              2)
                                                            SizedBox(
                                                              height: 30,
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                      "assets/${pokemons![index].types[0].type!.name!}.png"),
                                                                ],
                                                              ), //
                                                            )
                                                          else
                                                            SizedBox(
                                                              height: 30,
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                      "assets/${pokemons![index].types[0].type!.name!}.png"),
                                                                  Image.asset(
                                                                      "assets/${pokemons![index].types[1].type!.name!}.png"),
                                                                ],
                                                              ), //
                                                            ),
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
