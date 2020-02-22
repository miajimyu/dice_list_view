import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../model/dice_list.dart';
import '../model/history.dart';
import '../model/result_dialog.dart';
import '../widgets/drawer.dart';
import '../widgets/floating_action_button.dart';
import 'dice_screen.dart';
import 'history_screen.dart';

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
          actions: _selectedIndex == 0 ? _builDicedActions() : _buildActions(),
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

  List<Widget> _builDicedActions() {
    final diceList = Provider.of<DiceList>(context, listen: false);
    final history = Provider.of<History>(context, listen: false);
    final settings = Provider.of<ResultDialog>(context);
    return <Widget>[
      IconButton(
        tooltip: 'Roll all dices',
        icon: const Icon(Icons.casino),
        onPressed: () {
          for (var i = 0; i < diceList.list.length; i++) {
            diceList.roll(i);
            history.add(diceList.list[i]);
          }

          if (settings.isShowResultDialog) {
            showDialog<void>(
              context: context,
              builder: (_) => SimpleDialog(
                children: <Widget>[
                  Center(
                    child: Text(
                      'Rolled all dices',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline4.fontSize,
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      )
    ];
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
