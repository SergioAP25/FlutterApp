import 'package:flutter/material.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';

import '../../constants/routes.dart';
import '../../domain/get_pokemons.dart';
import '../../services/api/models/api_filtered_pokemon.dart';
import '../../services/repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PokemonRepository repo = PokemonRepository();
  Future<FilteredPokemonModel>? pokemon;
  GetPokemons get = GetPokemons();

  Future<FilteredPokemonModel> getRandomPokemon() async {
    return await repo.getRandomPokemonFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    get.getPokemons();
    pokemon = getRandomPokemon();
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(fullSizeImageRoute,
                            arguments: pokemon.sprites.frontDefault!);
                      },
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          pokemon!.sprites.frontDefault!,
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
                            Container(
                              color: Colors.blue,
                              child: SizedBox(
                                height: 200,
                                width: 350,
                                child: Column(
                                  children: [
                                    const Spacer(),
                                    Row(
                                      children: [],
                                    ),
                                    Row(
                                      children: const [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Hp",
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Attack",
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Defense",
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Special attack",
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Special defense",
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
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: const [
                                Text(
                                  "Types",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "TYPE 1",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "TYPE 2",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: const [
                                Text(
                                  "Height:",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "0.00",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "Weight",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "0.00",
                                  style: TextStyle(
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
