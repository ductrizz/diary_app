import 'package:intl/intl.dart';

final DateFormat dateFormat = DateFormat("dd-MM-yyyy");
final DateFormat hourFormat = DateFormat("HH : mm");

extension dateTimeConvert on DateTime{
  int get toSinceEpochForSecond {
    int datefollowSecond = (this.millisecondsSinceEpoch / 1000).round();
    return datefollowSecond;
  }
  String get toDay {
    var day = dateFormat.format(this);
    return day;
  }
  String get toHour{
    var hour = hourFormat.format(this);
    return hour;
  }
}

extension caculatorTimeInDay on int{
  int get minuter => this * 60;
  int get hour => this * 60 * 60;
  int get day => this * 60 * 60 * 24;
}

extension sinceEpochConvert on int{
  DateTime get toDateTime {
    if(this.toString().length == 10){
      DateTime datefollowSecond = DateTime.fromMillisecondsSinceEpoch(this * 1000);
      return datefollowSecond;
    }else{
      DateTime datefollowSecond = DateTime.fromMillisecondsSinceEpoch(this);
      return datefollowSecond;
    }
  }
  String get toDay {
    if(this.toString().length == 10){
      DateTime datefollowSecond = DateTime.fromMillisecondsSinceEpoch(this * 1000);
      var day = dateFormat.format(datefollowSecond);
      return day;
    } else{
      DateTime datefollowSecond = DateTime.fromMillisecondsSinceEpoch(this);
      var day = dateFormat.format(datefollowSecond);
      return day;
    }

  }
}

extension stringConvertDate on String{
  DateTime get toDateTime {
    DateTime dateTime = DateTime.tryParse(dateFormat.parse(this).toString())!;
    return dateTime;
  }
  int get toSinceEpoch {
    DateTime dateTime = DateTime.tryParse(dateFormat.parse(this).toString())!;
    int sinceEpoch = dateTime.toSinceEpochForSecond;
    return sinceEpoch;
  }
}