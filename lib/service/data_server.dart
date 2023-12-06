// ignore_for_file: deprecated_member_use, unnecessary_string_interpolations

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

typedef Uint8ListCallback = Function(Uint8List data);
typedef DynamicCallback = Function(Uint8List data);
// Socket? socket;

class Server {
  Uint8ListCallback? onData;
  DynamicCallback? onError;
  Server(
    this.onData,
    this.onError,
  );
  ServerSocket? server;
  bool running = false;
  List<Socket> sockets = [];
  Future<void> start() async {
    runZoned(
      () async {
        server = await ServerSocket.bind('192.168.0.192', 4040);
        running = true;
        server!.listen(onRequest);
      },
      onError: onError,
    );
  }

  void onRequest(Socket socket) {
    if (!sockets.contains(socket)) {
      sockets.add(socket);
    }

    socket.listen((event) {
      onData!(event);
    });
  }

  // void write(dynamic message) {
  //   // ignore: avoid_print
  //   print('writing data ');
  //   socket?.write(message);
  // }
  Future<void> close() async {
    await server!.close();
    server = null;
    running = false;
  }

  void broadcast(dynamic data) {
    print('333');

    // ignore: avoid_print
    print('data $data');
    onData!(
      Uint8List.fromList(
        "$data".codeUnits,
      ),
    );

    for (final socket in sockets) {
      socket.write(data);
    }
  }
}
