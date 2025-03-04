import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final VoidCallback onTap;

  const ChatListItem({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.onTap,
  });

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Chat'),
          content: Text('Are you sure you want to delete chat with $name?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement delete chat logic
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Chat with $name deleted'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // TODO: Implement undo delete
                      },
                    ),
                  ),
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: () => _showDeleteDialog(context),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(name[0]),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          time,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
