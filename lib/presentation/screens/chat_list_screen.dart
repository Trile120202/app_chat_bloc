import 'package:flutter/material.dart';
import '../widgets/chat_list_item.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: 10, // Temporary demo count
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ChatListItem(
            name: 'User $index',
            lastMessage: 'Last message from user $index',
            time: '12:00 PM',
            onTap: () {
              // TODO: Navigate to chat detail
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Start new chat
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
