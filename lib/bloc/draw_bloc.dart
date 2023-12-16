// ignore_for_file: iterable_contains_unrelated_type

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:wifi_connect/service/server_controller.dart/server_controller.dart';

part 'draw_event.dart';
part 'draw_state.dart';

class DrawBloc extends Bloc<DrawEvent, DrawState> {
  ServerController controller = Get.put(ServerController());
  DrawBloc() : super(DrawInitial()) {
    Future<void> draw(
      WhoDrawEvent event,
      Emitter<DrawState> emit,
    ) async {
      if (controller.gameLog.contains('boshlash')) {
        emit(DrawSuccesState());
      } else {}
    }
  }
}
