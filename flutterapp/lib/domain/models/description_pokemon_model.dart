import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/services/api/models/api_description_model.dart';
import 'package:flutterapp/services/database/models/database_description_model.dart';

@immutable
class DescriptionModel {
  final List<FlavorTextEntries> descriptions;

  const DescriptionModel(this.descriptions);

  static DescriptionModel fromApi(DescriptionApiModel description) {
    return DescriptionModel(description.flavorTextEntries!);
  }

  static DescriptionModel fromDatabase(DescriptionDatabaseModel description) {
    final descriptions =
        DescriptionApiModel.fromJson(jsonDecode(description.description))
            .flavorTextEntries;

    return DescriptionModel(descriptions!);
  }
}
