import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../styles/colors.dart';
import 'transaction_model/transactionhistorydata.dart';
import 'transaction_model/transactionhistorymodel.dart';
import 'transactioninfopage.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Transaction>> groupedTransactions = {};

    for (var transaction in transactions) {
      final String monthYear =
          DateFormat('MMMM yyyy').format(transaction.bookingDate);

      if (groupedTransactions[monthYear] == null) {
        groupedTransactions[monthYear] = [];
      }
      groupedTransactions[monthYear]!.add(transaction);
    }

    final sortedMonthKeys = groupedTransactions.keys.toList()
      ..sort((a, b) {
        final dateA = DateFormat('MMMM yyyy').parse(a);
        final dateB = DateFormat('MMMM yyyy').parse(b);
        return dateB.compareTo(dateA);
      });

// Transaction
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
      body: Column(
        children: [
          const Divider(color: Color(0xFFD8D8D8)),
          Expanded(
            child: ListView.builder(
              itemCount: sortedMonthKeys.length,
              itemBuilder: (context, index) {
                final String monthYear = sortedMonthKeys[index];
                final List<Transaction> monthTransactions =
                    groupedTransactions[monthYear]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    // Month header
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        monthYear,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    ...monthTransactions.map((transaction) {
                      return GestureDetector(
                        onTap: () => _navigateToBabysitterDetails(
                          context,
                          transaction.babysitterName,
                          transaction.transactionId,
                          transaction.bookingDate,
                        ),
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: ListTile(
                            leading: statusIcon(transaction.status),
                            title: Text(
                              'Status: ${transaction.status}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Date: ${DateFormat('yyyy-MM-dd').format(transaction.bookingDate)}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

// status icon
  Widget statusIcon(String status) {
    if (status == 'Confirmed') {
      return const Icon(Icons.check_circle, color: Colors.purple);
    } else if (status == 'Cancelled') {
      return const Icon(Icons.cancel, color: Colors.grey);
    } else {
      return const Icon(Icons.help_outline, color: Colors.grey);
    }
  }

// navigate to info deets
  void _navigateToBabysitterDetails(BuildContext context, String babysitterName,
      String transactionId, DateTime bookingDate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionInfoPage(
          babysitterName: babysitterName,
          transactionId: transactionId,
          bookingDate: bookingDate,
        ),
      ),
    );
  }
}
