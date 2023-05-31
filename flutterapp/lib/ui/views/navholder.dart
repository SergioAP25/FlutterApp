import 'package:flutter/material.dart';
import 'package:flutterapp/domain/get_pokemons.dart';
import 'package:flutterapp/ui/constants/view_selections.dart';
import '../../data/services/auth/auth_user.dart';
import '../../data/services/repository.dart';
import 'navbar/detail_view.dart';
import 'navbar/options.dart';
import 'navbar/search_view.dart';

class NavHolder extends StatefulWidget {
  final AuthUser user;
  const NavHolder({super.key, required this.user});

  @override
  State<NavHolder> createState() => _NavHolderState();
}

class _NavHolderState extends State<NavHolder> {
  late final AuthUser user;

  int _selectedIndex = 0;
  PokemonRepository repo = PokemonRepository();
  GetPokemons get = GetPokemons();

  static List<Widget> _screens = [];

  @override
  void initState() {
    user = widget.user;
    _screens = <Widget>[
      DetailView(view: home),
      SearchView(
        view: pokedex,
      ),
      SearchView(
        view: favorites,
      ),
      Options(user: user),
    ];
    get.getPokemons();
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
