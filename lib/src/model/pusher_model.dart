class PusherEvent {
  String? channelName;
  String? eventName;
  dynamic data;
  String? userId;

  PusherEvent({this.channelName, this.eventName, this.data, this.userId});
}
