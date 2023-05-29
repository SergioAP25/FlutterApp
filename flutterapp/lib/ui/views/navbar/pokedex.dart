import 'package:flutter/material.dart';
import 'package:flutterapp/constants/routes.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';

import '../../../data/services/repository.dart';

class Pokedex extends StatefulWidget {
  const Pokedex({super.key});

  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  PokemonRepository repo = PokemonRepository();
  Future<List<FilteredPokemonModel>>? dblist;
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

  Future<bool> _isFavorite(String name) async {
    return await repo.isFavorite(name);
  }

  Future<void> _pullRefresh() async {
    setState(() {
      selectAssignSearchType(generalQuery, ordering, types);
    });
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

  void selectAssignSearchType(
      String query, String ordering, List<String> types) {
    Future<List<FilteredPokemonModel>>? aux;
    switch (ordering) {
      case "":
        switch (types.length) {
          case 0:
            aux = repo.getPokemonByNameFromDatabase(query);
            break;
          case 1:
            aux = repo.getPokemonByNameFilteredByTypeFromDatabase(
                query, types[0]);
            break;
          case 2:
            aux = repo.getPokemonByNameFilteredByMultiTypeFromDatabase(
                query, types[0], types[1]);
            break;
        }
        break;
      case "az":
        switch (types.length) {
          case 0:
            aux = repo.getPokemonByNameAZFromDatabase(query);
            break;

          case 1:
            aux = repo.getPokemonByNameFilteredByTypeFromDatabaseAZ(
                query, types[0]);
            break;
          case 2:
            aux = repo.getPokemonByNameFilteredByMultiTypeFromDatabaseAZ(
                query, types[0], types[1]);
            break;
        }
        break;
      case "za":
        switch (types.length) {
          case 0:
            aux = repo.getPokemonByNameZAFromDatabase(query);
            break;
          case 1:
            aux = repo.getPokemonByNameFilteredByTypeFromDatabaseZA(
                query, types[0]);
            break;
          case 2:
            aux = repo.getPokemonByNameFilteredByMultiTypeFromDatabaseZA(
                query, types[0], types[1]);
            break;
        }
        break;
    }
    setState(() {
      dblist = aux;
    });
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
    selectAssignSearchType(generalQuery, ordering, types);
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
    selectAssignSearchType(generalQuery, ordering, types);
  }

  @override
  void initState() {
    selectAssignSearchType(generalQuery, ordering, types);
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
              selectAssignSearchType(generalQuery, ordering, types);
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
                            setState(() {
                              for (int i = 0; i < isSelectedAZ.length; i++) {
                                if (i == index) {
                                  isSelectedAZ[i] = !isSelectedAZ[i];
                                } else {
                                  isSelectedAZ[i] = false;
                                }
                              }
                              if (index == 0 && isSelectedAZ[index]) {
                                ordering = "az";
                                selectAssignSearchType(
                                    generalQuery, ordering, types);
                              } else if (index == 1 && isSelectedAZ[index]) {
                                ordering = "za";
                                selectAssignSearchType(
                                    generalQuery, ordering, types);
                              } else if (!isSelectedAZ[0] && !isSelectedAZ[1]) {
                                ordering = "";
                                selectAssignSearchType(
                                    generalQuery, ordering, types);
                              }
                            });
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
                            setState(() {
                              if (isSelectedTypes[index]) {
                                isSelectedTypes[index] =
                                    !isSelectedTypes[index];
                                removeTypes(index);
                              } else if (allowedSelection()) {
                                isSelectedTypes[index] =
                                    !isSelectedTypes[index];
                                addTypes(index);
                              }
                            });
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
                FutureBuilder(
                  future: dblist,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final list = snapshot.data;
                      return Expanded(
                        child: RefreshIndicator(
                          onRefresh: _pullRefresh,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: list!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          detailRoute,
                                          arguments: list[index]);
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
                                                    FutureBuilder(
                                                      future: _isFavorite(
                                                          list[index].name),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return IconButton(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              iconSize: 50,
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  if (!snapshot
                                                                      .data!) {
                                                                    repo.insertFavorite(
                                                                        list[index]
                                                                            .name);
                                                                  } else {
                                                                    repo.deleteFavorite(
                                                                        list[index]
                                                                            .name);
                                                                  }
                                                                });
                                                              },
                                                              icon: snapshot
                                                                      .data!
                                                                  ? const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .yellow,
                                                                    )
                                                                  : const Icon(
                                                                      Icons
                                                                          .star_border,
                                                                      color: Colors
                                                                          .yellow,
                                                                    ));
                                                        } else {
                                                          return const Expanded(
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      CircularProgressIndicator()));
                                                        }
                                                      },
                                                    ),
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
                                                  list[index]
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
                                                      color:
                                                          const Color.fromARGB(
                                                                  255,
                                                                  82,
                                                                  207,
                                                                  86)
                                                              .withOpacity(0.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              bottomLeft: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 35,
                                                      ),
                                                      Text(list[index].name),
                                                      const SizedBox(
                                                        width: 35,
                                                      ),
                                                      if (list[index]
                                                              .types
                                                              .length <
                                                          2)
                                                        SizedBox(
                                                          height: 30,
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                  "assets/${list[index].types[0].type!.name!}.png"),
                                                            ],
                                                          ), //
                                                        )
                                                      else
                                                        SizedBox(
                                                          height: 30,
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                  "assets/${list[index].types[0].type!.name!}.png"),
                                                              Image.asset(
                                                                  "assets/${list[index].types[1].type!.name!}.png"),
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
