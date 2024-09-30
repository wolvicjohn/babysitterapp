import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../transaction/transactionhistorydata.dart';
import '../transaction/transactionhistorymodel.dart';
import 'transactioninfopage.dart';

class TransactionHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Group transactions by month
    final Map<String, List<Transaction>> groupedTransactions = {};

    for (var transaction in transactions) {
      // Format the month and year (e.g., "September 2024")
      final String monthYear =
          DateFormat('MMMM yyyy').format(transaction.bookingDate);

      // Add transaction to the corresponding month group
      if (groupedTransactions[monthYear] == null) {
        groupedTransactions[monthYear] = [];
      }
      groupedTransactions[monthYear]!.add(transaction);
    }

    // Sort the month keys by descending order of the DateTime (most recent first)
    final sortedMonthKeys = groupedTransactions.keys.toList()
      ..sort((a, b) {
        // Convert the monthYear (e.g., "September 2024") back to DateTime for comparison
        final dateA = DateFormat('MMMM yyyy').parse(a);
        final dateB = DateFormat('MMMM yyyy').parse(b);
        return dateB.compareTo(dateA); // Sort in descending order
      });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Navigates back to the previous screen
              },
            ),
            const SizedBox(
                width: 10), // Adds some space between the icon and text
            const Text('Transaction History'),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: sortedMonthKeys.length,
        itemBuilder: (context, index) {
          // Get the month-year key and the transactions for that month
          final String monthYear = sortedMonthKeys[index];
          final List<Transaction> monthTransactions =
              groupedTransactions[monthYear]!;

          // Build a section with a header for the month and its transactions
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              // Month header
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  monthYear,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Transactions for that month
              ...monthTransactions.map((transaction) {
                return GestureDetector(
                  onTap: () => _navigateToBabysitterDetails(
                      context,
                      transaction.babysitterName,
                      transaction.transactionId,
                      transaction.bookingDate),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: statusIcon(transaction.status),
                      title: Text(
                        'Status: ${transaction.status}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Date: ${DateFormat('yyyy-MM-dd').format(transaction.bookingDate)}',
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }

  // Method to return the appropriate icon based on transaction status
  Widget statusIcon(String status) {
    if (status == 'Confirmed') {
      return const Icon(Icons.check_circle, color: Colors.purple);
    } else if (status == 'Cancelled') {
      return const Icon(Icons.cancel, color: Colors.grey);
    } else {
      return const Icon(Icons.help_outline,
          color: Colors.grey); // Default icon for unknown statuses
    }
  }

  // Method to navigate to the BabysitterDetailsPage
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
