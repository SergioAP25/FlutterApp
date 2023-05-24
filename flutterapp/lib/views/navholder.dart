import 'package:flutter/material.dart';

import '../services/repository.dart';
import 'navbar/home.dart';
import 'navbar/options.dart';
import 'navbar/pokedex.dart';
import 'navbar/favorites.dart';

class NavHolder extends StatefulWidget {
  const NavHolder({super.key});

  @override
  State<NavHolder> createState() => _NavHolderState();
}

class _NavHolderState extends State<NavHolder> {
  int _selectedIndex = 0;
  PokemonRepository repo = PokemonRepository();

  static final List<Widget> _screens = <Widget>[
    const Home(),
    const Pokedex(),
    const Favorites(),
    const Options(),
  ];

  Future<void> updateDB() async {
    final allPokemons = await repo.getAllPokemons();
    debugPrint("Starting db update");
    for (var i = 0; i < allPokemons.results.length; i++) {
      final pokemon = await repo.getPokemonByUrl(allPokemons.results[i].url);
      repo.insertPokemon(pokemon);
    }
    debugPrint("Finished db update");
  }

  @override
  void initState() {
    updateDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: const Color.fromARGB(255, 41, 41, 41),
          unselectedItemColor: const Color.fromARGB(255, 41, 41, 41),
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/pokedex.png")),
              label: "Pokédex",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Options",
            ),
          ]),
    );
  }
}
