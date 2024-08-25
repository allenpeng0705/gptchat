import 'package:flutter/material.dart';
import 'package:pubnub/pubnub.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../models/message.dart';

class ChatProvider extends ChangeNotifier {
  final PubNub _pubnub;
  late Channel _channel;
  final List<types.Message> _messages = [];

  ChatProvider()
      : _pubnub = PubNub(
          defaultKeyset: Keyset(
            subscribeKey: 'sub-c-b4d93539-45d9-468f-bc53-0853afd1b693',
            publishKey: 'pub-c-baaf3394-7768-490c-bd5e-9344c24ba1cc',
            userId: const UserId('mobile:shileipeng0705@163.com'),
          ),
        ) {
    _channel = _pubnub.channel('chat:shileipeng0705@163.com');
    var subscription = _pubnub.subscribe(channels: {_channel.name});

    subscription.messages.listen((envelope) {
      final message = Message.fromJson(envelope.content);
      final chatMessage = types.TextMessage(
        author: message.user,
        createdAt: message.createdAt.millisecondsSinceEpoch,
        id: message.id,
        text: message.text,
      );

      _messages.insert(0, chatMessage);
      notifyListeners();
    });
  }

  List<types.Message> get messages => _messages;

  void sendMessage(String text, String userId) {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      createdAt: DateTime.now(),
      user: types.User(id: userId),
    );
    _channel.publish(message.toJson());

    final chatMessage = types.TextMessage(
      author: message.user,
      createdAt: message.createdAt.millisecondsSinceEpoch,
      id: message.id,
      text: text,
    );

    _messages.insert(0, chatMessage);
    notifyListeners();
  }
}
