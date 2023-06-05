import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/domain/bloc/domain_event.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';
import '../../../constants/routes.dart';
import '../../../domain/bloc/domain_bloc.dart';
import '../../../domain/bloc/domain_state.dart';
import '../../../domain/models/description_pokemon_model.dart';
import '../../constants/view_selections.dart';

class DetailView extends StatefulWidget {
  final String view;
  const DetailView({super.key, required this.view});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  FilteredPokemonModel? _pokemon;
  List<Object>? _args;
  Function? _updateSearchView;
  bool? _favorite;
  String? _description;
  String? _view;

  final DomainBloc _randomPokemonBloc = DomainBloc();
  final DomainBloc _favoriteBloc = DomainBloc();
  final DomainBloc _descriptionBloc = DomainBloc();

  Future<void> _pullRefresh() async {
    if (_view == home) {
      if (!_randomPokemonBloc.isClosed) {
        _randomPokemonBloc.add(const GetRandomPokemonEvent());
      }
    }
  }

  void _assignList(FilteredPokemonModel statePokemon) {
    if (_view == home) {
      _pokemon = statePokemon;
    } else if (_view == detail) {
      _args = ModalRoute.of(context)!.settings.arguments as List<Object>;
      _pokemon = _args![0] as FilteredPokemonModel;
      _updateSearchView = _args![1] as Function;
    }
  }

  String? _getEnglishDescription(DescriptionModel? description) {
    String? englishDescription = "";
    for (int i = 0; i < description!.description.length; i++) {
      if (description.description[i].language!.name == "en") {
        englishDescription =
            description.description[i].flavorText!.replaceAll("\n", " ");
        break;
      }
    }
    return englishDescription;
  }

  @override
  void initState() {
    _view = widget.view;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_randomPokemonBloc.isClosed) {
      _randomPokemonBloc.add(const GetRandomPokemonEvent());
    }
    return BlocProvider(
      create: (context) => _randomPokemonBloc,
      child: BlocBuilder<DomainBloc, DomainState>(
        builder: (context, state) {
          if (state is DomainStateLoadedRandomPokemon) {
            _assignList(state.pokemon);
            if (!_descriptionBloc.isClosed) {
              _descriptionBloc.add(GetDescriptionEvent(_pokemon!.name));
            }

            if (!_favoriteBloc.isClosed) {
              _favoriteBloc.add(IsFavoriteEvent(_pokemon!.name));
            }
            return Scaffold(
              body: RefreshIndicator(
                onRefresh: _pullRefresh,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 300,
                              ),
                              BlocProvider.value(
                                value: _favoriteBloc,
                                child: BlocBuilder<DomainBloc, DomainState>(
                                  builder: (context, state) {
                                    if (state is DomainStateLoadedIsFavorite) {
                                      _favorite = state.favorite;
                                      return IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          iconSize: 55,
                                          onPressed: () async {
                                            if (!_favorite!) {
                                              if (!_favoriteBloc.isClosed) {
                                                _favoriteBloc.add(
                                                    AddFavoriteEvent(
                                                        _pokemon!.name));
                                                if (_view == detail) {
                                                  _updateSearchView!();
                                                }
                                              }
                                            } else {
                                              if (!_favoriteBloc.isClosed) {
                                                _favoriteBloc.add(
                                                    RemoveFavoriteEvent(
                                                        _pokemon!.name));
                                                if (_view == detail) {
                                                  _updateSearchView!();
                                                }
                                              }
                                            }
                                          },
                                          icon: _favorite!
                                              ? const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                )
                                              : const Icon(
                                                  Icons.star_border,
                                                  color: Colors.yellow,
                                                ));
                                    } else {
                                      return Row(
                                        children: const [
                                          SizedBox(
                                            height: 71,
                                          )
                                        ],
                                      );
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  fullSizeImageRoute,
                                  arguments: _pokemon!.sprites.frontDefault!);
                            },
                            child: SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Image.network(
                                _pokemon!.sprites.frontDefault!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 247, 242, 242),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(_pokemon!.name,
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
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    color: const Color.fromARGB(
                                        255, 247, 242, 242),
                                    child: SizedBox(
                                      height: 280,
                                      width: 375,
                                      child: Column(
                                        children: [
                                          const Spacer(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              const SizedBox(
                                                width: 22,
                                              ),
                                              Container(
                                                  color: const Color.fromARGB(
                                                      255, 65, 208, 252),
                                                  child: SizedBox(
                                                    height: _pokemon!
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
                                                    height: _pokemon!
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
                                                    height: _pokemon!
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
                                                    height: _pokemon!
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
                                                    height: _pokemon!
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
                                                    height: _pokemon!
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
                                      if (_pokemon!.types.length < 2)
                                        SizedBox(
                                          height: 40,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  "assets/${_pokemon!.types[0].type!.name!}.png"),
                                            ],
                                          ), //
                                        )
                                      else
                                        SizedBox(
                                          height: 40,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  "assets/${_pokemon!.types[0].type!.name!}.png"),
                                              Image.asset(
                                                  "assets/${_pokemon!.types[1].type!.name!}.png"),
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
                                        "${(_pokemon!.height / 10).toString()} m",
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
                                        "${_pokemon!.weight.toString()} kg",
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  BlocProvider.value(
                                    value: _descriptionBloc,
                                    child: BlocBuilder<DomainBloc, DomainState>(
                                      builder: (context, state) {
                                        if (state
                                            is DomainStateLoadedDescription) {
                                          _description = _getEnglishDescription(
                                              state.description);
                                          return Column(
                                            children: [
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Description",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _description!,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              )
                                            ],
                                          );
                                        } else {
                                          return const Align(
                                              alignment: Alignment.center,
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
