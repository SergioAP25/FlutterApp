import 'package:flutter/material.dart';
import 'package:flutterapp/services/api/models/api_filtered_pokemon.dart';
import 'package:flutterapp/util/generics/get_arguments.dart';

import '../constants/routes.dart';
import '../domain/models/filtered_pokemon_model.dart';

class DetailWindow extends StatefulWidget {
  const DetailWindow({super.key});

  @override
  State<DetailWindow> createState() => _DetailWindowState();
}

class _DetailWindowState extends State<DetailWindow> {
  @override
  Widget build(BuildContext context) {
    final pokemon = context.getArgument<FilteredPokemonModel>();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(fullSizeImageRoute,
                      arguments: pokemon.sprites.frontDefault);
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
                                  fontSize: 30, fontWeight: FontWeight.bold))),
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
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "TYPE 1",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "TYPE 2",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
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
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "0.00",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Weight",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "0.00",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
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
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Lore ipsum",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
