class User {
  String _name;
  String _userName;
  String _userID;

  User(this._name, this._userName, this._userID);
  User.map(dynamic obj) {
    this._name = obj["name"];
    this._userName = obj["user_name"];
    this._userID = obj["user_id"];
  }

  String get name => this._name;
  String get userName => this._userName;
  String get userID => this._userID;
}
