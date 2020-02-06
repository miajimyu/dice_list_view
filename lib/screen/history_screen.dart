import 'package:dice/model/history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<History>(
      builder: (context, value, child) {
        return ListView.builder(
          reverse: true,
          itemCount: value.historys.length,
          itemBuilder: (context, index) {
            return ListItem(
              result: value.historys[index].result,
              name: value.historys[index].name,
              results: value.historys[index].results,
              time: value.historys[index].dateTime,
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
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
      ),
    );
  }
}
