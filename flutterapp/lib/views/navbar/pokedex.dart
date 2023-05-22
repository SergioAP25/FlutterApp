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
                  width: 50,
                  child: ListView(
                    children: [
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ],
                  ),
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
                            return ListTile(
                              title: Text(list[index].name!),
                              leading: Image.network(
                                  list[index].sprites!.frontDefault!),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
