// ignore_for_file: unnecessary_getters_setters, avoid_print

class Episode {
  late int _id;
  late String _episodeTitle;
  late int _episodeNumber;
  late String _shortDescription;
  late String _description;
  late String _image;

  Episode({
    int id = 0,
    String episodeTitle = '',
    int episodeNumber = 0,
    String shortDescription = '',
    String description = '',
    String image = '',
  }) {
    _id = id;
    _episodeTitle = episodeTitle;
    _episodeNumber = episodeNumber;
    _shortDescription = shortDescription;
    _description = description;
    _image = image;
  }
  /////////
  ///getter
  void string() {
    print('id: ' + id.toString());
    print('description: ' + description.toString());
    print('image: ' + image.toString());
    print('shortDescription: ' + shortDescription.toString());
    print('episodeNumber: ' + episodeNumber.toString());
    print('episodeTitle: ' + episodeNumber.toString());
  }

  //////////
  ///getter
  int get id => _id;
  String get episodeTitle => _episodeTitle;
  int get episodeNumber => _episodeNumber;
  String get shortDescription => _shortDescription;
  String get description => _description;
  String get image => _image;

  set id(int value) => _id = value;
  set episodeTitle(String value) => _episodeTitle = value;
  set episodeNumber(int value) => _episodeNumber = value;
  set shortDescription(String value) => _shortDescription = value;
  set description(String value) => _description = value;
  set image(String value) => _image = value;

  Episode.map(dynamic obj) {
    _id = (obj['episode_id'] == null
        ? 0
        : int.parse(obj['episode_id'].toString()));
    _episodeTitle =
        (obj['episode_title'] == null ? '' : obj['episode_title'].toString());
    _episodeNumber = (obj['episode_number'] == null
        ? 0
        : int.parse(obj['episode_number'].toString()));
    _shortDescription = (obj['short_description'] == null
        ? ''
        : obj['short_description'].toString());
    _description = (obj['episode_description'] == null
        ? ''
        : obj['episode_description'].toString());
    _image =
        (obj['episode_image'] == null ? '' : obj['episode_image'].toString());
  }
}
