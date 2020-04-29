import 'package:intl/intl.dart';

class Date {
  String getCurrentDate() {
    var dt = DateTime.now();
    var newFrmt = DateFormat("d-MMMM-yyyy ");
    String date = newFrmt.format(dt);
    return date;
  }
}
