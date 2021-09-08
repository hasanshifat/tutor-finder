class DivDisThClass {
  int id;
  var division, district, thana;
  DivDisThClass({this.district, this.division, this.id, this.thana});

  factory DivDisThClass.fromRTDB(Map<String, dynamic> data) {
    return DivDisThClass(
        id: data['ID'],
        division: data['DIVISION'],
        district: ['DISTRICT'],
        thana: data['THANA']);
  }

}
