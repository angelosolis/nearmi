import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState?> {
  String? message;
  Timer? timer;

  MessageBloc() : super(null) {
    on<MessageEvent>((event, emit) {
      const duration = Duration(seconds: 1);

      if (event.message != message) {
        Widget icon = Container();
        message = event.message;
        timer?.cancel();
        timer = Timer(duration, () => message = null);
        if (event.icon != null) {
          icon = Row(
            children: [event.icon!, const SizedBox(width: 12)],
          );
        }
        emit(
          MessageState(
            icon: icon,
            value: event.message,
            duration: event.duration ?? duration,
          ),
        );
      }
    });
  }
}
