// ignore_for_file: sized_box_for_whitespace, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_connect/get_model.dart';
import 'package:wifi_connect/service/server_controller.dart/server_controller.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // ignore: prefer_typing_uninitialized_variables
  var winner;
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
      init: ServerController(),
      builder: (controller) {
        return Scaffold(
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
                winner?.first == 'o' || winner?.first == 'x'
                    ? 'winner: Player ${winner.first}'
                    : '',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 150),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
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
                        child: FloatingActionButton(
                          heroTag: const Text('btn'),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(0)),
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            if (prefs.get('toxtat') == true) {
                              print('===============');
                              if (controller.gameLog[index].value != 'x') {
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
                                    print('winner === ${winner.first}');
                                    setState(() {});

                                    break;
                                  }
                                }

                                //    if (winner?.first == 'o' ||
                                //      winner?.first == 'x') {
                                //  print('golib jonatildi');
                                // controller.messageHandle('golib');

                                controller.messageHandle(sendingO);

                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool('toxtat', false);

                                controller.update();
                              }
                            }
                          },
                          child: Text(
                            controller.gameLog[index].value,
                            style: TextStyle(
                                fontSize: 33,
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
              winner != null
                  ? ElevatedButton(
                      onPressed: () {
                        controller.gameLog = a = [
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
                        controller.update();
                      },
                      child: const Text(
                        'clear',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ))
                  : const Text('dfvfbsdbd')
            ],
          ),
        );
      },
    );
  }
}
