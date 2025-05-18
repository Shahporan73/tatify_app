import 'package:intl/intl.dart'; // Ensure this import is at the top

String createdAt(String? dateStr) {
  // Check for null or empty string at the very beginning
  if (dateStr == null || dateStr.trim().isEmpty) return '';

  dateStr = dateStr.trim();

  DateTime? date;
  try {
    // First try parsing directly (handles most ISO 8601 formats including 'Z')
    date = DateTime.parse(dateStr).toLocal();
  } catch (e) {
    // Attempt to parse using a different format if the initial parse fails
    try {
      // Check if the date string is in a valid format before parsing
      if (RegExp(r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$').hasMatch(dateStr)) {
        date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateStr).toLocal();
      } else {
        print('Invalid date format: $dateStr');
        return '';
      }
    } catch (e) {
      print('Error parsing date: $e');
      return '';
    }
  }

  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inSeconds < 10) {
    return 'Just now';
  } else if (difference.inMinutes < 1) {
    return '${difference.inSeconds}s ago';
  } else if (difference.inHours < 1) {
    return '${difference.inMinutes}m ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h ago';
  } else if (difference.inDays == 1) {
    return 'Yesterday';
  } else if (difference.inDays < 30) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return '$months month${months > 1 ? 's' : ''} ago';
  } else {
    final years = (difference.inDays / 365).floor();
    return '$years year${years > 1 ? 's' : ''} ago';
  }
}