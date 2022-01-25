import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reading/models/article.dart';
import 'package:reading/models/photo.dart';

class HTTP {
  static Future<List<Article>> httpGet({String url = ''}) async {
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);
    final parsed = json.decode(response.body);
    if (response.statusCode == 200) {
      print(parsed.length);
      List<Article> articles = [];
      for (var item in parsed) {
        Article article = Article.map(item);
        articles.add(article);
        print(articles);
      }
      return articles;
    } else {
      throw Exception('Not found data');
    }
  }

  static Future<List<PhotoD>> httpGetPhoto({String url = ''}) async {
    var response = await http.get(Uri.parse(url));
    final parsed = json.decode(response.body);
    List<PhotoD> photos = [];
    for (var item in parsed) {
      PhotoD photoD = PhotoD.map(item);
      photos.add(photoD);
    }
    return photos;
  }
}
