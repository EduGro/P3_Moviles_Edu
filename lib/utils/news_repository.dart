import 'dart:convert';
import 'dart:io';

import 'package:google_login/models/new.dart';
import 'package:google_login/utils/secrets.dart';
import 'package:http/http.dart';

class NewsRepository {
  List<New> _noticiasList;

  static final NewsRepository _NewsRepository = NewsRepository._internal();
  factory NewsRepository() {
    return _NewsRepository;
  }

  NewsRepository._internal();
  Future<List<New>> getAvailableNoticias(String query) async {
    // TODO: utilizar variable q="$query" para buscar noticias en especifico
    // https://newsapi.org/v2/top-headlines?country=mx&q=futbol&category=sports&apiKey&apiKey=laAPIkey
    // crear modelos antes

    var _uri;
    if (query == '') {
      _uri = Uri(
        scheme: 'https',
        host: 'newsapi.org',
        path: 'v2/top-headlines',
        queryParameters: {
          "category": "sports",
          "country": "mx",
          "apiKey": apiKey,
        },
      );
    } else {
      _uri = Uri(
        scheme: 'https',
        host: 'newsapi.org',
        path: 'v2/top-headlines',
        queryParameters: {
          "q": query,
          "country": "mx",
          "apiKey": apiKey,
        },
      );
    }
    print(_uri);
    // TODO: completar request y deserializacion
    try {
      final response = await get(_uri);
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> data = jsonDecode(response.body)["articles"];
        _noticiasList =
            ((data).map((element) => New.fromJson(element))).toList();
        return _noticiasList;
      }
      return [];
    } catch (e) {
      //arroje un error
      throw "Ha ocurrido un error: $e";
    }
  }
}
