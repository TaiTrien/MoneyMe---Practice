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

  Transaction({String date, String desc, String price, String tagID})
      : _date = date,
        _desc = desc ?? '',
        _price = price,
        _tagID = tagID;

  Transaction.map(dynamic obj) {
    this._inputID = obj["input_id"];
    this._tagName = obj["tag_name"];
    this._tagID = obj["tag_id"];
    this._icon = obj["icon"];
    this._desc = obj["desc"];
    this._price = obj["price"];
    this._date = obj["date"];
    this._type = obj["type"];
    this._jarName = obj["jar_name"];
    this._jarTitle = obj["jar_title"];
    this._jarIcon = obj["jar_icon"];
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

  set tagName(tagName) => this._tagName = tagName;
  set tagID(tagID) => this._tagID = tagID;
  set icon(icon) => this._icon = icon;
  set desc(desc) => this._desc = desc;
  set price(price) => this._price = price;
  set date(date) => this._date = date;
  set type(type) => this._type = type;
  set jarName(jarName) => this._jarName = jarName;
  set jarTitle(jarTitle) => this._jarTitle = jarTitle;
  set jarIcon(jarIcon) => this._jarIcon = jarIcon;
}
