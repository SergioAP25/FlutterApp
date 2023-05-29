import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/data/services/api/models/api_description_model.dart';
import 'package:flutterapp/data/services/database/models/database_description_model.dart';

@immutable
class DescriptionModel {
  final List<FlavorTextEntries> description;

  const DescriptionModel(this.description);

  static DescriptionModel fromApi(DescriptionApiModel description) {
    return DescriptionModel(description.flavorTextEntries!);
  }

  static DescriptionModel fromDatabase(DescriptionDatabaseModel description) {
    final List<FlavorTextEntries> descriptions = [];
    final List<dynamic> flavorTextEntries = jsonDecode(description.description);
    for (var i = 0; i < flavorTextEntries.length; i++) {
      descriptions.add(FlavorTextEntries.fromJson(flavorTextEntries[i]));
    }
    return DescriptionModel(descriptions);
  }
}
