part of 'content_cubit.dart';

enum ContentView { login, authentication }

@immutable
abstract class ContentState {}

class ContentInitial extends ContentState {
  final ContentView currentContentToDisplay;
  ContentInitial(this.currentContentToDisplay);
}
