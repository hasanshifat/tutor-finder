
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tutor_finder/classes/div_dis_thana.dart';
import 'package:tutor_finder/db_helper/db_helper_main_class.dart';
import 'package:tutor_finder/db_helper/division_data_model.dart';

class DivDisThnSyndModel {
  DBHelper dbHelper;
  DivisionModel divisionModel;
  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('div');
  List<DivDisThClass> list = [];
  List<Object> list2 = [];
  //StreamSubscription streamSubscription;

  getdata(context) {
    databaseReference.onValue.listen((event) {
      list2 = event.snapshot.value;
      for (int i = 0; i < list2.length; i++) {
        divisionModel = DivisionModel(
            id: int.parse(event.snapshot.value[i]['ID']),
            division: event.snapshot.value[i]['DIVISION'],
            district: event.snapshot.value[i]['DISTRICT'],
            thana: event.snapshot.value[i]['THANA']);
        DBHelper.instance.insertDivDisData(divisionModel, context);
      }
    });
  }
}
