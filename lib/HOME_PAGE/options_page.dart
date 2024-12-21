import 'package:flutter/material.dart';

class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  String selectedLanguage = 'English'; // Default Language
  bool isSoundOn = true; // State for sound toggle
  bool isVibrationOn = false; // State for vibration toggle

  final List<String> languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50), // Space for top margin
              Center(
                child: Text(
                  'Game Options',
                  style: TextStyle(
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              ListTile(
                leading: Icon(Icons.volume_up, color: Colors.white),
                title: Text(
                  'Sound',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                trailing: Switch(
                  value: isSoundOn,
                  onChanged: (bool value) {
                    setState(() {
                      isSoundOn = value;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    isSoundOn = !isSoundOn;
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.vibration, color: Colors.white),
                title: Text(
                  'Vibration',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                trailing: Switch(
                  value: isVibrationOn,
                  onChanged: (bool value) {
                    setState(() {
                      isVibrationOn = value;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    isVibrationOn = !isVibrationOn;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Language',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.orange.shade700,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    isExpanded: true,
                    dropdownColor: Colors.orange[800],
                    items: languages.map((String language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(
                          language,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newLanguage) {
                      setState(() {
                        selectedLanguage = newLanguage!;
                      });
                    },
                  ),
                ),
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 39, 68),
                    padding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Back to Home',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}