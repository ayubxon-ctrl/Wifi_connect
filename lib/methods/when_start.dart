// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_connect/service/get_model.dart';

import '../ui/game_page.dart';
import '../service/server_controller.dart/server_controller.dart';

class WhenStart {
  isStart(ServerController controller, BuildContext context,
      List<ReciveDataModel> a) async {
    if (controller.serverLogs.contains("boshlash")) {
      controller.serverLogs.clear();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('toxtat', true);
      controller.gameLog = a;
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const GamePage();
        },
      ));

      controller.update();
    }
  }
}
