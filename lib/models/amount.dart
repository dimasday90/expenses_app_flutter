class Amount {
  final double amount;
  final int fixedNumber;

  Amount(this.amount, this.fixedNumber);

  String get formated {
    if (amount >= 1000000000000) {
      return '\$${(amount / 1000000000000).toStringAsFixed(fixedNumber)}T';
    } else if (amount >= 1000000000) {
      return '\$${(amount / 1000000000).toStringAsFixed(fixedNumber)}B';
    } else if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(fixedNumber)}M';
    } else if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(fixedNumber)}K';
    } else {
      return '\$${amount.toStringAsFixed(fixedNumber)}';
    }
  }
}
