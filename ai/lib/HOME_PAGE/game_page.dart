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
  double basketX = 0; // Horizontal position of the basket
  double coinX = 0; // Horizontal position of the coin
  double coinY = -1; // Vertical position of the coin
  int score = 0; // Current score
  int highScore = 0; // Highest score
  int missedCoins = 0; // Missed coins counter
  late Timer _timer;
  final double coinSpeed = 0.01; // Speed of the falling coin
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
        // Move the coin down
        coinY += coinSpeed;

        // Check if the coin hits the bottom
        if (coinY > 1) {
          missedCoins++;
          resetCoin();

          // Check if the player has missed 5 coins
          if (missedCoins >= 5) {
            endGame();
          }
        }

        // Check if the coin is caught by the basket
        if ((coinY > 0.9) &&
            (coinX - basketX).abs() < 0.2) {
          score++;
          resetCoin();
        }
      });
    });
  }

  void resetCoin() {
    coinX = random.nextDouble() * 2 - 1; // Random position between -1 and 1
    coinY = -1; // Reset to top
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

    // Show Game Over Dialog
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
      // Prevent basket from moving out of bounds
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
          // Score and Missed Coins Display
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
          // Coin
          Align(
            alignment: Alignment(coinX, coinY),
            child: Icon(
              Icons.monetization_on,
              color: Colors.amber,
              size: 40,
            ),
          ),
          // Basket
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
          // Controls
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => moveBasket(-0.1), // Move left
                  child: Icon(Icons.arrow_left),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => moveBasket(0.1), // Move right
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
