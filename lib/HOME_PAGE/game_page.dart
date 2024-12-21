import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(CoinCollectingGame());
}

class CoinCollectingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoinGameScreen(),
    );
  }
}

class CoinGameScreen extends StatefulWidget {
  @override
  _CoinGameScreenState createState() => _CoinGameScreenState();
}

class _CoinGameScreenState extends State<CoinGameScreen> {
  double basketX = 0;
  double coinX = 0;
  double coinY = -1;
  int score = 0;
  int highScore = 0;
  int missedCoins = 0;
  late Timer _timer;
  final double coinSpeed = 0.01;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    resetGame();
    _timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        coinY += coinSpeed;

        if (coinY > 1) {
          missedCoins++;
          resetCoin();

          if (missedCoins >= 5) {
            endGame();
          }
        }

        if ((coinY > 0.9) &&
            (coinX - basketX).abs() < 0.2) {
          score++;
          resetCoin();
        }
      });
    });
  }

  void resetCoin() {
    coinX = random.nextDouble() * 2 - 1;
    coinY = -1;
  }

  void resetGame() {
    score = 0;
    missedCoins = 0;
    coinY = -1;
    coinX = random.nextDouble() * 2 - 1;
  }

  void endGame() {
    _timer.cancel();
    if (score > highScore) {
      highScore = score;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Your Score: $score\nHigh Score: $highScore"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              startGame();
            },
            child: Text("Restart"),
          ),
        ],
      ),
    );
  }

  void moveBasket(double direction) {
    setState(() {
      basketX += direction;
      if (basketX < -1) basketX = -1;
      if (basketX > 1) basketX = 1;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Score: $score",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Missed Coins: $missedCoins / 5",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(coinX, coinY),
            child: Icon(
              Icons.monetization_on,
              color: Colors.amber,
              size: 40,
            ),
          ),
          Align(
            alignment: Alignment(basketX, 0.9),
            child: Container(
              width: 80,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => moveBasket(-0.1),
                  child: Icon(Icons.arrow_left),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => moveBasket(0.1),
                  child: Icon(Icons.arrow_right),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
