import 'package:digi_pikasso/data/models/application_info.dart';
import 'package:digi_pikasso/data/models/login_response.dart';
import 'package:digi_pikasso/data/repositories/art_repository.dart';
import 'package:digi_pikasso/di/locator.dart';
import 'package:digi_pikasso/error/failures.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  void login(String username, String password, String appName) async {
    // emit(AuthLoginInProgress());

    // var loginResponse =
    //     await getIt<ArtRepository>().login(username, password, appName);

    // if (loginResponse is FailedLoginResponse) {
    //   getIt<ArtRepository>().successLoginCode = null;
    //   emit(AuthLoginFailed(loginResponse.error));
    //   return;
    // }

    // if (loginResponse is SuccessLoginResponse) {
    //   getIt<ArtRepository>().successLoginCode = loginResponse.successLoginCode;
    //   emit(AuthLoginSuccess(code: loginResponse.successLoginCode));
    // }
  }

  void authenticateLogin() async {
    // if (getIt<ArtRepository>().successLoginCode == null) {
    //   return;
    // }
    // var response = await getIt<ArtRepository>()
    //     .authenticateLogin(getIt<ArtRepository>().successLoginCode!);

    // response.fold((l) {
    //   if (l is APIFailure) {
    //     emit(AuthLoginFailed(l.message));
    //   }
    // }, (r) => emit(AuthenticationSuccess(redirectUrl: r.redirectUrl)));
  }

  void timerExpired() {
    // getIt<ArtRepository>().successLoginCode = null;
    // emit(const AuthLoginFailed('2FA timed out'));
  }

  void reset() {
    // emit(AuthInitial());
  }
}
