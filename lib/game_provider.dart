import 'package:flutter/material.dart';
import 'card_model.dart';
import 'dart:math';

class GameProvider with ChangeNotifier {
  List<CardModel> _cards = [];
  int? _firstCardIndex;
  int? _secondCardIndex;

  GameProvider() {
    _initializeCards();
  }

  List<CardModel> get cards => _cards;

  void _initializeCards() {
    List<String> faces = ['A', 'B', 'C', 'D', 'A', 'B', 'C', 'D'];
    faces.shuffle(Random());

    _cards = faces.map((face) => CardModel(front: face)).toList();
  }

  void flipCard(int index) {
    if (_cards[index].isFaceUp || _secondCardIndex != null) return;

    _cards[index].isFaceUp = true;
    notifyListeners();

    if (_firstCardIndex == null) {
      _firstCardIndex = index;
    } else {
      _secondCardIndex = index;
      Future.delayed(Duration(seconds: 1), _checkMatch);
    }
  }

  void _checkMatch() {
    if (_cards[_firstCardIndex!].front == _cards[_secondCardIndex!].front) {
    } else {
      _cards[_firstCardIndex!].isFaceUp = false;
      _cards[_secondCardIndex!].isFaceUp = false;
    }
    _firstCardIndex = null;
    _secondCardIndex = null;
    notifyListeners();
  }
}
