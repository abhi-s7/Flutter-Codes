class Song {
  String _name;
  String _aName;
  String _url;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get aName => _aName;

  set aName(String value) {
    _aName = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Song{_name: $_name, _aName: $_aName, _url: $_url}';
  }
}
