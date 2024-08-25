import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../providers/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GPT4People Chat'),
      ),
      body: Chat(
        messages: chatProvider.messages,
        onSendPressed: (types.PartialText message) {
          chatProvider.sendMessage(message.text, 'your-user-id');
        },
        user: const types.User(id: 'your-user-id'),
      ),
    );
  }
}
