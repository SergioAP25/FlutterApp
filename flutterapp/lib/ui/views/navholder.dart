import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/domain/bloc/domain_event.dart';
import 'package:flutterapp/ui/constants/view_selections.dart';
import '../../data/services/auth/auth_user.dart';
import '../../domain/bloc/domain_bloc.dart';
import '../../domain/bloc/domain_state.dart';
import 'navbar/detail_view.dart';
import 'navbar/options.dart';
import 'navbar/search_view.dart';

class NavHolder extends StatefulWidget {
  final AuthUser user;
  const NavHolder({Key? key, required this.user}) : super(key: key);

  @override
  State<NavHolder> createState() => _NavHolderState();
}

class _NavHolderState extends State<NavHolder> {
  late AuthUser user;

  int _selectedIndex = 0;

  late List<GlobalKey<SearchViewState>> _searchViewKeys;

  List<Widget> _screens = [];

  final DomainBloc _getPokemonsBloc = DomainBloc();

  @override
  void initState() {
    super.initState();
    user = widget.user;

    _searchViewKeys = List<GlobalKey<SearchViewState>>.generate(
        2, (_) => GlobalKey<SearchViewState>());

    _screens = [
      const DetailView(view: home),
      SearchView(key: _searchViewKeys[0], view: pokedex),
      SearchView(key: _searchViewKeys[1], view: favorites),
      Options(user: user),
    ];

    _getPokemonsBloc.add(const GetPokemonsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getPokemonsBloc,
      child: BlocBuilder<DomainBloc, DomainState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(index: _selectedIndex, children: _screens),
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: const Color.fromARGB(255, 41, 41, 41),
              unselectedItemColor: const Color.fromARGB(255, 41, 41, 41),
              type: BottomNavigationBarType.shifting,
              currentIndex: _selectedIndex,
              onTap: (index) {
                switch (index) {
                  case 0:
                    _screens.removeAt(0);

                    _screens.insert(
                      0,
                      // If this line was constant info wouldn't change
                      // when entering home
                      // ignore: prefer_const_constructors
                      DetailView(view: home),
                    );
                    break;

                  case 1:
                    _screens.removeAt(1);

                    _screens.insert(
                      1,
                      SearchView(key: _searchViewKeys[0], view: pokedex),
                    );
                    break;
                  case 2:
                    _screens.removeAt(2);

                    _screens.insert(
                      2,
                      SearchView(key: _searchViewKeys[1], view: favorites),
                    );
                    break;
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
              ],
            ),
          );
        },
      ),
    );
  }
}
