part of 'my_news_bloc.dart';

abstract class MyNewsState extends Equatable {
  const MyNewsState();

  @override
  List<Object> get props => [];
}

class MyNewsInitial extends MyNewsState {}

class LoadingState2 extends MyNewsState {}

class LoadedNewsState extends MyNewsState {
  final List<New> noticiasList;

  LoadedNewsState({@required this.noticiasList});
  @override
  List<Object> get props => [noticiasList];
}

class ErrorMessageState2 extends MyNewsState {
  final String errorMsg;

  ErrorMessageState2({@required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
