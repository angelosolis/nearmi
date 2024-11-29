part of 'message_bloc.dart';

class MessageEvent {
  final Widget? icon;
  final String message;
  final Duration? duration;

  MessageEvent({this.icon, required this.message, this.duration});
}
