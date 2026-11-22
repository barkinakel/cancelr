const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

// "7 Nov"
String shortDate(DateTime date) => '${date.day} ${_months[date.month - 1]}';

// "7 Nov 2026"
String longDate(DateTime date) => '${shortDate(date)} ${date.year}';
