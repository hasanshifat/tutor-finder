import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class UserDetails extends ChangeNotifier {
  var userName;
  var userEmail;
  var userId;
  var phoneNumber;
  var userRole;
  var userPassword;
  var profilePic;

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

  dataUserEmail(var useremail) {
    userEmail = useremail;
    notifyListeners();
  }
  dataUserPAssword(var userpassword) {
    userPassword = userpassword;
    notifyListeners();
  }
  dataUserProfilePic(var propic) {
    profilePic = propic;
    notifyListeners();
  }
}
