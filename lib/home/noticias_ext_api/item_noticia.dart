import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:google_login/models/new.dart';
import 'package:extended_image/extended_image.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ItemNoticia extends StatelessWidget {
  final New noticia;
  ItemNoticia({Key key, @required this.noticia}) : super(key: key);

  String text = '';
  String subject = '';
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
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
                    ExtendedImage.network(
                      "${noticia.urlToImage}",
                      height: 132,
                      fit: BoxFit.fitHeight,
                      loadStateChanged: (ExtendedImageState state) {
                        switch (state.extendedImageLoadState) {
                          case LoadState.failed:
                            return Image.asset(
                              "assets/failed.jpg",
                              fit: BoxFit.fitHeight,
                            );
                            break;
                          case LoadState.completed:
                            return state.completedWidget;
                            break;
                          default:
                            return null;
                        }
                      },
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
                        "${noticia.title}",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${noticia.publishedAt}",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "${noticia.description ?? "Descripcion no disponible"}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "${noticia.author ?? "Autor no disponible"}",
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
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () async {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  text = noticia.description != null
                      ? noticia.description
                      : "Descripcion no disponible";
                  String match = text.substring(0, 25);
                  text = match + "...";
                  subject = "${noticia.title}";
                  if (noticia.urlToImage != null) {
                    Uri myUri = Uri.parse(noticia.urlToImage);
                    var response = await http.get(myUri);
                    Directory documentDirectory =
                        await getApplicationDocumentsDirectory();
                    File file =
                        new File(join(documentDirectory.path, 'imagetest.png'));
                    file.writeAsBytesSync(response.bodyBytes);
                    imagePaths.add('${documentDirectory.path}/imagetest.png');
                    await Share.shareFiles(imagePaths,
                        text: text,
                        subject: subject,
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  } else {
                    await Share.share(text,
                        subject: subject,
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
