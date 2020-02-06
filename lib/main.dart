import 'package:dice/screen/dice_screen.dart';
import 'package:dice/screen/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/history.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<History>(
        create: (context) => History(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dice App'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: 'Dices'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DiceScreen(),
            HistoryScreen(),
          ],
        ),
      ),
    );
  }
}
