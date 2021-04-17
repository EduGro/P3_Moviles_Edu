import 'package:flutter/material.dart';
import 'package:google_login/models/new.dart';
import 'package:google_login/utils/news_repository.dart';
import 'package:hive/hive.dart';

import 'item_noticia.dart';

class NoticiasDeportes extends StatefulWidget {
  NoticiasDeportes({Key key}) : super(key: key);

  @override
  _NoticiasDeportesState createState() => _NoticiasDeportesState();
}

class _NoticiasDeportesState extends State<NoticiasDeportes> {
  Box<String> _box;

  @override
  void initState() {
    super.initState();
    _box = Hive.box<String>("news_hive");
    function();
  }

  void function() {
    Map<int, New> map;
    int times = 3;
    New temp;
    String tempD;
    NewsRepository()
        .getAvailableNoticias('')
        .then(
          (value) => {
            if (value != null)
              {
                map = value.asMap(),
                for (int i = 0; i < times; i++)
                  {
                    temp = map[i],
                    if (temp != null)
                      {
                        if (temp.description != null) {},
                        _box.put("noticiaTitle$i", temp.title),
                        _box.put("noticiaAuthor$i", temp.author ?? "Not found"),
                        tempD = temp.description != null
                            ? temp.description.substring(0, 50)
                            : "Descripcion no disponible",
                        _box.put("noticiaDescripcion$i", tempD),
                        _box.put("noticiaTime$i", temp.publishedAt.toString()),
                        _box.put("noticiaImage$i", 'assets/failed.jpg'),
                      },
                  }
              },
          },
        )
        // ignore: return_of_invalid_type_from_catch_error
        .catchError((e) => {
              print('error: $e'),
              throw (e),
            });
  }

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
                onPressed: () {},
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
                  var times = 3;
                  return ListView.builder(
                    itemCount: times,
                    itemBuilder: (context, i) {
                      return NoticiaOff(i, _box);
                    },
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

// ignore: non_constant_identifier_names
Widget NoticiaOff(int i, Box _box) {
  return Container(
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/failed.jpg",
                    height: 132,
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _box.get("noticiaTitle$i"),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      _box.get("noticiaTime$i"),
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      _box.get("noticiaDescripcion$i"),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16),
                    Text(
                      _box.get("noticiaAuthor$i"),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
