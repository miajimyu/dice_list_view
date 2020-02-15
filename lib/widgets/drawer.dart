import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import '../model/settings.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              },
            ),
          ),
          ShowDialogListTile(),
        ],
      ),
    );
  }
}

class ShowDialogListTile extends StatefulWidget {
  @override
  _ShowDialogListTileState createState() => _ShowDialogListTileState();
}

class _ShowDialogListTileState extends State<ShowDialogListTile> {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);

    return SwitchListTile(
      title: const Text('Show result dialog'),
      value: settings.isShowResultDialog,
      onChanged: (_) => settings.toggleShowResultDialog(),
    );
  }
}
