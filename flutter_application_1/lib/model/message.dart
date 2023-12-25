class Message {
  final String senderId;
  final String senderName;
  final String chatId;
  final String content;
  final DateTime sentTime;
  final MessageType messageType;

  const Message(
      {required this.senderId,
      required this.senderName,
      required this.chatId,
      required this.sentTime,
      required this.content,
      required this.messageType});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        chatId: json['chatId'],
        senderName: json['senderName'],
        senderId: json['senderId'],
        sentTime: json['sentTime'].toDate(),
        content: json['content'],
        messageType: MessageType.fromJson(json['messageType']),
      );

  Map<String, dynamic> toJson() => {
        'chatId': chatId,
        'senderId': senderId,
        'senderName': senderName,
        'sentTime': sentTime,
        'content': content,
        'messageType': messageType.toJson(),
      };
}

enum MessageType {
  text,
  image;

  String toJson() => name;

  factory MessageType.fromJson(String json) => values.byName(json);
}
