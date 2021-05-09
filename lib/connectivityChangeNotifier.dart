import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityChangeNotifier extends ChangeNotifier {
  ConnectivityChangeNotifier() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      resultHandler(result);
    });
  }
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  String _svgUrl = 'images/serverDown.svg';
  String _pageText =
      'Currently connected to no network. Please connect to a wifi network!';

  ConnectivityResult get connectivity => _connectivityResult;
  String get svgUrl => _svgUrl;
  String get pageText => _pageText;

  void resultHandler(ConnectivityResult result) {
    _connectivityResult = result;
    if (result == ConnectivityResult.none) {
      _svgUrl = 'images/serverDown.svg';
      _pageText =
          'Currently connected to no network. Please connect to a wifi network!';
    } else if (result == ConnectivityResult.mobile) {
      _svgUrl = 'images/noWifi.svg';
      _pageText =
          'Currently connected to a celluar network. Please connect to a wifi network!';
    } else if (result == ConnectivityResult.wifi) {
      _svgUrl = 'images/connected.svg';
      _pageText = 'Connected to a wifi network!';
    }
    notifyListeners();
  }

  void initialLoad() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    resultHandler(connectivityResult);
  }
}
