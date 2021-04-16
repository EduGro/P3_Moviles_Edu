part of 'my_news_bloc.dart';

abstract class MyNewsEvent extends Equatable {
  const MyNewsEvent();

  @override
  List<Object> get props => [];
}

class RequestAllNewsEvent extends MyNewsEvent {
  @override
  List<Object> get props => [];
}
