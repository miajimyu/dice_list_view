import 'package:dice/screen/dice_screen.dart';
import 'package:dice/screen/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'model/dice_list.dart';
import 'model/history.dart';
import 'screen/add_dice_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          Provider<History>(create: (_) => History()),
          ChangeNotifierProvider<DiceList>(create: (_) => DiceList()),
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
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              Tooltip(
                message: 'Settings',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    // TODO
                  },
                ),
              ),
              Tooltip(
                message: 'Licenses',
                child: ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('Licenses'),
                    onTap: () async {
                      final packageInfo = await PackageInfo.fromPlatform();
                      final version = packageInfo.version;
                      showLicensePage(
                        context: context,
                        applicationVersion: version,
                      );
                    }),
              ),
            ],
          ),
        ),
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
}

class HomePageFAB extends StatelessWidget {
  const HomePageFAB({
    Key key,
    @required this.diceList,
  }) : super(key: key);

  final DiceList diceList;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<dynamic>(
          context: context,
          isScrollControlled: true,
          builder: (context) => ChangeNotifierProvider.value(
            value: diceList,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddDiceScreen(),
              ),
            ),
          ),
        );
      },
    );
  }
}
