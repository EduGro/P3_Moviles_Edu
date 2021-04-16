part of 'save_news_bloc.dart';

abstract class SaveNewsEvent extends Equatable {
  const SaveNewsEvent();

  @override
  List<Object> get props => [];
}

class SaveNewElementEvent extends SaveNewsEvent {
  final New noticia;

  SaveNewElementEvent({@required this.noticia});
  @override
  List<Object> get props => [noticia];
}

class PickImageEvent extends SaveNewsEvent {
  @override
  List<Object> get props => [];
}
