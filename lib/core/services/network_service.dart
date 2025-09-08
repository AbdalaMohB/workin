import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  static NetworkService instance = NetworkService._internal();
  NetworkService._internal();

  late List<ConnectivityResult> connectivityStatus;
  late bool isConnected;
  Future<void> checkStatus() async {
    connectivityStatus = await (Connectivity().checkConnectivity());
  }

  Future<void> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isConnected = false;
    }
  }
}
