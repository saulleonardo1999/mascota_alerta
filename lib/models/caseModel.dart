
import 'dart:convert';

CaseModel caseModelFromJson(String str) => CaseModel.fromJson(json.decode(str));

String caseModelToJson(CaseModel data) => json.encode(data.toJson());

class CaseModel {
  CaseModel({
    this.id,
    this.name,
    this.description,
    this.animalType,
    this.caseType,
    this.photo,
    this.latitude,
    this.longitude,
  });

  String id;
  String name;
  String description;
  String animalType;
  int caseType;
  String photo;
  String latitude;
  String longitude;

  factory CaseModel.fromJson(Map<String, dynamic> json) => CaseModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    animalType: json["animal_type"],
    caseType: json["case_type"],
    photo: json["photo"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "animal_type": animalType,
    "case_type": caseType,
    "photo": photo,
    "latitude": latitude,
    "longitude": longitude,
  };
}
