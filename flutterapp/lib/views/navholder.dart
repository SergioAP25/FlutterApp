import 'package:flutter/material.dart';
import 'package:flutterapp/domain/get_pokemons.dart';

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
  GetPokemons get = GetPokemons();

  static final List<Widget> _screens = <Widget>[
    const Home(),
    const Pokedex(),
    const Favorites(),
    const Options(),
  ];

  @override
  void initState() {
    get.getPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: const Color.fromARGB(255, 41, 41, 41),
          unselectedItemColor: const Color.fromARGB(255, 41, 41, 41),
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index == 0) {
              _screens.removeAt(0);
              _screens.insert(0, Home());
            }
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
