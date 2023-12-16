import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:wifi_connect/bloc/draw_bloc.dart';
import 'package:wifi_connect/ui/game_page.dart';
import 'package:wifi_connect/service/get_model.dart';
import 'package:wifi_connect/methods/when_start.dart';
import 'package:wifi_connect/service/server_controller.dart/server_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DrawBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DesktopApp(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class DesktopApp extends StatefulWidget {
  const DesktopApp({
    super.key,
  });

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
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Wifi_connect',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: BlocConsumer<DrawBloc, DrawState>(
        listener: (context, state) {
          if (state is DrawSuccesState) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const GamePage();
              },
            ));
          }
        },
        builder: (context, state) {
          return GetBuilder<ServerController>(
            init: ServerController(),
            builder: (controller) {
              WhenStart().isStart(controller, context, a);
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 40)),
                      child: Text(controller.server!.running ? 'ON' : "OF"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        /////////////////////////////////
                        await controller.startOrStopServer();
                        Future.delayed(
                          const Duration(milliseconds: 500),
                          () => setState(() {}),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 40)),
                      child:
                          Text(controller.server!.running ? 'Stop' : "Start"),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
