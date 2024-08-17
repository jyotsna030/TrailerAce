class Helpers {
  // Function to convert time to a readable format
  static String formatTime(String time) {
    // Assuming time is in 24-hour format
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour > 12 ? hour - 12 : hour;
    return '$hour:${parts[1]} $period';
  }
}
