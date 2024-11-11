import 'package:babysitterapp/pages/chat/chatpage.dart';
import 'package:babysitterapp/pages/homepage/babysitter_card.dart';
import 'package:babysitterapp/pages/homepage/notification_page.dart';
import 'package:babysitterapp/pages/location/babysitter_view_location.dart';
import 'package:babysitterapp/pages/profile/profilepage.dart';
import 'package:babysitterapp/styles/colors.dart';
import 'package:babysitterapp/styles/responsive.dart';
import 'package:babysitterapp/styles/size.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final int _unreadNotifications = 4;

  final String userName = 'John Doe';

  double _minRating = 0.0;
  double _minRate = 0.0;

  List<Map<String, dynamic>> babysitters = [
    {
      'name': 'Emma Gil',
      'rate': 200.0,
      'rating': 4.3,
      'reviews': 90,
      'profileImage': 'assets/images/female1.jpg',
    },
    {
      'name': 'Ken Takakura',
      'rate': 200.0,
      'rating': 4.7,
      'reviews': 140,
      'profileImage': 'assets/images/male3.jpg',
    },
    {
      'name': 'Granny',
      'rate': 200.0,
      'rating': 4.9,
      'reviews': 404,
      'profileImage': 'assets/images/female2.jpg',
    },
  ];

  List<Map<String, dynamic>> transactions = [
    {
      'date': '2024-11-10',
      'amount': 500.0,
      'babysitterName': 'Emma Gil',
    },
    {
      'date': '2024-11-09',
      'amount': 450.0,
      'babysitterName': 'Ken Takakura',
    },
    {
      'date': '2024-11-08',
      'amount': 300.0,
      'babysitterName': 'Granny',
    },
  ];

  List<Map<String, dynamic>> get filteredBabysitters {
    return babysitters.where((babysitter) {
      return babysitter['rating'] >= _minRating &&
          babysitter['rate'] >= _minRate;
    }).toList();
  }

  List<Widget> _widgetOptions(BuildContext context) => [
        Center(
          child: Text(
            'Home Page',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Center(
          child: Text(
            'Messages',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Center(
          child: Text(
            'Map',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Center(
          child: Text(
            'Profile',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BabysitterViewLocation(),
        ),
      );
    }
  }

  @override
  Widget _buildBabysitterSection(BuildContext context, String title,
      List<Map<String, dynamic>> babysitters) {
    final double screenHeight = sizeConfig.heightSize(context);

    return Container(
      padding: Responsive.getResponsivePadding(context),
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.1),
        borderRadius:
            BorderRadius.circular(Responsive.getBorderRadius(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: Responsive.getNameFontSize(context),
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              IconButton(
                icon: Icon(Icons.filter_list,
                    color: Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  _showFilterDialog(context);
                },
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: babysitters.map((babysitter) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(
                        babysitterId: "sample",
                      ),
                    ),
                  );
                },
                child: BabysitterCard(
                  name: babysitter['name'],
                  rate: 'Php ${babysitter['rate']}/hr',
                  rating: babysitter['rating'],
                  reviews: babysitter['reviews'],
                  profileImage: babysitter['profileImage'],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    final double screenWidth = sizeConfig.widthSize(context);
    final double screenHeight = sizeConfig.heightSize(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Hello, $userName',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: Responsive.getTextFontSize(context) * 1.5,
          ),
        ),
        actions: [
          Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              IconButton(
                icon: Icon(Icons.notifications,
                    color: Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ),
                  );
                },
              ),
              if (_unreadNotifications > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$_unreadNotifications',
                      style: TextStyle(
                        fontSize: Responsive.getTextFontSize(context),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: Responsive.getResponsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.01),
            // Section 1: Top Rated Babysitters
            _buildBabysitterSection(
                context, 'Top Rated Babysitters', filteredBabysitters),
            // Section 2: Total Transaction
            _buildTransactionSection(
                context, 'Total Transaction', transactions),
            // Section 3: Analytics (Modified)
            _buildAnalyticsSection(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        selectedItemColor: Theme.of(context).colorScheme.tertiary,
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ChatPage()),
                  );
                },
              ),
              label: 'Messages'),
          const BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Modified to show simple analytics content
  Widget _buildAnalyticsSection(BuildContext context) {
    final double screenHeight = sizeConfig.heightSize(context);

    // Calculate analytics data
    double averageRating = 0.0;
    double averageRate = 0.0;

    if (filteredBabysitters.isNotEmpty) {
      averageRating = filteredBabysitters
              .map((babysitter) => babysitter['rating'] as double)
              .reduce((a, b) => a + b) /
          filteredBabysitters.length;
      averageRate = filteredBabysitters
              .map((babysitter) => babysitter['rate'] as double)
              .reduce((a, b) => a + b) /
          filteredBabysitters.length;
    }

    return Container(
      padding: Responsive.getResponsivePadding(context),
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.1),
        borderRadius:
            BorderRadius.circular(Responsive.getBorderRadius(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Analytics',
                style: TextStyle(
                  fontSize: Responsive.getNameFontSize(context),
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              // Add the babysitter logo to the right
              Image.asset(
                'assets/images/app-logo.png', // Update with the actual path to the logo image
                height: 40.0, // You can adjust the size as needed
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          // Display average rating and average rate
          Text(
            'Average Rating: ${averageRating.toStringAsFixed(1)} / 5.0',
            style: TextStyle(
              fontSize: Responsive.getTextFontSize(context),
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Average Rate: Php ${averageRate.toStringAsFixed(2)} / hr',
            style: TextStyle(
              fontSize: Responsive.getTextFontSize(context),
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Total Babysitters: ${filteredBabysitters.length}',
            style: TextStyle(
              fontSize: Responsive.getTextFontSize(context),
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }

  // Modified to show transaction details instead of babysitter cards
  Widget _buildTransactionSection(BuildContext context, String title,
      List<Map<String, dynamic>> transactions) {
    final double screenHeight = sizeConfig.heightSize(context);

    return Container(
      padding: Responsive.getResponsivePadding(context),
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.1),
        borderRadius:
            BorderRadius.circular(Responsive.getBorderRadius(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.getNameFontSize(context),
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: transactions.map((transaction) {
              return ListTile(
                title: Text('${transaction['babysitterName']}'),
                subtitle: Text('Date: ${transaction['date']}'),
                trailing: Text('Php ${transaction['amount']}'),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter Babysitters'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Minimum Rating:'),
              Slider(
                value: _minRating,
                min: 0.0,
                max: 5.0,
                divisions: 5,
                onChanged: (value) {
                  setState(() {
                    _minRating = value;
                  });
                },
              ),
              Text('Minimum Rate:'),
              Slider(
                value: _minRate,
                min: 0.0,
                max: 1000.0,
                divisions: 10,
                onChanged: (value) {
                  setState(() {
                    _minRate = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }
}
