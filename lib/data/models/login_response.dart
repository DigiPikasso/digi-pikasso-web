abstract class LoginResponse {}

class SuccessLoginResponse extends LoginResponse {
  late String successLoginCode;

  SuccessLoginResponse(this.successLoginCode);

  SuccessLoginResponse.fromJson(Map<String, dynamic> json) {
    successLoginCode = json['successLoginCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['successLoginCode'] = successLoginCode;
    return data;
  }
}

class FailedLoginResponse extends LoginResponse {
  late String error;

  FailedLoginResponse(this.error);

  FailedLoginResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    return data;
  }
}
