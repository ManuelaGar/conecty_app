import 'package:app_settings/app_settings.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'connectivityChangeNotifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          ConnectivityChangeNotifier changeNotifier =
              ConnectivityChangeNotifier();
          changeNotifier.initialLoad();
          return changeNotifier;
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Network Connectivity',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'Network Connectivity'),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: Center(
        child: Consumer<ConnectivityChangeNotifier>(
          builder: (BuildContext context,
              ConnectivityChangeNotifier connectivityChangeNotifier,
              Widget child) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: SvgPicture.asset(connectivityChangeNotifier.svgUrl,
                      fit: BoxFit.contain),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 100),
                    child: Text(
                      connectivityChangeNotifier.pageText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (connectivityChangeNotifier.connectivity !=
                    ConnectivityResult.wifi)
                  Flexible(
                    child: ElevatedButton(
                      child: Text('Open Settings'),
                      onPressed: () => AppSettings.openAppSettings(),
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
