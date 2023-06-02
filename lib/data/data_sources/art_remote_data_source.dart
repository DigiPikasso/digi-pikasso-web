import 'dart:convert';
import 'package:digi_pikasso/config/constants.dart';
import 'package:digi_pikasso/data/models/application_info.dart';
import 'package:digi_pikasso/data/models/authenticate_login_response.dart';
import 'package:digi_pikasso/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:digi_pikasso/data/models/login_response.dart';

class ArtRemoteDataSource {
  void validateAuthCode(String authCode) {}
  Future<Either<Failure, ApplicationInformation>> retrieveApplicationInfo(
      String appName) async {
    try {
      final response = await http.get(
        Uri.parse('$kBackendUrl/Account/Application/$appName'),
      );
      if (response.statusCode == 200) {
        return Right(
            ApplicationInformation.fromJson(jsonDecode(response.body)));
      } else {
        return Left(
          APIFailure(
            jsonDecode(response.body)['error'],
          ),
        );
      }
    } catch (e) {
      return Left(
        APIFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<LoginResponse> login(
      String username, String password, String appName) async {
    final response = await http.post(
      Uri.parse('$kBackendUrl/Account/Application/Login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'appName': appName, 'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      return SuccessLoginResponse.fromJson(jsonDecode(response.body));
    } else {
      return FailedLoginResponse.fromJson(jsonDecode(response.body));
    }
  }

  Future<Either<Failure, AuthenticateLoginResponse>> authenticateLogin(
      String successLoginCode) async {
    final response = await http
        .post(
      Uri.parse('$kBackendUrl/Account/Application/AuthenticateLogin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'successLoginCode': successLoginCode}),
    )
        .timeout(
      const Duration(seconds: 120),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response('{"error": "Request has timed out"}', 408);
      },
    );
    if (response.statusCode == 200) {
      return Right(
          AuthenticateLoginResponse.fromJson(jsonDecode(response.body)));
    } else {
      return Left(
        APIFailure(
          jsonDecode(response.body)['error'],
        ),
      );
    }
  }
}
