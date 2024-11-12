import 'package:babysitterapp/pages/account/account_page.dart';
import 'package:babysitterapp/pages/help_and_support/help_and_support_page.dart';
import 'package:babysitterapp/pages/location/babysitter_view_location.dart';
import 'package:babysitterapp/pages/location/user_view_location.dart';
import 'package:babysitterapp/pages/payment/payment_page.dart';
import 'package:babysitterapp/pages/requirement/requirement_page.dart';
import 'package:babysitterapp/pages/search_page/search_page.dart';
import 'package:babysitterapp/services/firestore_service.dart';
import 'package:babysitterapp/styles/colors.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // firestore service to get user data
    final FirestoreService firestoreService = FirestoreService();

    // future builder to display current user
    var currentUser = FutureBuilder<Map<String, dynamic>?>(
      future: firestoreService.getCurrentUserData(),
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No user data found.'));
        } else {
          // Extract user data from snapshot
          String fullName = snapshot.data!['fullName'] ?? 'No Name';
          String email = snapshot.data!['email'] ?? 'No Email';
          String role = snapshot.data!['role'] ?? 'No Role';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(fullName,
                  style: const TextStyle(
                    fontSize: 20,
                    color: backgroundColor,
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              Text(
                role.toUpperCase(),
                style: const TextStyle(
                    fontSize: 15,
                    color: backgroundColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/profile/digong.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // display current user name, email and role
                      currentUser,
                      const SizedBox(height: 4),
                      const Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SettingsSection(
              title: 'GENERAL',
              items: [
                SettingsItem(
                    icon: Icons.check,
                    label: 'Get Verified',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const Reqpage()),
                      );
                    }),
                SettingsItem(
                    icon: Icons.notifications,
                    label: 'Notifications',
                    onTap: () {}),
                SettingsItem(
                    icon: Icons.receipt_long,
                    label: 'Transaction History',
                    onTap: () {}),
                SettingsItem(
                    icon: Icons.account_circle,
                    label: 'Account',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const AccountPage()),
                      );
                    }),
                SettingsItem(
                    icon: Icons.payment,
                    label: 'Payment',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const PaymentPage()),
                      );
                    }),
                SettingsItem(
                    icon: Icons.location_on,
                    label: 'Location',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const UserViewLocation()),
                      );
                    }),
              ],
            ),
            SettingsSection(
              title: 'SUPPORT & TERMS',
              items: [
                SettingsItem(
                  icon: Icons.devices,
                  label: 'Help and Support',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HelpAndSupportPage()));
                  },
                ),
                SettingsItem(
                  icon: Icons.privacy_tip,
                  label: 'Terms and Conditions/Privacy Policy',
                  onTap: () {},
                ),
              ],
            ),
            const SettingsSection(
              title: 'NOTIFICATIONS',
              items: [
                SettingsSwitchItem(label: 'Notifications'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SettingsSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SettingsItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(label),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}

class SettingsSwitchItem extends StatelessWidget {
  final String label;

  const SettingsSwitchItem({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: Switch(
        value: true,
        onChanged: (value) {},
        activeColor: Colors.purple,
      ),
    );
  }
}
