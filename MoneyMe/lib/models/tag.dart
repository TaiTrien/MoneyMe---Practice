class Tag {
  // ignore: unused_field
  String _tagID;
  // ignore: unused_field
  String _jarID;
  // ignore: unused_field
  String _parentID;
  String icon;
  String color;
  String tagName;
  String type;

  Tag({tagID, jarID, parentID, this.icon, this.color, this.tagName, this.type})
      : this._tagID = tagID,
        this._jarID = jarID,
        this._parentID = parentID;
  @override
  bool operator ==(other) {
    return (other is Tag) &&
        other._tagID == _tagID &&
        other._jarID == _jarID &&
        other._parentID == _parentID &&
        other.icon == icon &&
        other.color == color &&
        other.tagName == tagName &&
        other.color == color;
  }

  Tag.map(dynamic obj) {
    this._tagID = obj["tag_id"];
    this._jarID = obj["jar_id"];
    this._parentID = obj["parent_id"];
    this.icon = obj["icon"];
    this.color = obj["color"];
    this.tagName = obj["tag_name"];
    this.type = obj["type"];
  }

  get tagID => this._tagID;
  get jarID => this._jarID;
  get parentID => this._parentID;

  @override
  int get hashCode => super.hashCode;
}
