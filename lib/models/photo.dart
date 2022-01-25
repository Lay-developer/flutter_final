class PhotoD {
  late int _id;
  late String _name;
  late String _image;

  PhotoD({int id = 0, String name = '', String image = ''}) {
    _id = id;
    _name = name;
    _image = image;
  }

  int get id => _id;
  String get name => _name;
  String get image => _image;

  set id(int value) => _id = value;
  set name(String value) => _name = value;
  set image(String value) => _image = value;

  PhotoD.map(dynamic obj) {
    _id = (obj['id'] == null ? 0 : int.parse(obj['id'].toString()));
    _name = (obj['name'] == null ? '' : obj['name'].toString());
    _image = (obj['image'] == null ? '' : obj['image'].toString());
  }
}
