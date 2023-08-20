class Payment {
  Payment(
      {required this.amount,
      required this.isPaid,
      required this.paymentDate,
      required this.paymentMode});

  final DateTime paymentDate;
  final String paymentMode;
  final double amount;
  final bool isPaid;
}
