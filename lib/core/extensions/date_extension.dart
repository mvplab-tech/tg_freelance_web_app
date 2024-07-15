extension DateTimeX on DateTime {
  String monthName() {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'unknown month';
    }
  }

  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays < 1) {
      return 'Today';
    }

    if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    }

    final months = (difference.inDays / 30).floor();
    if (months < 12) {
      return '$months months ago';
    }

    final years = (months / 12).floor();
    final remainingMonths = months % 12;
    return '$years years and $remainingMonths months ago';
  }
}
