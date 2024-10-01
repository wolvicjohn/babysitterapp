class Transaction {
  final String transactionId;
  final String babysitterName;
  final DateTime bookingDate;
  final String status;

  Transaction({
    required this.transactionId,
    required this.babysitterName,
    required this.bookingDate,
    required this.status,
  });
}
