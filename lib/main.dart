import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/detail_result.dart';
import 'model/dice_list.dart';
import 'model/history.dart';
import 'model/result_dialog.dart';
import 'screen/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<History>(create: (_) => History()),
        ChangeNotifierProvider<DiceList>(create: (_) => DiceList()),
        ChangeNotifierProvider<ResultDialog>(create: (_) => ResultDialog()),
        ChangeNotifierProvider<DetailResult>(create: (_) => DetailResult()),
      ],
      child: MaterialApp(
        darkTheme: ThemeData.dark(),
        home: HomePage(),
      ),
    );
  }
}
