import 'package:get/get.dart';

class AgeCalculatorController extends GetxController {

  Rx<DateTime?> birthDate = Rx<DateTime?>(null);
  Rx<DateTime?> calculateDate = Rx<DateTime?>(DateTime.now());

  var years = 0.obs;
  var months = 0.obs;
  var days = 0.obs;

  void setBirthDate(DateTime date) {
    birthDate.value = date;
  }

  void setCalculateDate(DateTime date) {
    calculateDate.value = date;
  }

  void calculateAge() {

    if (birthDate.value == null || calculateDate.value == null) return;

    DateTime start = birthDate.value!;
    DateTime end = calculateDate.value!;

    int y = end.year - start.year;
    int m = end.month - start.month;
    int d = end.day - start.day;

    if (d < 0) {
      m--;
      d += DateTime(end.year, end.month, 0).day;
    }

    if (m < 0) {
      y--;
      m += 12;
    }

    years.value = y;
    months.value = m;
    days.value = d;
  }
}