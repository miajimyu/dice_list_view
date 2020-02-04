import 'package:dice/widget/dice.dart';
import 'package:flutter/material.dart';

class DiceScreen extends StatefulWidget {
  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  final Set<Dice> _saved = Set<Dice>();

  bool isfavorite = false;

  List<Dice> dices = [
    Dice(faces: 2),
    Dice(faces: 4),
    Dice(faces: 6),
    Dice(number: 3, faces: 6),
    Dice(faces: 10),
    Dice(faces: 12),
    Dice(faces: 20),
    Dice(faces: 100),
  ];

  Widget _buildRow(Dice dice) {
    final bool alreadySaved = _saved.contains(dice);
    return Card(
      child: ListTile(
        title:
            Text('${dice.name} : ${dice?.result} ${dice?.resultAll?.toList()}'),
        onTap: () {
          setState(() {
            dice.roll();
          });
        },
        trailing: IconButton(
          icon: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
          ),
          onPressed: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(dice);
              } else {
                _saved.add(dice);
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildRow(dices[index]);
      },
      itemCount: dices.length,
    );
  }
}
