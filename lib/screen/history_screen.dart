import 'package:dice/model/history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<History>(
      builder: (context, value, child) {
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
            flex: 2,
            child: Container(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  result.toString(),
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
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
                Text(results.join(', ')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
