import 'package:dice/model/dice.dart';
import 'package:dice/model/history.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/dice_list.dart';

class DiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DiceList diceList = Provider.of<DiceList>(context);
    History history = Provider.of<History>(context, listen: false);

    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (_) {
              diceList.remove(index);
            },
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.delete_forever),
              ),
            ),
            key: ValueKey(diceList.list[index]),
            child: Card(
              child: ListTile(
                title: Text(
                    '${diceList.list[index].name} : ${diceList.list[index]?.result} ${diceList.list[index]?.results}'),
                onTap: () {
                  diceList.roll(index);
                  history.add(diceList.list[index]);
                },
              ),
            ),
          );
        },
        itemCount: diceList.list.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          diceList.add(Dice(faces: 6));
        },
      ),
    );
  }
}
