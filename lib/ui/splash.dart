import 'package:flutter/material.dart';

import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_connect/ui/game_page.dart';
import 'package:wifi_connect/service/get_model.dart';
import 'package:wifi_connect/service/server_controller.dart/server_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ServerController controller = Get.put(ServerController());
  List<ReciveDataModel> a = [
    ReciveDataModel(index: 1, value: ''),
    ReciveDataModel(index: 2, value: ''),
    ReciveDataModel(index: 3, value: ''),
    ReciveDataModel(index: 4, value: ''),
    ReciveDataModel(index: 5, value: ''),
    ReciveDataModel(index: 6, value: ''),
    ReciveDataModel(index: 7, value: ''),
    ReciveDataModel(index: 8, value: ''),
    ReciveDataModel(index: 9, value: ''),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 55, 233),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 50,
            top: 150,
          ),
          child: SizedBox(
            width: 300,
            height: 300,
            child: Image.asset(
              'images/tictac.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 240),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Do you want to play a new game',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                    onPressed: () async {
                      controller.gameLog = a;

                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool("stopped", true);

                      // ignore: use_build_context_synchronously
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const GamePage();
                        },
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(220, 50),
                        backgroundColor: Colors.blue),
                    child: const Icon(
                      Icons.play_circle_fill_outlined,
                      color: Colors.white,
                      size: 50,
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
