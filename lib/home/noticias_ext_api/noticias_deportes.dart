import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_login/utils/news_repository.dart';

import 'item_noticia.dart';

class NoticiasDeportes extends StatefulWidget {
  NoticiasDeportes({Key key}) : super(key: key);

  @override
  _NoticiasDeportesState createState() => _NoticiasDeportesState();
}

class _NoticiasDeportesState extends State<NoticiasDeportes> {
  var query = '';
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          TextField(
            textInputAction: TextInputAction.search,
            controller: _controller,
            onSubmitted: (value) {
              query = value;
              setState(() {});
            },
            decoration: InputDecoration(
              fillColor: Colors.green[100],
              filled: true,
              border: InputBorder.none,
              prefixIcon: IconButton(
                onPressed: () {
                  query = _controller.value as String;
                  setState(() {});
                },
                icon: Icon(Icons.search),
              ),
              suffixIcon: IconButton(
                onPressed: _controller.clear,
                icon: Icon(Icons.clear),
              ),
              hintText: 'Search ',
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: FutureBuilder(
              future: NewsRepository().getAvailableNoticias(query),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child:
                        Text("Algo salio mal", style: TextStyle(fontSize: 32)),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ItemNoticia(
                        noticia: snapshot.data[index],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
