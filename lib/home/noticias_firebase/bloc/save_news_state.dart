part of 'save_news_bloc.dart';

abstract class SaveNewsState extends Equatable {
  const SaveNewsState();

  @override
  List<Object> get props => [];
}

class SaveNewsInitial extends SaveNewsState {}

class SavedNewState extends SaveNewsState {
  List<Object> get props => [];
}

class ErrorMessageState extends SaveNewsState {
  final String errorMsg;

  ErrorMessageState({@required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

class LoadingState extends SaveNewsState {}

class PickedImageState extends SaveNewsState {
  final File image;

  PickedImageState({@required this.image});
  @override
  List<Object> get props => [image];
}
