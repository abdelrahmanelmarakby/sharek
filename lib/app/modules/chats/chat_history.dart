import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharek/app/data/models/chat_model.dart';
import 'package:sharek/core/services/chat/private/private_chat.dart';

import 'views/recent_chats.dart';

class ChatHistory extends StatelessWidget {
  final String myId;

  const ChatHistory({super.key, required this.myId});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ChatRoom>>.value(
      value: PrivateChatService(myId: myId, hisId: '').getLastChatUser,
      initialData: const [],
      child: RecentChats(
        myId: myId,
      ),
    );
  }
}
