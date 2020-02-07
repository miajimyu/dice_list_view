import 'package:dice/model/history.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/dice_list.dart';

class DiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DiceList diceList = Provider.of<DiceList>(context);
    History history = Provider.of<History>(context, listen: false);

    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(
                '${diceList.list[index].name} : ${diceList.list[index]?.result} ${diceList.list[index]?.results}'),
            onTap: () {
              diceList.roll(index);
              history.add(diceList.list[index]);
            },
          ),
        );
      },
      itemCount: diceList.list.length,
    );
  }
}
