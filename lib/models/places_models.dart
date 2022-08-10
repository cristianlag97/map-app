// To parse this JSON data, do
//
//     final placesResponce = placesResponceFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class PlacesResponce {
  PlacesResponce({
    required this.type,
    // required this.query,
    required this.features,
    required this.attribution,
  });

  final String type;
  // final List<String> query;
  final List<Feature> features;
  final String attribution;

  factory PlacesResponce.fromJson(String str) => PlacesResponce.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacesResponce.fromMap(Map<String, dynamic> json) => PlacesResponce(
    type: json["type"],
    // query: List<String>.from(json["query"].map((x) => x)),
    features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
    attribution: json["attribution"],
  );

  Map<String, dynamic> toMap() => {
    "type": type,
    // "query": List<dynamic>.from(query.map((x) => x)),
    "features": List<dynamic>.from(features.map((x) => x.toMap())),
    "attribution": attribution,
  };
}

class Feature {
  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.properties,
    required this.textEs,
    required this.placeNameEs,
    required this.text,
    required this.placeName,
    required this.center,
    required this.geometry,
    required this.context,
    // required this.languageEs,
    required this.language,
    required this.matchingText,
    required this.matchingPlaceName,
  });

  final String id;
  final String type;
  final List<String> placeType;
  final Properties properties;
  final String textEs;
  final String placeNameEs;
  final String text;
  final String placeName;
  final List<double> center;
  final Geometry geometry;
  final List<Context> context;
  // final Language? languageEs;
  final Language? language;
  final String? matchingText;
  final String? matchingPlaceName;

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
    id: json["id"],
    type: json["type"],
    placeType: List<String>.from(json["place_type"].map((x) => x)),
    properties: Properties.fromMap(json["properties"]),
    textEs: json["text_es"],
    placeNameEs: json["place_name_es"],
    text: json["text"],
    placeName: json["place_name"],
    center: List<double>.from(json["center"].map((x) => x.toDouble())),
    geometry: Geometry.fromMap(json["geometry"]),
    context: List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
    // languageEs: json["language_es"] == null ? null : languageValues.map[json["language_es"]],
    language: json["language"] == null ? null : languageValues.map[json["language"]],
    matchingText: json["matching_text"],
    matchingPlaceName: json["matching_place_name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "type": type,
    "place_type": List<dynamic>.from(placeType.map((x) => x)),
    "properties": properties.toMap(),
    "text_es": textEs,
    "place_name_es": placeNameEs,
    "text": text,
    "place_name": placeName,
    "center": List<dynamic>.from(center.map((x) => x)),
    "geometry": geometry.toMap(),
    "context": List<dynamic>.from(context.map((x) => x.toMap())),
    // "language_es": languageEs == null ? null : languageValues.reverse[languageEs],
    "language": language == null ? null : languageValues.reverse[language],
    "matching_text": matchingText,
    "matching_place_name": matchingPlaceName,
  };

  @override
  String toString() {
    return 'Feature: ${text}';
  }

}

class Context {
  Context({
    required this.id,
    required this.textEs,
    required this.text,
    required this.wikidata,
    // required this.languageEs,
    required this.language,
    required this.shortCode,
  });

  final String id;
  final String textEs;
  final String text;
  final String? wikidata;
  // final Language? languageEs;
  final Language? language;
  final String? shortCode;

  factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Context.fromMap(Map<String, dynamic> json) => Context(
    id: json["id"],
    textEs: json["text_es"],
    text: json["text"],
    wikidata: json["wikidata"],
    // languageEs: json["language_es"] == null ? null : languageValues.map[json["language_es"]],
    language: json["language"] == null ? null : languageValues.map[json["language"]],
    shortCode: json["short_code"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "text_es": textEs,
    "text": text,
    "wikidata": wikidata,
    // "language_es": languageEs == null ? null : languageValues.reverse[languageEs],
    "language": language == null ? null : languageValues.reverse[language],
    "short_code": shortCode,
  };
}

enum Language { ES }

final languageValues = EnumValues({
  "es": Language.ES
});

class Geometry {
  Geometry({
    required this.coordinates,
    required this.type,
  });

  final List<double> coordinates;
  final String type;

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    type: json["type"],
  );

  Map<String, dynamic> toMap() => {
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "type": type,
  };
}

class Properties {
  Properties({
    required this.foursquare,
    required this.landmark,
    required this.address,
    required this.category,
    required this.maki,
    required this.wikidata,
  });

  final String? foursquare;
  final bool? landmark;
  final String? address;
  final String? category;
  final String? maki;
  final String? wikidata;

  factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
    foursquare: json["foursquare"],
    landmark: json["landmark"],
    address: json["address"],
    category: json["category"],
    maki: json["maki"],
    wikidata: json["wikidata"],
  );

  Map<String, dynamic> toMap() => {
    "foursquare": foursquare,
    "landmark": landmark,
    "address": address,
    "category": category,
    "maki": maki,
    "wikidata": wikidata,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) =>  MapEntry(v, k));
    return reverseMap!;
  }
}
