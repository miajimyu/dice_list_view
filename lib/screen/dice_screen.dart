import 'package:quiver/iterables.dart';

import 'package:dice/model/dice.dart';
import 'package:dice/model/history.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/dice_list.dart';

class DiceScreen extends StatefulWidget {
  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  @override
  Widget build(BuildContext context) {
    final diceList = Provider.of<DiceList>(context);
    final history = Provider.of<History>(context, listen: false);

    void _updateMyItems(int oldIndex, int newIndex) {
      final _index = oldIndex < newIndex ? newIndex - 1 : newIndex;
      final _item = diceList.list[oldIndex];
      diceList.list
        ..remove(_item)
        ..insert(_index, _item);
    }

    return Scaffold(
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            _updateMyItems(oldIndex, newIndex);
          });
        },
        children: enumerate(diceList.list).map(
          (item) {
            return DiceItem(
              key: ValueKey(item),
              index: item.index,
              item: item.value,
              diceList: diceList,
              history: history,
            );
          },
        ).toList(),
      ),
    );
  }
}

class DiceItem extends StatelessWidget {
  const DiceItem({
    Key key,
    @required this.index,
    @required this.item,
    @required this.diceList,
    @required this.history,
  }) : super(key: key);

  final int index;
  final Dice item;
  final DiceList diceList;
  final History history;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item),
      onDismissed: (_) {
        diceList.remove(index);
      },
      background: DismissibleBackground(
        alignment: Alignment.centerLeft,
      ),
      secondaryBackground: DismissibleBackground(
        alignment: Alignment.centerRight,
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
                title: Center(
                  child: Text(
                    '${item.result}',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.display1.fontSize,
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
          trailing: Icon(Icons.menu),
        ),
      ),
    );
  }
}

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({
    Key key,
    @required this.alignment,
  }) : super(key: key);

  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      color: Colors.red,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete_forever),
      ),
    );
  }
}
