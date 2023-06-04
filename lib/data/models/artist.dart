class Artist {
  late int id;
  late String firstName;
  late String lastName;
  late String countryOfOrigin;
  late String mainArtType;
  String? artistDateOfBirth;
  late String shortDescription;
  String? artistImageLink;
  bool imageAvailableLocally = false;

  Artist(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.countryOfOrigin,
      required this.mainArtType,
      this.artistDateOfBirth,
      required this.shortDescription,
      this.artistImageLink});

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    countryOfOrigin = json['countryOfOrigin'];
    mainArtType = json['mainArtType'];
    artistDateOfBirth = json['artistDateOfBirth'];
    shortDescription = json['shortDescription'];
    artistImageLink = json['artistImageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['countryOfOrigin'] = this.countryOfOrigin;
    data['mainArtType'] = this.mainArtType;
    data['artistDateOfBirth'] = this.artistDateOfBirth;
    data['shortDescription'] = this.shortDescription;
    data['artistImageLink'] = this.artistImageLink;
    return data;
  }
}
