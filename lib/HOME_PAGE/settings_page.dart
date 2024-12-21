import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SettingsPage(),
  ));
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isNotificationsEnabled = true;
  String selectedCountry = 'United States';
  final List<String> countries = ['United States', 'India', 'Canada', 'Australia'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.tealAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // My Account Section
            _buildListTile(
              context,
              title: 'My Account',
              icon: Icons.account_circle,
              targetPage: MyAccountPage(),
            ),
            Divider(color: Colors.white70),

            // Country/Region Dropdown
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.white),
              title: Text(
                'Country/Region',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              trailing: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCountry,
                  dropdownColor: Colors.tealAccent,
                  items: countries.map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (String? newCountry) {
                    setState(() {
                      selectedCountry = newCountry!;
                    });
                  },
                ),
              ),
            ),
            Divider(color: Colors.white70),

            // Notifications Toggle
            _buildListTile(
              context,
              title: 'Notifications',
              icon: Icons.notifications,
              targetPage: DetailsPage(
                title: 'Notifications',
                content: 'Manage your notification preferences here.',
              ),
            ),
            Divider(color: Colors.white70),

            // Available Storage
            _buildListTile(
              context,
              title: 'Available Storage',
              icon: Icons.storage,
              targetPage: DetailsPage(
                title: 'Available Storage',
                content: 'You have used 12.5 GB out of 50 GB available.',
              ),
            ),
            Divider(color: Colors.white70),

            // Support
            _buildListTile(
              context,
              title: 'Support',
              icon: Icons.help_outline,
              targetPage: DetailsPage(
                title: 'Support',
                content: 'Contact our support team for assistance.',
              ),
            ),
            Divider(color: Colors.white70),

            // Terms of Service
            _buildListTile(
              context,
              title: 'Terms of Service',
              icon: Icons.description,
              targetPage: DetailsPage(
                title: 'Terms of Service',
                content: 'Read the terms and conditions for using this app.',
              ),
            ),
            Divider(color: Colors.white70),

            // Privacy Policy
            _buildListTile(
              context,
              title: 'Privacy Policy',
              icon: Icons.privacy_tip,
              targetPage: DetailsPage(
                title: 'Privacy Policy',
                content: 'Learn how we protect and use your data.',
              ),
            ),
            Divider(color: Colors.white70),

            // Delete My Account
            _buildListTile(
              context,
              title: 'Delete My Account',
              icon: Icons.delete_forever,
              targetPage: DeleteAccountPage(),
            ),
            Divider(color: Colors.white70),

            // Save Button
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Save settings and go back
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B98F5),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Save Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {required String title, required IconData icon, required Widget targetPage}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
    );
  }
}

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
        backgroundColor: Colors.tealAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align content to top
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to left
          children: [
            Text(
              'Account Details',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Username: JohnDoe123',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Email: johndoe@example.com',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Highest Score: 2500',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to settings
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Back',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String title;
  final String content;

  const DetailsPage({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.tealAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            content,
            style: TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class DeleteAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete My Account'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to delete your account permanently? This action cannot be undone.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Account Deleted'),
                          content: Text(
                              'Your account has been successfully deleted.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                                Navigator.pop(context); // Return to settings
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to settings
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}