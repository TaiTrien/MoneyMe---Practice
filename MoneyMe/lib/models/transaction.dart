class Transaction {
  String _inputID;
  String _tagName;
  String _tagID;
  String _icon;
  String _desc;
  String _price;
  String _date;
  String _type;
  String _jarName;
  String _jarTitle;
  String _jarIcon;

  Transaction.map(dynamic obj, int index) {
    this._inputID = obj["items"][index]["input_id"];
    this._tagName = obj["items"][index]["tag_name"];
    this._tagID = obj["items"][index]["tag_id"];
    this._icon = obj["items"][index]["icon"];
    this._desc = obj["items"][index]["desc"];
    this._price = obj["items"][index]["price"];
    this._date = obj["items"][index]["date"];
    this._type = obj["items"][index]["type"];
    this._jarName = obj["items"][index]["jar_name"];
    this._jarTitle = obj["items"][index]["jar_title"];
    this._jarIcon = obj["items"][index]["jar_icon"];
  }

  String get inputId => this._inputID;
  String get tagName => this._tagName;
  String get tagID => this._tagID;
  String get icon => this._icon;
  String get desc => this._desc;
  String get price => this._price;
  String get date => this._date;
  String get type => this._type;
  String get jarName => this._jarName;
  String get jarTitle => this._jarTitle;
  String get jarIcon => this._jarIcon;
}
