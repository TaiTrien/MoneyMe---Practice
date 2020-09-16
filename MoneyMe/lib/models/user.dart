class User {
  String _numberPhone;
  String _password;
  String _token;
  User(this._numberPhone, this._password);

  User.map(dynamic obj) {
    this._numberPhone = obj["user_name"];
    this._password = obj["password"];
    this._token = obj["data"];
  }
  String get getToken => this._token;
}
