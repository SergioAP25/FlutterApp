import 'package:flutter/material.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';
import '../../constants/routes.dart';
import '../../services/repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PokemonRepository repo = PokemonRepository();
  Future<FilteredPokemonModel>? pokemon;

  Future<FilteredPokemonModel> getRandomPokemon() async {
    return await repo.getRandomPokemonFromDatabase();
  }

  Future<bool> _isFavorite(String name) async {
    return await repo.isFavorite(name);
  }

  @override
  void initState() {
    pokemon = getRandomPokemon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          FutureBuilder(
            future: pokemon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final pokemon = snapshot.data;
                return Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 300,
                        ),
                        FutureBuilder(
                          future: _isFavorite(pokemon!.name),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(pokemon.stats[0].baseStat);
                              print(pokemon.stats[0].baseStat!.toDouble());

                              final hp = pokemon.stats[0].baseStat;
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
                      child: SizedBox(
                        height: 525,
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
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FittedBox(
                              child: Container(
                                color: Colors.blue,
                                child: SizedBox(
                                  height: 200,
                                  width: 375,
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                              color: const Color.fromARGB(
                                                  255, 65, 208, 252),
                                              child: SizedBox(
                                                height: pokemon
                                                    .stats[0].baseStat!
                                                    .toDouble(),
                                                width: 35,
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
                                                width: 35,
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
                                                width: 35,
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
                                                width: 35,
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
                                                width: 35,
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
                                                width: 35,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        children: const [
                                          SizedBox(
                                            width: 20,
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
                                            width: 30,
                                          ),
                                          Text(
                                            "Defense",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "Special a...",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "Special ",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30,
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
                                      fontSize: 24,
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
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  pokemon.height.toString(),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Text(
                                  "Weight",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  pokemon.weight.toString(),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: const [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Lore ipsum",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
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
    );
  }
}
