import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: CardMatchingApp(),
    ),
  );
}

class CardMatchingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Matching Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Card Matching Game'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/cardbackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: provider.cards.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => provider.flipCard(index),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent, 
                ),
                child: Center(
                  child: provider.cards[index].isFaceUp
                      ? Text(
                          provider.cards[index].front,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold, 
                            color: Colors.yellow,
                          ),
                        )
                      : Image.asset('assets/jokerface.png'), 
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



