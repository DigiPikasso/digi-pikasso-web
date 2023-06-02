import 'package:digi_pikasso/data/data_sources/art_remote_data_source.dart';
import 'package:digi_pikasso/data/repositories/art_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<ArtRepository>(() {
    var userRemoteDataSource = ArtRemoteDataSource();
    return ArtRepository(userRemoteDataSource);
  });
}
