import 'package:digi_pikasso/cubit/auth_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  ContentCubit() : super(ContentInitial(ContentView.login));

  void changeView(ContentView cv) => emit(ContentInitial(cv));
}
