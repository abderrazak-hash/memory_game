import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memory_game/background.dart';
import 'package:memory_game/constants.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MemoryGame(),
    ),
  );
}

class MemoryGame extends StatelessWidget {
  const MemoryGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MemoryScreen();
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGround(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Center(child: Image.asset('assets/dash.png')),
              const Text(
                'Welcome To\nFlutter Forward Extended',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlayScreen(),
                ),
              );
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const FractionallySizedBox(
                widthFactor: .5,
                child: Center(
                  child: Text(
                    'Get Started >>',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGround(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Center(child: Image.asset('assets/card-back.png')),
              const SizedBox(height: 15),
              const Text(
                'Memory Bird',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Unleash Your Memory Skills\nwith Memory Bird',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MemoryScreen(),
                ),
              );
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const FractionallySizedBox(
                widthFactor: .5,
                child: Center(
                  child: Text(
                    'Train your brain >>',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Card {
  bool shown, stick;
  String image;
  int real;
  Card(
      {required this.image,
      this.shown = false,
      this.stick = false,
      this.real = -1});

  @override
  String toString() {
    return "$real -- $shown --";
  }
}

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  late List<Card> gameData = [];
  int score = 0;
  int plusToScore = 20;

  int face1 = -1, face2 = -1;
  int index1 = -1, index2 = -1;
  void initialize() {
    setState(() {
      score = 0;
      face1 = -1;
      face2 = -1;
      index1 = -1;
      index2 = -1;
      plusToScore = 20;
      gameData = [];
      List<int> numbers = List.generate(6, (index) => Random().nextInt(100));
      for (int i = 0; i < 12; i++) {
        gameData.add(
          Card(
              image: 'assets/card-back.png',
              real: numbers[i % 6],
              shown: false),
        );
      }
      gameData.shuffle();
    });
  }

  void play(index) {
    if (face1 == -1) {
      face1 = gameData[index].real;
      index1 = index;
    } else {
      face2 = gameData[index].real;
      index2 = index;
    }
    if (face2 != -1) {
      if (face1 != face2) {
        if (plusToScore > 5) {
          plusToScore -= 5;
          print(plusToScore);
        }
        Future.delayed(const Duration(milliseconds: 750)).then((value) {
          setState(() {
            gameData[index1].shown = false;
            gameData[index2].shown = false;
          });
        });
      } else {
        score = score + plusToScore;
        plusToScore += 5;
      }
      face1 = -1;
      face2 = -1;
    }
    test();
  }

  void test() {
    if (!gameData.any((card) => !card.shown)) {
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Congratulations',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: SizedBox(
            height: 80.0,
            child: Center(
              child: Text(
                'Your score: $score',
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          actions: [
            Center(
              child: IconButton(
                onPressed: () {
                  initialize();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.replay,
                  size: 35.0,
                  color: Colors.black,
                  semanticLabel: 'Restart',
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return BackGround(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text(
                'Memory Bird',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                width: 100,
                child: Divider(
                  color: altClr,
                  thickness: 4,
                ),
              ),
              Container(
                height: 45,
                width: 70.0,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF8d77E8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '$score',
                    style: const TextStyle(
                      color: mainClr,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myCard(gameData[0], 0),
                  myCard(gameData[1], 1),
                  myCard(gameData[2], 2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myCard(gameData[3], 3),
                  myCard(gameData[4], 4),
                  myCard(gameData[5], 5),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myCard(gameData[6], 6),
                  myCard(gameData[7], 7),
                  myCard(gameData[8], 8),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myCard(gameData[9], 9),
                  myCard(gameData[10], 10),
                  myCard(gameData[11], 11),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myCard(Card card, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          gameData[index].shown = true;
          play(index);
        });
      },
      child: gameData[index].shown
          ? Container(
              height: 100,
              width: 80.0,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${gameData[index].real}',
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            )
          : Container(
              height: 100,
              width: 80.0,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Image.asset(card.image),
              ),
            ),
    );
  }
}
