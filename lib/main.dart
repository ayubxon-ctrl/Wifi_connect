import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_connect/game_page.dart';
import 'package:wifi_connect/get_model.dart';
import 'package:wifi_connect/service/server_controller.dart/server_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DesktopApp(title: 'wifi connect'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DesktopApp extends StatefulWidget {
  const DesktopApp({super.key, required this.title});
  final String title;
  @override
  State<DesktopApp> createState() => _DesktopAppState();
}

class _DesktopAppState extends State<DesktopApp> {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<ServerController>(
          init: ServerController(),
          builder: (controller) {
            return Column(
              children: [
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () async {},
                  heroTag: 'onof',
                  child: Text(controller.server!.running ? 'ON' : "OFF"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    /////////////////////////////////
                    await controller.startOrStopServer();
                  },
                  child: Text(controller.server!.running ? 'Stop' : "Start"),
                ),
                const SizedBox(height: 10),
                controller.serverLogs.contains('boshlash')
                    ? Center(
                        child: FloatingActionButton(
                            heroTag: const Text('jonatucchi'),
                            onPressed: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('toxtat', true);

                              // ignore: use_build_context_synchronously
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const GamePage();
                                },
                              ));

                              controller.update();
                            },
                            child: const Text('start')),
                      )
                    : const Center(child: Text('null boldi'))
              ],
            );
          },
        ),
      ),
    );
  }
}
