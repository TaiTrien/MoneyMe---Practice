class Response {
  dynamic _code;
  String _message;
  dynamic _data;
  Response.map(dynamic obj) {
    this._code = obj["code"];
    this._message = obj["message"];
    this._data = obj["data"];
  }

  dynamic get code => this._code;
  String get apiMessagse => this._message;
  dynamic get data => this._data;
}
