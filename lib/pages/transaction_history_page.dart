import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../transaction/transactionhistorydata.dart';
import '../transaction/transactionhistorymodel.dart';
import 'transactioninfopage.dart';

class TransactionHistoryPage extends StatefulWidget {
  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  String selectedStatus = 'All'; // Default filter option

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Transaction>> groupedTransactions = {};

    // Grouping transactions by month and year
    for (var transaction in transactions) {
      // Filter transactions based on selected status
      if (selectedStatus != 'All' && transaction.status != selectedStatus) {
        continue; // Skip transactions that don't match the selected status
      }

      final String monthYear =
          DateFormat('MMMM yyyy').format(transaction.bookingDate);

      if (groupedTransactions[monthYear] == null) {
        groupedTransactions[monthYear] = [];
      }
      groupedTransactions[monthYear]!.add(transaction);
    }

    // Sorting the month keys
    final sortedMonthKeys = groupedTransactions.keys.toList()
      ..sort((a, b) {
        final dateA = DateFormat('MMMM yyyy').parse(a);
        final dateB = DateFormat('MMMM yyyy').parse(b);
        return dateB.compareTo(dateA);
      });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 10),
            const Text('Transaction History'),
          ],
        ),
        actions: [
          // Filter Dropdown
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: DropdownButton<String>(
              value: selectedStatus,
              onChanged: (String? newValue) {
                setState(() {
                  selectedStatus = newValue!;
                });
              },
              items: <String>['All', 'Confirmed', 'Cancelled']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: ListView.builder(
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
                  'As of $monthYear',
                  style: const TextStyle(
                    fontSize: 18,
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
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
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

  // Function to determine status icon
  Widget statusIcon(String status) {
    if (status == 'Confirmed') {
      return const Icon(Icons.check_circle, color: Colors.purple);
    } else if (status == 'Cancelled') {
      return const Icon(Icons.cancel, color: Colors.grey);
    } else {
      return const Icon(Icons.help_outline, color: Colors.grey);
    }
  }

  // Function to navigate to babysitter details
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
