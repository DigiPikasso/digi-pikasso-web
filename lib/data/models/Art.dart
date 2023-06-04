import 'package:digi_pikasso/data/models/Location.dart';
import 'package:digi_pikasso/data/models/artist.dart';

class Art {
  late int id;
  late String title;
  late ArtType artType;
  late Artist artist;
  late String medium;
  late String width;
  String? height;
  late String length;
  String? notes;
  late Location location;
  late String imageLink;
  String? description;
  String? numberOfAdditions;
  bool? coreArtFlag;

  Art.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    artType = new ArtType.fromJson(json['artType']);
    artist = new Artist.fromJson(json['artist']);
    medium = json['medium'];
    width = json['width'];
    height = json['height'];
    length = json['length'];
    notes = json['notes'];
    location = Location.fromJson(json['location']);
    imageLink = json['imageLink'];
    description = json['description'];
    numberOfAdditions = json['numberOfAdditions'];
    coreArtFlag = json['coreArtFlag'];
  }
}

class ArtType {
  late int id;
  late String name;

  ArtType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
