import 'package:flutter/material.dart';
import '../widgets/chat_list_item.dart';
import 'chat_detail_screen.dart'; // Thêm import này

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Add Friend'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Add Friend screen
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat),
                title: const Text('New Chat'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to New Chat screen
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
        itemCount: 10,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ChatListItem(
            name: 'User $index',
            lastMessage: 'Last message from user $index',
            time: '12:00 PM',
            onTap: () {
              // Thêm navigation đến ChatDetailScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(
                    userName: 'User $index',
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showOptions(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
