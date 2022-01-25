// ignore_for_file: unnecessary_getters_setters, avoid_print

class Character {
  late int _id;
  late String _name;
  late String _image;

  Character({int id = 0, String name = '', String image = ''}) {
    _id = id;
    _name = name;
    _image = image;
  }

  void string() {
    print('id: ' + id.toString());
    print('name: ' + name.toString());
    print('image: ' + image.toString());
  }
  ////////
  ///gettter

  int get id => _id;
  String get name => _name;
  String get image => _image;

  /////////
  ///setter
  set id(int value) => _id = value;
  set name(String value) => _name = value;
  set image(String value) => _image = value;

  ///////////
  ///Map
  Character.map(dynamic obj) {
    _id = (obj['character_id'] == null
        ? 0
        : int.parse(obj['character_id'].toString()));
    _name =
        (obj['character_name'] == null ? '' : obj['character_name'].toString());
    _image = (obj['character_image'] == null
        ? ''
        : obj['character_image'].toString());
  }
}
