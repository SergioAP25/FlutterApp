import 'package:flutter/cupertino.dart';

@immutable
abstract class DomainEvent {
  const DomainEvent();
}

class GetPokemonList extends DomainEvent {
  final String query;
  final String ordering;
  final List<String> types;
  final String view;

  const GetPokemonList(this.query, this.ordering, this.types, this.view);
}

class GetRandomPokemonEvent extends DomainEvent {
  const GetRandomPokemonEvent();
}

class GetDescriptionEvent extends DomainEvent {
  final String name;
  const GetDescriptionEvent(this.name);
}

class AddFavoriteEvent extends DomainEvent {
  final String name;
  const AddFavoriteEvent(this.name);
}

class RemoveFavoriteEvent extends DomainEvent {
  final String name;
  const RemoveFavoriteEvent(this.name);
}

class IsFavoriteEvent extends DomainEvent {
  final String name;
  const IsFavoriteEvent(this.name);
}
