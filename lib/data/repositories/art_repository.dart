import 'package:digi_pikasso/data/data_sources/art_remote_data_source.dart';
import 'package:digi_pikasso/data/models/application_info.dart';
import 'package:digi_pikasso/data/models/authenticate_login_response.dart';
import 'package:digi_pikasso/data/models/login_response.dart';
import 'package:digi_pikasso/error/failures.dart';
import 'package:dartz/dartz.dart';

class ArtRepository {
  final ArtRemoteDataSource remoteDataSource;
  String? artId;

  ArtRepository(this.remoteDataSource);

  Future<Either<Failure, ApplicationInformation>> retrieveApplicationInfo(
          String appName) =>
      remoteDataSource.retrieveApplicationInfo(appName);

  Future<LoginResponse> login(
          String username, String password, String appName) =>
      remoteDataSource.login(username, password, appName);

  Future<Either<Failure, AuthenticateLoginResponse>> authenticateLogin(
          String successLoginCode) =>
      remoteDataSource.authenticateLogin(successLoginCode);
}
