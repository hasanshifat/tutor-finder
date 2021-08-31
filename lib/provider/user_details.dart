import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class UserDetails extends ChangeNotifier {
  var userName;
  var salesPersonName1;
  var userId;
  var phoneNumber;
  var userRole;

  dataUserName(var username) {
    userName = username;
    notifyListeners();
  }

  dataUserID(var uid) {
    userId = uid;
    notifyListeners();
  }

  datauserRole(var userrole) {
    userRole = userrole;
    notifyListeners();
  }
  
  dataPhoneNumber(var phonenumber) {
    phoneNumber = phonenumber;
    notifyListeners();
  }
}
