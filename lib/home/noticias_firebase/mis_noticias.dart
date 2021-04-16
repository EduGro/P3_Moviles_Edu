import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login/home/noticias_ext_api/item_noticia.dart';
import 'package:google_login/home/noticias_firebase/bloc/save_news_bloc.dart';

import 'bloc/my_news_bloc.dart';

class MisNoticias extends StatefulWidget {
  MisNoticias({Key key, bool ban}) : super(key: key);
  @override
  _MisNoticiasState createState() => _MisNoticiasState();
}

class _MisNoticiasState extends State<MisNoticias> {
  MyNewsBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyNewsBloc>(
      create: (context) => MyNewsBloc()..add(RequestAllNewsEvent()),
      child: BlocConsumer<MyNewsBloc, MyNewsState>(
        listener: (context, state) {
          if (state is LoadingState2) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Cargando..."),
                ),
              );
          } else if (state is ErrorMessageState2) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("${state.errorMsg}"),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is LoadedNewsState) {
            return RefreshIndicator(
              onRefresh: () => _refresh(_bloc, context),
              child: ListView.builder(
                itemCount: state.noticiasList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemNoticia(noticia: state.noticiasList[index]);
                },
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> _refresh(MyNewsBloc _bloc, context) async {
    _bloc = BlocProvider.of<MyNewsBloc>(context);
    _bloc.add(RequestAllNewsEvent());
    return 'succes';
  }
}
