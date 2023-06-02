import 'package:digi_pikasso/data/models/application_info.dart';
import 'package:digi_pikasso/data/repositories/art_repository.dart';
import 'package:digi_pikasso/di/locator.dart';
import 'package:digi_pikasso/error/failures.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'application_information_state.dart';

class ApplicationInformationCubit extends Cubit<ApplicationInformationState> {
  ApplicationInformationCubit() : super(ApplicationInformationInitial());

  void retrieveApplicationInfo() async {
    // if (getIt<ArtRepository>().appName == null) {
    //   return;
    // }
    // var response = await getIt<ArtRepository>()
    //     .retrieveApplicationInfo(getIt<ArtRepository>().appName!);
    // response.fold((l) {
    //   if (l is APIFailure) {
    //     emit(ApplicationInformationFail(l));
    //   }
    // }, (r) => emit(ApplicationInformationSuccess(r)));
  }
}
