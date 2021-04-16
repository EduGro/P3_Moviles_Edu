import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'refresh_my_news_event.dart';
part 'refresh_my_news_state.dart';

class RefreshMyNewsBloc extends Bloc<RefreshMyNewsEvent, RefreshMyNewsState> {
  RefreshMyNewsBloc() : super(RefreshMyNewsInitial());

  @override
  Stream<RefreshMyNewsState> mapEventToState(
    RefreshMyNewsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
