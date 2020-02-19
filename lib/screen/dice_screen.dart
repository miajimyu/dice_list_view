import 'package:dice/model/detail_result.dart';
import 'package:dice/model/result_dialog.dart';
import 'package:quiver/iterables.dart';

import 'package:dice/model/dice.dart';
import 'package:dice/model/history.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/dice_list.dart';
import '../widgets/dismissible_background.dart';

class DiceScreen extends StatefulWidget {
  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  @override
  Widget build(BuildContext context) {
    final diceList = Provider.of<DiceList>(context);
    final history = Provider.of<History>(context, listen: false);

    return Scaffold(
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            diceList.update(oldIndex, newIndex);
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

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text('Removed ${item.name}'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: diceList.undoRemove,
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item),
      onDismissed: (_) {
        diceList.remove(index);
        _showSnackBar(context);
      },
      background: const DismissibleBackground(
        alignment: Alignment.centerLeft,
      ),
      secondaryBackground: const DismissibleBackground(
        alignment: Alignment.centerRight,
      ),
      child: DiceCard(
        item: item,
        diceList: diceList,
        index: index,
        history: history,
      ),
    );
  }
}

class DiceCard extends StatelessWidget {
  const DiceCard({
    Key key,
    @required this.item,
    @required this.diceList,
    @required this.index,
    @required this.history,
  }) : super(key: key);

  final Dice item;
  final DiceList diceList;
  final int index;
  final History history;

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<ResultDialog>(context);
    final detailResult = Provider.of<DetailResult>(context);

    Text _buildTitle() {
      final baseTitle = '${item?.name} : ${item?.result}';

      final isShowResults =
          detailResult.isShowDetailResult && item.results.isNotEmpty;
      if (isShowResults) {
        return Text('$baseTitle ${item?.results}');
      }

      return Text(baseTitle);
    }

    Widget _buildResults() {
      if (detailResult.isShowDetailResult) {
        return Center(
          child: Text('${item.results}'),
        );
      } else {
        return Container();
      }
    }

    return Card(
      child: ListTile(
        title: _buildTitle(),
        onTap: () {
          diceList.roll(index);
          history.add(item);

          if (settings.isShowResultDialog) {
            showDialog<void>(
              context: context,
              builder: (_) => SimpleDialog(
                title: Center(
                  child: Text(
                    '${item.result}',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline3.fontSize,
                    ),
                  ),
                ),
                children: <Widget>[
                  Center(child: Text('${item.name}')),
                  _buildResults(),
                ],
              ),
            );
          }
        },
        trailing: Icon(Icons.reorder),
      ),
    );
  }
}
