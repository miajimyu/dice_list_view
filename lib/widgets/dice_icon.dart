import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiceIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final result = Random().nextInt(6) + 1;
    switch (result) {
      case 1:
        return Icon(FontAwesomeIcons.diceOne, size: 50);
        break;
      case 2:
        return Icon(FontAwesomeIcons.diceTwo, size: 50);
        break;
      case 3:
        return Icon(FontAwesomeIcons.diceThree, size: 50);
        break;
      case 4:
        return Icon(FontAwesomeIcons.diceFour, size: 50);
        break;
      case 5:
        return Icon(FontAwesomeIcons.diceFive, size: 50);
        break;
      case 6:
        return Icon(FontAwesomeIcons.diceSix, size: 50);
        break;
      default:
        return Icon(FontAwesomeIcons.diceD20, size: 50);
    }
  }
}
