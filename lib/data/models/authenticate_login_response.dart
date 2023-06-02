class AuthenticateLoginResponse {
  late String redirectUrl;

  AuthenticateLoginResponse(this.redirectUrl);

  AuthenticateLoginResponse.fromJson(Map<String, dynamic> json) {
    redirectUrl = json['redirectUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['redirectUrl'] = redirectUrl;
    return data;
  }
}
