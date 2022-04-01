import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeAgoConverter {
  String timeAgoString(String date) {
    DateTime dt = DateTime.parse(date);
    return timeago.format(dt, locale: 'fr');
  }

  String timeAgoDateTime(DateTime date) {
    return timeago.format(date, locale: 'fr');
  }

  String convertDate(String date) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}

TimeAgoConverter timeAgoConverter = new TimeAgoConverter();
