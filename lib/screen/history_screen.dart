import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/detail_result.dart';
import '../model/history.dart';
import '../widgets/dice_icon.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<History>(
      builder: (context, value, child) {
        if (value.historys.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DiceIcon(),
                const SizedBox(height: 20),
                Text('Empty', style: Theme.of(context).textTheme.headline4),
              ],
            ),
          );
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

class ListItem extends StatelessWidget {
  const ListItem({
    this.result,
    this.name,
    this.results,
    this.time,
  });

  final String result;
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
                  result,
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
