import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/detail_result.dart';
import '../model/history.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<History>(
      builder: (context, value, child) {
        if (value.historys.isEmpty) {
          return Center(child: DiceIcon());
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
            ),
            itemCount: value.historys.length,
            itemBuilder: (context, index) {
              final i = value.historys.length - index - 1;
              return ListItem(
                result: value.historys[i].result,
                name: value.historys[i].diceName,
                results: value.historys[i].results,
                time: value.historys[i].dateTime,
              );
            },
          );
        }
      },
    );
  }
}

class DiceIcon extends StatelessWidget {
  Icon _buildIcon() {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildIcon(),
        const SizedBox(height: 20),
        Text('Empty', style: Theme.of(context).textTheme.headline4),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    this.result,
    this.name,
    this.results,
    this.time,
  });

  final int result;
  final String name;
  final List<int> results;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  result.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(name),
                    Text(DateFormat.Hms().format(time)),
                  ],
                ),
                Provider.of<DetailResult>(context).isShowDetailResult
                    ? Text(results.join(', '))
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
