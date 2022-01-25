// ignore_for_file: avoid_print

import 'package:reading/helper/n_collection.dart';
import 'package:reading/models/article.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper {
  final String tableName = "Articles";
  static late Database dbInstance;

  Future<Database> get db async {
    dbInstance = await initDb();
    return dbInstance;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'Article.db');

    var db = await openDatabase(path, version: 1, onCreate: onCreateDb);
    return db;
  }

  void onCreateDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName(id INTEGER , title TEXT, short_description TEXT, image TEXT, hero_image TEXT, rated TEXT, isFav INTEGER, epId TEXT, epTitle TEXT, epShortDesc TEXT, epImage TEXT, epNumber TEXT, epDesc TEXT, charId TEXT, charName TEXT, charImage)');
  }

  Future<List<Article>> getArticles() async {
    var dbConnection = await db;
    final result = await dbConnection.rawQuery('SELECT * FROM $tableName');

    List<Article> articles = <Article>[];

    for (var i = result.length - 1; i >= 0; i--) {
      Article article = Article.map2(result[i]);
      articles.add(article);
      // print(article.character[i].name);
      // print(articles);
    }
    return articles;
  }

  void addArticle(Article article) async {
    ///////////////////////
    ///Episodes
    List<String> epIds = <String>[];
    List<String> epTitles = <String>[];
    List<String> epShortDescriptions = <String>[];
    List<String> epDescriptions = <String>[];
    List<String> epImages = <String>[];
    List<String> epNumbers = <String>[];

    /////////
    ///set episode to
    for (var ep in article.episode) {
      epIds.add(ep.id.toString());
      epTitles.add(ep.episodeTitle);
      epShortDescriptions.add(ep.shortDescription);
      epDescriptions.add(ep.description);
      epImages.add(ep.image);
      epNumbers.add(ep.episodeNumber.toString());
      print(article.episode);
    }

    String epId = epIds.join(',');
    String epTitle = epTitles.join(',');
    String epShortDescription = epShortDescriptions.join(',');
    String epDescription = epDescriptions.join(',');
    String epImage = epImages.join(',');
    String epNumber = epNumbers.join(',');

    print(epId +
        epTitle +
        epShortDescription +
        epDescription +
        epImage +
        epNumber);

    ////////////////////
    ///character
    List<String> charIds = <String>[];
    List<String> charNames = <String>[];
    List<String> charImages = <String>[];

    //////////
    ///set character
    for (var char in article.character) {
      charIds.add(char.id.toString());
      charNames.add(char.name);
      charImages.add(char.image);

      print(article.character);
    }

    String charId = charIds.join(',');
    String charName = charNames.join(',');
    String charImage = charImages.join(',');

    print(charId + charName + charImage);

    var dbConntection = await db;
    String query = 'INSERT INTO $tableName(id, ' +
        'title , ' +
        'short_description,' +
        'image ,' +
        'hero_image ,' +
        'rated , ' +
        'isFav , ' +
        'epId ,' +
        'epTitle ,' +
        'epShortDesc , ' +
        'epImage ,' +
        'epNumber ,' +
        'epDesc, ' +
        'charId , ' +
        'charName , ' +
        'charImage)' +
        'VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';

    await dbConntection.rawInsert(query, [
      article.id,
      article.title,
      article.shortDescription,
      article.image,
      article.heroImage,
      article.rated,
      false,
      epId,
      epTitle,
      epShortDescription,
      epImage,
      epNumber,
      epDescription,
      charId,
      charName,
      charImage,
    ]);
  }

  void delete(Article article) async {
    var dbConnection = await db;
    String query = 'DELETE FROM $tableName WHERE id = ${article.id}';
    await dbConnection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }

  Future<bool> selectArticleByID(Article article) async {
    var dbConnection = await db;
    var a;
    String query = 'SELECT * FROM $tableName WHERE id=${article.id}';
    await dbConnection.transaction((transaction) async {
      a = await transaction.rawQuery(query);
    });

    return a.isEmpty ? false : true;
  }
}
