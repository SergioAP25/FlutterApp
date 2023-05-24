import 'package:flutter/material.dart';
import 'package:flutterapp/constants/routes.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';

import '../../services/repository.dart';

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

  Future<void> _pullRefresh() async {
    setState(() {});
  }

  Future<List<FilteredPokemonModel>> getPokemonsByName(String name) async {
    return await repo.getPokemonByNameFromDatabase(name);
  }

  void updateQuery(String query) {
    setState(() {
      dblist = getPokemonsByName(query);
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

  @override
  void initState() {
    dblist = getPokemonsByName("");
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
              updateQuery(query);
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
                              } else if (allowedSelection()) {
                                isSelectedTypes[index] =
                                    !isSelectedTypes[index];
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
                                            Image.network(
                                              list[index].sprites.frontDefault!,
                                              fit: BoxFit.contain,
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: const Color.fromARGB(
                                                              255, 82, 207, 86)
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      20))),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child:
                                                          Text(list[index].name))),
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
