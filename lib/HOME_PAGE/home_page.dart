import 'package:ai/HOME_PAGE/game_page.dart';
import 'package:ai/HOME_PAGE/options_page.dart';
import 'package:ai/HOME_PAGE/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(GameHomePage());
}

class GameHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: IconButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingsPage(),
              ));
                  }, icon: Icon(Icons.settings)),
                )
              ],
              centerTitle: true,
              backgroundColor: Colors.tealAccent,
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.tealAccent, Colors.cyan],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/gif.json'),
                    Text(
                      'NAMMA FLUTTER BIRD',
                      style: GoogleFonts.roboto(
    textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
  ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CoinCollectingGame(),
              ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: Text('Veladlama!!', style: TextStyle(fontSize: 18)),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OptionsPage(),
              ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: Text('Game Options', style: TextStyle(fontSize: 18)),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
