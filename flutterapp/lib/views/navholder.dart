import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

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
  static final List<Widget> _screens = <Widget>[
    const Home(),
    const Pokedex(),
    const Favorites(),
    const Options(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: GNav(
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          gap: 20,
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.search,
              text: "Pokédex",
            ),
            GButton(
              icon: Icons.favorite,
              text: "Favorites",
            ),
            GButton(
              icon: Icons.settings,
              text: "Options",
            ),
          ]),
    );
  }
}
