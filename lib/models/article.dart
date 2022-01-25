// ignore_for_file: unnecessary_getters_setters, avoid_print

import 'package:reading/models/character.dart';
import 'package:reading/models/episode.dart';

class Article {
  late int _id;
  late String _title;
  late String _shortDescription;
  late String _image;
  late String _heroImage;
  late double _rated;
  late String _createAt;
  late bool _isFav;
  late List<Episode> _episode;
  late List<Character> _character;
  Article(
      {int id = 0,
      String title = '',
      String shortDescription = '',
      String image = '',
      String heroImage = '',
      double rated = 0.0,
      String createAt = '',
      bool isFav = false,
      required List<Character> character,
      required List<Episode> episode}) {
    _id = id;
    _title = title;
    _shortDescription = shortDescription;
    _image = image;
    _heroImage = heroImage;
    _rated = rated;
    _createAt = createAt;
    _isFav = isFav;
    _character = character;
    _episode = episode;
  }
  /////////
  ///getter
  void string() {
    print('id: ' + id.toString());
    print('title: ' + title.toString());
    print('shortDescription: ' + shortDescription.toString());
    print('image: ' + image.toString());
    print('rated: ' + rated.toString());
    print('rated: ' + createAt.toString());
    print('isFav: ' + isFav.toString());
    print('heroImage: ' + heroImage.toString());
    print('character: ' + character.toString());
  }

  /////////
  ///getter

  int get id => _id;
  String get title => _title;
  String get shortDescription => _shortDescription;
  String get image => _image;
  String get heroImage => _heroImage;
  double get rated => _rated;
  String get createAt => _createAt;
  bool get isFav => _isFav;
  List<Character> get character => _character;
  List<Episode> get episode => _episode;
  /////////
  ///setter
  set id(int value) => _id = value;
  set title(String value) => _title = value;
  set shortDescription(String value) => _shortDescription = value;
  set image(String value) => _image = value;
  set heroImage(String value) => _heroImage = value;
  set rated(double value) => _rated = value;
  set createAt(String value) => _createAt = value;
  set isFav(bool value) => _isFav = value;
  set character(List<Character> value) => _character = value;
  set episode(List<Episode> value) => _episode = value;

  Article.map(dynamic obj) {
    print(obj);
    _id = (obj['id'] == null ? 0 : int.parse(obj['id'].toString()));
    _title = (obj['title'] == null ? '' : obj['title'].toString());
    _shortDescription = (obj['short_description'] == null
        ? ''
        : obj['short_description'].toString());
    _image = (obj['bg_image'] == null ? '' : obj['bg_image'].toString());
    _heroImage =
        (obj['hero_image'] == null ? '' : obj['hero_image'].toString());
    print(_image);
    _rated =
        (obj['rated'] == null ? 0.0 : double.parse(obj['rated'].toString()));
    _createAt = (obj['create_at'] == null ? '' : obj['create_at'].toString());
    final char = obj['characters'] ?? [];
    final ep = obj['episodes'] ?? [];

    List<Character> characters = [];
    List<Episode> episodes = [];

    for (var item in char) {
      Character cha = Character.map(item);
      characters.add(cha);
    }

    for (var item in ep) {
      Episode e = Episode.map(item);
      episodes.add(e);
    }
    print(char);
    print(ep);
    // isFav = false;
    _character = characters;
    _episode = episodes;
  }

  Article.map2(dynamic obj) {
    print(obj);
    _id = (obj['id'] == null ? 0 : int.parse(obj['id'].toString()));
    _title = (obj['title'] == null ? '' : obj['title'].toString());
    _shortDescription = (obj['short_description'] == null
        ? ''
        : obj['short_description'].toString());
    _image = (obj['image'] == null ? '' : obj['image'].toString());
    _heroImage =
        (obj['hero_image'] == null ? '' : obj['hero_image'].toString());
    _rated =
        (obj['rated'] == null ? 0.0 : double.parse(obj['rated'].toString()));

    _isFav = true;

    //////////////////////
    // /map all character & episode fields
    String epId = (obj['epId'] == null ? '' : obj['epId'].toString());
    String epTitle = obj['epTitle'] == null ? '' : obj['epTitle'].toString();
    String epNumber = obj['epNumber'] == null ? '' : obj['epNumber'].toString();
    String epSortDescription =
        obj['epShortDesc'] == null ? '' : obj['epShortDesc'].toString();
    String epDescription =
        obj['epDesc'] == null ? '' : obj['epDesc'].toString();

    String epImage = obj['epImage'] == null ? '' : obj['epImage'].toString();

    List<String> epIds = epId.split(',');
    List<String> epTitles = epTitle.split(',');
    List<String> epNumbers = epNumber.split(',');
    List<String> epSortDescriptions = epSortDescription.split(',');
    List<String> epDescriptions = epDescription.split(',');
    List<String> epImages = epImage.split(',');

    List<Episode> episodes = <Episode>[];

    if (epIds.isNotEmpty) {
      for (var i = 0; i < epIds.length; i++) {
        Episode ep = Episode(
          id: int.parse(epIds[i].toString()),
          episodeTitle: epTitles[i],
          image: epImages[i],
          description: epDescriptions[i],
          episodeNumber: int.parse(epNumbers[i]),
          shortDescription: epSortDescriptions[i],
        );
        episodes.add(ep);
      }
    }

    _episode = episodes;
    String charId = obj['charId'] == null ? '' : obj['charId'].toString();
    String charName = obj['charName'] == null ? '' : obj['charName'].toString();
    String charImage =
        obj['charImage'] == null ? '' : obj['charImage'].toString();

    ///////////////////////////////////////
    ///splite to list

    List<String> charIds = charId.split(',');
    List<String> charNames = charName.split(',');
    List<String> charImages = charImage.split(',');

    List<Character> characters = <Character>[];

    if (charIds.isNotEmpty) {
      for (var i = 0; i < charIds.length; i++) {
        Character ch = Character(
            id: int.parse(charIds[i]),
            name: charNames[i],
            image: charImages[i]);
        characters.add(ch);
      }
    }
    _character = characters;
  }
}
