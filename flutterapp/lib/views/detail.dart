import 'package:flutter/material.dart';
import 'package:flutterapp/util/generics/get_arguments.dart';

import '../constants/routes.dart';
import '../domain/models/filtered_pokemon_model.dart';
import '../services/repository.dart';

class DetailWindow extends StatefulWidget {
  const DetailWindow({super.key});

  @override
  State<DetailWindow> createState() => _DetailWindowState();
}

class _DetailWindowState extends State<DetailWindow> {
  PokemonRepository repo = PokemonRepository();

  Future<bool> _isFavorite(String name) async {
    return await repo.isFavorite(name);
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = context.getArgument<FilteredPokemonModel>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            FutureBuilder(
              future:
                  repo.getPokemonDescriptionByNameFromDatabase(pokemon!.name),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final description = snapshot.data;
                  return Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 300,
                          ),
                          FutureBuilder(
                            future: _isFavorite(pokemon.name),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    iconSize: 55,
                                    onPressed: () async {
                                      setState(() {
                                        if (!snapshot.data!) {
                                          repo.insertFavorite(pokemon.name);
                                        } else {
                                          repo.deleteFavorite(pokemon.name);
                                        }
                                      });
                                    },
                                    icon: snapshot.data!
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
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(fullSizeImageRoute,
                              arguments: pokemon.sprites.frontDefault!);
                        },
                        child: SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(
                            pokemon.sprites.frontDefault!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 247, 242, 242),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Text(pokemon.name,
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold))),
                            const SizedBox(
                              height: 15,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Base stats",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FittedBox(
                              child: Container(
                                color: const Color.fromARGB(255, 247, 242, 242),
                                child: SizedBox(
                                  height: 200,
                                  width: 375,
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 22,
                                          ),
                                          Container(
                                              color: const Color.fromARGB(
                                                  255, 65, 208, 252),
                                              child: SizedBox(
                                                height: pokemon
                                                    .stats[0].baseStat!
                                                    .toDouble(),
                                                width: 45,
                                              )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                              color: const Color.fromARGB(
                                                  255, 231, 48, 48),
                                              child: SizedBox(
                                                height: pokemon
                                                    .stats[1].baseStat!
                                                    .toDouble(),
                                                width: 45,
                                              )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                              color: const Color.fromARGB(
                                                  255, 245, 170, 58),
                                              child: SizedBox(
                                                height: pokemon
                                                    .stats[2].baseStat!
                                                    .toDouble(),
                                                width: 45,
                                              )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                              color: const Color.fromARGB(
                                                  255, 25, 226, 35),
                                              child: SizedBox(
                                                height: pokemon
                                                    .stats[3].baseStat!
                                                    .toDouble(),
                                                width: 45,
                                              )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                              color: const Color.fromARGB(
                                                  255, 224, 100, 42),
                                              child: SizedBox(
                                                height: pokemon
                                                    .stats[4].baseStat!
                                                    .toDouble(),
                                                width: 45,
                                              )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                              color: const Color.fromARGB(
                                                  255, 29, 15, 219),
                                              child: SizedBox(
                                                height: pokemon
                                                    .stats[5].baseStat!
                                                    .toDouble(),
                                                width: 45,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: const [
                                          SizedBox(
                                            width: 42,
                                          ),
                                          Text(
                                            "Hp",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "Attack",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "Defense",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Special a...",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Special ...",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            "Speed",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Types",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                if (pokemon.types.length < 2)
                                  SizedBox(
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            "assets/${pokemon.types[0].type!.name!}.png"),
                                      ],
                                    ), //
                                  )
                                else
                                  SizedBox(
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            "assets/${pokemon.types[0].type!.name!}.png"),
                                        Image.asset(
                                            "assets/${pokemon.types[1].type!.name!}.png"),
                                      ],
                                    ), //
                                  ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Height:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "${(pokemon.height / 10).toString()} m",
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Text(
                                  "Weight",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "${pokemon.weight.toString()} kg",
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            FutureBuilder(
                              future:
                                  repo.getPokemonDescriptionByNameFromDatabase(
                                      pokemon.name),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Description",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          snapshot
                                              .data!.description[0].flavorText!,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
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
                    ],
                  );
                } else {
                  return const Expanded(
                      child: Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
