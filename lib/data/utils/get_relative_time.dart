
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:get/get.dart';
import 'package:intl/intl.dart';

String getRelativeTime(String createdAt) {
  try {
    DateTime createdTime = DateTime.parse(createdAt);
    DateTime currentTime = DateTime.now();

    Duration difference = currentTime.difference(createdTime);

    if (difference.inSeconds < 60) {
      return "Just Now".tr;
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} "+"Minutes ago".tr;
    } else if (difference.inHours < 24) {
      return "${difference.inHours} "+"Hours ago".tr;
    } else if (difference.inDays < 7) {
      return "${difference.inDays} "+"days ago".tr;
    } else {
      return "${(difference.inDays / 7).floor()} "+"Weeks ago".tr;
    }
  } catch (e) {
    print("Error parsing date: $e");
    return '';
  }
}


String getLimitedWord(String? address, int maxLength) {
  if (address == null || address.isEmpty) return "";
  return address.length > maxLength ? address.substring(0, maxLength) + '...' : address;
}


DateTime convertToIso(String dateText, String sanitizedTime) {
  final dateParts = dateText.split('/');
  final timeFormat = DateFormat.jm();
  final parsedTime = timeFormat.parse(sanitizedTime);

  return DateTime(
    int.parse(dateParts[2]),
    int.parse(dateParts[1]),
    int.parse(dateParts[0]),
    parsedTime.hour,
    parsedTime.minute,
  ).toUtc();
}


 logCharCodes(String input) {
  print("Char codes: ${input.runes.map((r) => 'U+${r.toRadixString(16).toUpperCase()}').join(', ')}");
}

String formatISOToDate(String isoString) {
  final dateTime = DateTime.parse(isoString);
  final formattedDate = "${dateTime.day.toString().padLeft(2, '0')}/"
      "${dateTime.month.toString().padLeft(2, '0')}/"
      "${dateTime.year}";
  return formattedDate;
}

