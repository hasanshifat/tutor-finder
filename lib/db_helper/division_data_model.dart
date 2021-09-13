class DivisionModel {
  String division, district, thana;
  int id;

  DivisionModel({this.division, this.district, this.thana, this.id});
  DivisionModel.withId({this.id, this.division, this.district, this.thana});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['division'] = division;
    map['district'] = district;
    map['thana'] = thana;
    map['id'] = id;
    return map;
  }

  factory DivisionModel.fromMap(Map<String, dynamic> map) {
    return DivisionModel.withId(
        division: map['division'],
        district: map['district'],
        thana: map['thana'],
        id: map['id']);
  }
}
