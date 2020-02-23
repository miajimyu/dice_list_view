import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constans.dart';
import '../helper/shared_preferences_helpter.dart';
import '../model/detail_result.dart';
import '../model/dice_list.dart';
import '../model/history.dart';
import '../model/result_dialog.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          ShowDialogListTile(),
          ShowDetailResultListTile(),
          RestoreAllSettingsListTile(),
          LicensesListTile(),
          GitHubListTile(),
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
    const title = 'Show result dialog';
    final settings = Provider.of<ResultDialog>(context);

    return Tooltip(
      message: title,
      child: SwitchListTile(
        title: const Text(title),
        value: settings.isShowResultDialog,
        onChanged: (_) => settings.toggleShowResultDialog(),
      ),
    );
  }
}

class ShowDetailResultListTile extends StatefulWidget {
  @override
  _ShowDetailResultListTileState createState() =>
      _ShowDetailResultListTileState();
}

class _ShowDetailResultListTileState extends State<ShowDetailResultListTile> {
  @override
  Widget build(BuildContext context) {
    const title = 'Detailed results';
    final settings = Provider.of<DetailResult>(context);

    return Tooltip(
      message: title,
      child: SwitchListTile(
        title: const Text(title),
        value: settings.isShowDetailResult,
        onChanged: (_) => settings.toggleShowDetailResult(),
      ),
    );
  }
}

class RestoreAllSettingsListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Restore all settings',
      child: ListTile(
        leading: const Icon(Icons.restore),
        title: const Text('Restore all settings'),
        onTap: () {
          final diceList = Provider.of<DiceList>(context, listen: false);
          final detailResult =
              Provider.of<DetailResult>(context, listen: false);
          final resultDialog =
              Provider.of<ResultDialog>(context, listen: false);
          final history = Provider.of<History>(context, listen: false);

          showDialog<void>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Restore all settings?'),
              actions: <Widget>[
                Tooltip(
                  message: 'CANCEL',
                  child: FlatButton(
                    child: const Text('CANCEL'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Tooltip(
                  message: 'RESTORE',
                  child: FlatButton(
                    child: const Text('RESTORE'),
                    onPressed: () async {
                      await SharedPreferencesHelper.clearAll();
                      await diceList.restoreDefault();
                      await detailResult.restoreDefault();
                      await resultDialog.restoreDefault();
                      diceList.clearResults();
                      history.clear();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LicensesListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Licenses',
      child: ListTile(
        leading: const Icon(Icons.info),
        trailing: const Icon(Icons.navigate_next),
        title: const Text('Licenses'),
        onTap: () async {
          // TODO(miajimyu): package_info do not support for web, yet.
          // final packageInfo = await PackageInfo.fromPlatform();
          // final name = packageInfo.appName;
          // final version = packageInfo.version;
          showLicensePage(
            context: context,
            applicationName: kAppName,
            applicationVersion: kAppVersion,
          );
        },
      ),
    );
  }
}

class GitHubListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'GitHub',
      child: ListTile(
        leading: const Icon(FontAwesomeIcons.github),
        trailing: const Icon(Icons.navigate_next),
        title: const Text('GitHub'),
        onTap: () async {
          const url = 'https://github.com/miajimyu/dice_list_view';
          if (await canLaunch(url)) {
            await launch(url);
          }
        },
      ),
    );
  }
}
