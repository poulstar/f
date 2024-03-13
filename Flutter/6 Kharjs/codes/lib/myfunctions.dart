import 'package:shamsi_date/shamsi_date.dart';

import 'main.dart';

bool isKharjInRange(DateTime date, String start, String end) {
  try {
    int y;
    int m;
    int d;
    if (dateType == 1) {
      // Gregorian
      y = date.year;
      m = date.month;
      d = date.day;
    } else {
      // Jalali
      var date2 = date.toJalali();
      y = date2.year;
      m = date2.month;
      d = date2.day;
    }
    var startYear = int.parse(start.substring(0, 4));
    var startMonth = int.parse(start.substring(5, 7));
    var startDay = int.parse(start.substring(8, 10));
    var endYear = int.parse(end.substring(0, 4));
    var endMonth = int.parse(end.substring(5, 7));
    var endDay = int.parse(end.substring(8, 10));
    var startDays = startYear * 365 + startMonth * 30 + startDay;
    var endDays = endYear * 365 + endMonth * 30 + endDay;
    var days = y * 365 + m * 30 + d;
    if (days >= startDays && days <= endDays) {
      return true;
    }
    return false;
  } catch (error) {
    return false;
  }
}

String myJalaliMaker(DateTime date) {
  if (dateType == 1) {
    // Gregorian
    return date.toString().substring(0, 10);
  } else {
    int year = date.toJalali().year; // I am sure year is 4 digits so its int.
    String month =
    date.toJalali().month.toString(); // maybe month is 1 digit so ...
    month = month.length > 1 ? month : '0$month';
    String day = date.toJalali().day.toString(); // maybe day is 1 digit so ...
    day = day.length > 1 ? day : '0$day';
    return '$year-$month-$day';
  }
}

String getNameOfWeekDayInJalali(int weekday) {
  switch (weekday) {
    case 1:
      return "دوشنبه";
    case 2:
      return "سه شنبه";
    case 3:
      return "چهارشنبه";
    case 4:
      return "پنجشنبه";
    case 5:
      return "جمعه";
    case 6:
      return "شنبه";
    case 7:
      return "یکشنبه";
  }
  return "روز نامشخص";
}