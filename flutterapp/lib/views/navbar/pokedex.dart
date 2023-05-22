import 'package:flutter/material.dart';
import 'package:flutterapp/services/api/models/api_filtered_pokemon.dart';

import '../../services/repository.dart';

class Pokedex extends StatefulWidget {
  const Pokedex({super.key});

  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  PokemonRepository repo = PokemonRepository();

  Future<List<FilteredPokemonApiModel>> updateList() async {
    List<FilteredPokemonApiModel> aux = [];
    final allPokemons = await repo.getAllPokemons();
    for (var i = 0; i < allPokemons.results!.length; i++) {
      aux.add(await repo.getPokemonByUrl(allPokemons.results![i].url));
    }
    return aux;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<FilteredPokemonApiModel>> list = updateList();
    return Scaffold(
      body: Column(
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
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: 85,
                  child: ListView(
                    children: [
                      Image.asset("assets/azfilled.png"),
                      Image.asset("assets/zafilled.png"),
                      SizedBox(
                          height: 35, child: Image.asset("assets/line.png")),
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
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                FutureBuilder(
                  future: list,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final list = snapshot.data;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: list!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 238, 233, 233),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: GestureDetector(
                                      onTap: () {
                                        print("tapped:   " + list[index].name!);
                                      },
                                      child: Column(
                                        children: [
                                          Image.network(list[index]
                                              .sprites!
                                              .frontDefault!),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.green
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20))),
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        list[index].name!))),
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
