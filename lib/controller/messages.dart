//NOTE: This is temporary messages data fields

class Messages {
  final String id;
  final dynamic msg;
  final DateTime timestamp;
  bool isClicked;

  Messages({
    required this.id,
    required this.msg,
    required this.timestamp,
    required this.isClicked,
  });
}
