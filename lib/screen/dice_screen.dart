import 'package:dice/model/history.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/dice_list.dart';

class DiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final diceList = Provider.of<DiceList>(context);
    final history = Provider.of<History>(context, listen: false);

    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          final item = diceList.list[index];
          return Dismissible(
            key: ValueKey(item),
            onDismissed: (_) {
              diceList.remove(index);
            },
            background: Container(
              alignment: Alignment.centerLeft,
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.delete_forever),
              ),
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.delete_forever),
              ),
            ),
            child: Card(
              child: ListTile(
                title: Text('${item?.name} : ${item?.result} ${item?.results}'),
                onTap: () {
                  diceList.roll(index);
                  history.add(item);

                  showDialog<void>(
                    context: context,
                    builder: (_) => SimpleDialog(
                      title: SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            '${item.result}',
                            style: TextStyle(
                              fontSize:
                                  Theme.of(context).textTheme.display1.fontSize,
                            ),
                          ),
                        ),
                      ),
                      children: <Widget>[
                        Center(child: Text('${item.name}')),
                        Center(child: Text('${item.results}')),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
        itemCount: diceList.list.length,
      ),
    );
  }
}
