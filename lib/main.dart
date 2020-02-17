import 'package:dice/screen/dice_screen.dart';
import 'package:dice/screen/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'helper/shared_preferences_helpter.dart';
import 'model/detail_result.dart';
import 'model/dice_list.dart';
import 'model/history.dart';

import 'model/result_dialog.dart';
import 'widgets/drawer.dart';
import 'widgets/floating_action_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<History>(create: (_) => History()),
          ChangeNotifierProvider<DiceList>(create: (_) => DiceList()),
          ChangeNotifierProvider<ResultDialog>(create: (_) => ResultDialog()),
          ChangeNotifierProvider<DetailResult>(create: (_) => DetailResult()),
        ],
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
  final _widgetOptions = [
    DiceScreen(),
    HistoryScreen(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final diceList = Provider.of<DiceList>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dice App'),
          actions: _selectedIndex == 0 ? null : _buildActions(),
        ),
        drawer: const HomePageDrawer(),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.dice),
              title: Text('Dice'),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.history),
              title: Text('History'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        floatingActionButton:
            _selectedIndex == 0 ? HomePageFAB(diceList: diceList) : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  List<Widget> _buildActions() {
    final history = Provider.of<History>(context);
    if (history.historys.isEmpty) {
      return null;
    }
    return <Widget>[
      IconButton(
        tooltip: 'Clear history',
        icon: const Icon(Icons.delete_forever),
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (_) => AlertDialog(
              content: const Text('Clear history?'),
              actions: <Widget>[
                Tooltip(
                  message: 'CANCEL',
                  child: FlatButton(
                    child: const Text('CANCEL'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Tooltip(
                  message: 'CLEAR',
                  child: FlatButton(
                    child: const Text('CLEAR'),
                    onPressed: () {
                      history.clear();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      )
    ];
  }
}
