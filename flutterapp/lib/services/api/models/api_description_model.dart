class DescriptionApiModel {
  List<FlavorTextEntries>? flavorTextEntries;

  DescriptionApiModel({this.flavorTextEntries});

  DescriptionApiModel.fromJson(Map<String, dynamic> json) {
    if (json['flavor_text_entries'] != null) {
      flavorTextEntries = <FlavorTextEntries>[];
      json['flavor_text_entries'].forEach((v) {
        flavorTextEntries!.add(new FlavorTextEntries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.flavorTextEntries != null) {
      data['flavor_text_entries'] =
          this.flavorTextEntries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FlavorTextEntries {
  String? flavorText;
  Language? language;

  FlavorTextEntries({this.flavorText, this.language});

  FlavorTextEntries.fromJson(Map<String, dynamic> json) {
    flavorText = json['flavor_text'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flavor_text'] = this.flavorText;
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    return data;
  }
}

class Language {
  String? name;

  Language({this.name});

  Language.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
