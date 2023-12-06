import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_connect/get_model.dart';
import 'package:wifi_connect/service/data_server.dart';

class ServerController extends GetxController {
  Server? server;
  List<String> serverLogs = [];
  List<ReciveDataModel> gameLog = [];

  Future<void> startOrStopServer() async {
    if (server!.running) {
      await server!.close();
      serverLogs.clear();
    } else {
      await server!.start();
    }
    update();
  }

  // Future<String?> getIp() async {
  //   return ip;
  // }

  @override
  void onInit() async {
    server = Server(onData, onError);

    startOrStopServer();
    super.onInit();
  }

  // sendMessage(dynamic msg) {
  //   // ignore: unrelated_type_equality_checks
  //   if (msg == 'boshlash') {
  //     serverLogs.add(msg);
  //     server?.write(msg);
  //     update();
  //   } else {
  //     print('+=+===========');
  //     print(msg);
  //     server?.write(msg);
  //   }

  //   update();
  // }

  onData(dynamic data) async {
    final recivedData = String.fromCharCodes(data);
    if (recivedData == 'boshlash') {
      serverLogs.add(recivedData);
    } else {
      gameLog = (jsonDecode(recivedData)["encodeData"])
          .map<ReciveDataModel>((e) => ReciveDataModel.fromJson(e))
          .toList();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('toxtat', true);
    }
    update();
  }

  onError(dynamic error) {
    debugPrint("Error: $error");
  }

  void messageHandle(dynamic msg) {
    if (msg == 'boshlash') {
      serverLogs.add(msg);
      server?.broadcast(msg);
      update();
    } else {
      server?.broadcast(msg);
    }
    update();
  }
}
