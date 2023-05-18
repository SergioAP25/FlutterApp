import 'package:flutter/cupertino.dart';
import 'package:flutterapp/services/database/constants/database_constants.dart';

@immutable
class DescriptionDatabaseModel {
  final int descriptionId;
  final String description;

  const DescriptionDatabaseModel(this.descriptionId, this.description);

  DescriptionDatabaseModel.fromRow(Map<String, Object?> map)
      : descriptionId = map[descriptionIdColumn] as int,
        description = map[descriptionColumn] as String;
}
