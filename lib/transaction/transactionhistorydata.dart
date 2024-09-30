import 'transactionhistorymodel.dart';

List<Transaction> transactions = [
  Transaction(
    transactionId: 'TXN123456',
    babysitterName: 'Carlo Velvestre',
    bookingDate: DateTime(2024, 9, 15),
    status: 'Confirmed',
  ),
  Transaction(
    transactionId: 'TXN123457',
    babysitterName: 'Paul Castilla',
    bookingDate: DateTime(2024, 9, 20),
    status: 'Confirmed',
  ),
  Transaction(
    transactionId: 'TXN123458',
    babysitterName: 'Dick White',
    bookingDate: DateTime(2024, 9, 25),
    status: 'Confirmed',
  ),
  Transaction(
    transactionId: 'WOLVIC123458',
    babysitterName: 'Dick Black',
    bookingDate: DateTime(2024, 8, 25),
    status: 'Cancelled',
  ),
  Transaction(
    transactionId: 'LIM123458',
    babysitterName: 'John Lim',
    bookingDate: DateTime(2024, 10, 25),
    status: 'Cancelled',
  ),
];
