import 'package:babysitterapp/pages/chat/chatpage.dart'; // Import chatpage
import 'package:babysitterapp/pages/homepage/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title:
            Text('Notification', style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: ListView(
        children: [
          // Existing notifications (rated babysitter + payment status)
          const NotificationCard(
            name: 'Emma Gill',
            time: '8 hours',
            reviews: 90,
            paymentStatus: 'Paid',
          ),
          const NotificationCard(
            name: 'Wayne Hill',
            time: '26 hours',
            reviews: 140,
            paymentStatus: 'Pending',
          ),
          const NotificationCard(
            name: 'Jennifer Conn',
            time: 'yesterday',
            reviews: 900,
            paymentStatus: 'Paid',
          ),
          const NotificationCard(
            name: 'Evelyn Larson',
            time: '6 seconds',
            reviews: 0,
            paymentStatus: 'Pending',
          ),

          // New "wants to connect" notification
          Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Babysitter Wants to Connect',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Anthony Parr wants to connect with you for babysitting services.',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ChatPage(),
                            ),
                          );
                        },
                        child: const Text('Accept'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          print('Connection declined');
                        },
                        child: const Text('Decline'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // New "Message from Babysitter" notification
          GestureDetector(
            onTap: () {
              // Navigate to ChatPage on tap
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ChatPage(),
                ),
              );
            },
            child: const Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/babysitter.jpg'),
                      radius: 25,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Message from a babysitter',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Hey there! I would love to chat about my babysitting services.',
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
