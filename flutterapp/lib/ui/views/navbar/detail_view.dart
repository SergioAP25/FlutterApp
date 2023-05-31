import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/domain/bloc/domain_event.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';
import 'package:flutterapp/util/generics/get_arguments.dart';
import '../../../constants/routes.dart';
import '../../../data/services/repository.dart';
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
  final DomainBloc _randomPokemonBloc = DomainBloc();
  final DomainBloc _favoriteBloc = DomainBloc();
  final DomainBloc _descriptionBloc = DomainBloc();
  bool? favorite;
  PokemonRepository repo = PokemonRepository();
  FilteredPokemonModel? pokemon;
  DescriptionModel? description;

  void assignList(FilteredPokemonModel statePokemon) {
    if (widget.view == home) {
      pokemon = statePokemon;
    } else if (widget.view == detail) {
      pokemon = context.getArgument<FilteredPokemonModel>();
    }
  }

  Future<void> _pullRefresh() async {
    if (widget.view == home) {
      if (!_randomPokemonBloc.isClosed) {
        _randomPokemonBloc.add(const GetRandomPokemonEvent());
      }
    }
  }

  @override
  void initState() {
    if (!_randomPokemonBloc.isClosed) {
      _randomPokemonBloc.add(const GetRandomPokemonEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _randomPokemonBloc,
      child: BlocListener<DomainBloc, DomainState>(
        listener: (context, state) {},
        child: BlocBuilder<DomainBloc, DomainState>(
          builder: (context, state) {
            if (state is DomainStateLoadedRandomPokemon) {
              assignList(state.pokemon);
              if (!_descriptionBloc.isClosed) {
                _descriptionBloc.add(GetDescriptionEvent(pokemon!.name));
              }

              if (!_favoriteBloc.isClosed) {
                _favoriteBloc.add(IsFavoriteEvent(pokemon!.name));
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
                                BlocProvider(
                                  create: (context) => _favoriteBloc,
                                  child: BlocListener<DomainBloc, DomainState>(
                                    listener: (context, state) {},
                                    child: BlocBuilder<DomainBloc, DomainState>(
                                      builder: (context, state) {
                                        if (state
                                            is DomainStateLoadedIsFavorite) {
                                          favorite = state.favorite;
                                          return IconButton(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              iconSize: 55,
                                              onPressed: () async {
                                                if (!favorite!) {
                                                  if (!_favoriteBloc.isClosed) {
                                                    _favoriteBloc.add(
                                                        AddFavoriteEvent(
                                                            pokemon!.name));
                                                  }
                                                } else {
                                                  if (!_favoriteBloc.isClosed) {
                                                    _favoriteBloc.add(
                                                        RemoveFavoriteEvent(
                                                            pokemon!.name));
                                                  }
                                                }
                                              },
                                              icon: favorite!
                                                  ? const Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                    )
                                                  : const Icon(
                                                      Icons.star_border,
                                                      color: Colors.yellow,
                                                    ));
                                        } else {
                                          return const Align(
                                              alignment: Alignment.center,
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    fullSizeImageRoute,
                                    arguments: pokemon!.sprites.frontDefault!);
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
                                        child: Text(pokemon!.name,
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
                                                      height: pokemon!
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
                                                      height: pokemon!
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
                                                      height: pokemon!
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
                                                      height: pokemon!
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
                                                      height: pokemon!
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
                                                      height: pokemon!
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
                                        if (pokemon!.types.length < 2)
                                          SizedBox(
                                            height: 40,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                    "assets/${pokemon!.types[0].type!.name!}.png"),
                                              ],
                                            ), //
                                          )
                                        else
                                          SizedBox(
                                            height: 40,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                    "assets/${pokemon!.types[0].type!.name!}.png"),
                                                Image.asset(
                                                    "assets/${pokemon!.types[1].type!.name!}.png"),
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
                                          "${(pokemon!.height / 10).toString()} m",
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
                                          "${pokemon!.weight.toString()} kg",
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    BlocListener<DomainBloc, DomainState>(
                                      listener: (context, state) {},
                                      child: BlocProvider(
                                        create: (context) => _descriptionBloc,
                                        child: BlocBuilder<DomainBloc,
                                            DomainState>(
                                          builder: (context, state) {
                                            if (state
                                                is DomainStateLoadedDescription) {
                                              description = state.description;
                                              return Column(
                                                children: [
                                                  const Align(
                                                    alignment:
                                                        Alignment.centerLeft,
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      description!
                                                          .description[0]
                                                          .flavorText!,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
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
      ),
    );
  }
}
