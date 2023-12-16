import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_widget/flutter_timer_widget.dart';
import 'package:flutter_timer_widget/timer_controller.dart';
import 'package:flutter_timer_widget/timer_style.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_connect/service/get_model.dart';
import 'package:wifi_connect/service/server_controller.dart/server_controller.dart';
import 'package:wifi_connect/ui/splash.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int drawerCounter = 0;
  var winner = ['', '', ''];
  ServerController controllera = Get.put(ServerController());
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
    return GetBuilder<ServerController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Tic-Tac-Toe',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.blue,
          ),
          body: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                controller.firstWinner == 'aniqlovchi' ? 'winner Player:x' : '',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Text(
                winner.first == 'o' ? 'winner Player: o' : '',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              controller.firstWinner == 'aniqlovchi' ? bbb() : const Text(''),
              controller.whodraw == true ? bbbd() : const Text(''),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 150),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: controller.gameLog.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      width: 90,
                      height: 90,
                      child: FittedBox(
                        child: ElevatedButton(
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            if (prefs.get('toxtat') == true) {
                              if (controller.gameLog[index].value != 'x' &&
                                  controller.gameLog[index].value == '') {
                                ReciveDataModel set0 =
                                    ReciveDataModel(index: index, value: 'o');

                                controller.gameLog.insert(index, set0);
                                controller.gameLog
                                    .remove(controller.gameLog[index + 1]);
                                var sendingO = jsonEncode(
                                    {'encodeData': controller.gameLog});

                                var lines = [
                                  [
                                    '${controller.gameLog[0].value}',
                                    '${controller.gameLog[1].value}',
                                    '${controller.gameLog[2].value}'
                                  ],
                                  [
                                    '${controller.gameLog[3].value}',
                                    '${controller.gameLog[4].value}',
                                    '${controller.gameLog[5].value}'
                                  ],
                                  [
                                    '${controller.gameLog[6].value}',
                                    '${controller.gameLog[7].value}',
                                    '${controller.gameLog[8].value}'
                                  ],
                                  [
                                    '${controller.gameLog[0].value}',
                                    '${controller.gameLog[3].value}',
                                    '${controller.gameLog[6].value}'
                                  ],
                                  [
                                    '${controller.gameLog[1].value}',
                                    '${controller.gameLog[4].value}',
                                    '${controller.gameLog[7].value}'
                                  ],
                                  [
                                    '${controller.gameLog[2].value}',
                                    '${controller.gameLog[5].value}',
                                    '${controller.gameLog[8].value}'
                                  ],
                                  [
                                    '${controller.gameLog[0].value}',
                                    '${controller.gameLog[4].value}',
                                    '${controller.gameLog[8].value}'
                                  ],
                                  [
                                    '${controller.gameLog[2].value}',
                                    '${controller.gameLog[4].value}',
                                    '${controller.gameLog[6].value}'
                                  ],
                                ];
                                for (var line in lines) {
                                  var first = line[0];
                                  var second = line[1];
                                  var third = line[2];
                                  // ignore: avoid_print
                                  if (first == second &&
                                      second == third &&
                                      first != '') {
                                    winner = line;

                                    // ignore: use_build_context_synchronously
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.topSlide,
                                      showCloseIcon: true,
                                      title: 'You Won',
                                      desc: 'Do you want to play again?',
                                      btnCancelOnPress: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return const SplashScreen();
                                          },
                                        ));
                                      },
                                      btnOkOnPress: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return const SplashScreen();
                                          },
                                        ));
                                      },
                                    ).show();
                                  }
                                }

                                //////////
                                ///
                                ///
                                ///

                                if (winner.first == 'o') {
                                  controller.messageHandle(sendingO);

                                  controller.messageHandle('golib');
                                } else {
                                  controller.messageHandle(sendingO);
                                }
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool('toxtat', false);
                              }
                            }

                            setState(() {});
                          },
                          ///////////////////
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              minimumSize: const Size(100, 100)),
                          child: Text(
                            controller.gameLog[index].value,
                            style: TextStyle(
                                fontSize: 60,
                                color: controller.gameLog[index].value == 'x'
                                    ? Colors.red
                                    : Colors.green),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  bbb() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 30,
      width: 10,
      child: FlutterTimer(
        duration: Duration.zero,
        onFinished: () {
          return AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.topSlide,
                  showCloseIcon: true,
                  title: 'You Failed',
                  desc: 'Do you want to play again?',
                  btnOkOnPress: () {
                    controllera.firstWinner = '';

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const SplashScreen();
                      },
                    ));
                  },
                  btnOkIcon: Icons.cancel,
                  btnOkColor: Colors.red)
              .show();
        },
        timerController: TimerController(
          elevation: 0,
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(0.0),
          background: Colors.red,
          timerStyle: TimerStyle.rectangular,
          timerTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
          subTitleTextStyle: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  bbbd() {
    return Container(
      height: 30,
      width: 10,
      child: FlutterTimer(
        duration: Duration.zero,
        onFinished: () {
          for (var drawitem in controllera.gameLog) {
            if (drawitem != '') {
              return AwesomeDialog(
                context: context,
                dialogType: DialogType.info,
                animType: AnimType.topSlide,
                showCloseIcon: true,
                title: 'Nobody won',
                desc: 'Do you want to play again?',
                btnOkOnPress: () {
                  controllera.whodraw = false;
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const SplashScreen();
                    },
                  ));
                },
              ).show();
            }
          }
        },
        timerController: TimerController(
          elevation: 0,
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(0.0),
          background: Colors.red,
          timerStyle: TimerStyle.rectangular,
          timerTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
          subTitleTextStyle: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
