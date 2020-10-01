class Jar {
  String _jarID;
  String _jarName;
  String _jarTitle;
  String _icon;
  String _price;
  String _percentage;
  String _priceIncome;
  String _priceSpend;

  Jar(
    this._jarID,
    this._jarName,
    this._jarTitle,
    this._icon,
    this._price,
    this._percentage,
    this._priceIncome,
    this._priceSpend,
  );

  Jar.map(dynamic obj) {
    this._jarID = obj["jar_id"];
    this._jarName = obj["jar_name"];
    this._jarTitle = obj["jar_title"];
    this._icon = obj["icon"];
    this._price = obj["price"];
    this._percentage = obj["percentage"];
    this._priceIncome = obj["price_in_come"];
    this._priceSpend = obj["price_spend"];
  }

  String get jarID => this._jarID;
  String get jarName => this._jarName;
  String get jarTitle => this._jarTitle;
  String get icon => this._icon;
  String get price => this._price;
  String get percentage => this._percentage;
  String get priceIncome => this._priceIncome;
  String get priceSpend => this._priceSpend;

  void setPercentage(String percentage) => this._percentage = percentage;
}
