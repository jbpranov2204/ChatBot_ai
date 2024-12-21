import 'package:ai/HOME_PAGE/game_page.dart';
import 'package:ai/HOME_PAGE/home_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
         brightness: Brightness.light
         
         
      ),
        home:CoinCollectingGame(),
        debugShowCheckedModeBanner: false,

    );
  }
}