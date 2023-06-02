class ApplicationInformation {
  String? appName;
  String? title;
  String? redirectUrl;

  ApplicationInformation({this.appName, this.title, this.redirectUrl});

  ApplicationInformation.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    title = json['title'];
    redirectUrl = json['redirectUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appName'] = appName;
    data['title'] = title;
    data['redirectUrl'] = redirectUrl;
    return data;
  }
}
