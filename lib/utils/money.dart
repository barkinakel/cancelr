String formatMoney(double amount) {
  final whole = amount == amount.roundToDouble();
  return '\$${whole ? amount.toStringAsFixed(0) : amount.toStringAsFixed(2)}';
}