import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../transaction/transactionhistorydata.dart';
import '../transaction/transactionhistorymodel.dart';
import 'transactioninfopage.dart';
import '/styles/colors.dart';
import '/styles/theme_data.dart';

class TransactionHistoryPage extends StatefulWidget {
  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  String selectedStatus = 'All';
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Transaction>> groupedTransactions = {};

    // Grouping transactions by month and year
    for (var transaction in transactions) {
      // Filter transactions based on selected status
      if (selectedStatus != 'All' && transaction.status != selectedStatus) {
        continue;
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
      ),
      body: Column(
        children: [
          // Row for "Sort By" text and Dropdown Filter
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2), // Shadow color
                  spreadRadius: 2, // Shadow spread radius
                  blurRadius: 5, // Shadow blur radius
                  offset: const Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Current Date Text
                  Expanded(
                    flex: 2,
                    child: Text(
                      'As of $currentDate',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  // Sort By Text
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Sort By:',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                      textAlign: TextAlign.right,
                    ),
                  ),

                  const SizedBox(width: 10),
                  DropdownButton<String>(
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
                        child: Text(
                          value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }).toList(),
                    underline: Container(
                      height: 2,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

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
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
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
          ),
        ],
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
