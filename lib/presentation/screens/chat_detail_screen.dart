import 'package:flutter/material.dart';
import '../widgets/message_bubble.dart';

class ChatDetailScreen extends StatefulWidget {
  final String userName;

  const ChatDetailScreen({
    super.key,
    required this.userName,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.insert(0, {
        'message': _messageController.text,
        'isMe': true,
        'time': DateTime.now(),
      });
      _messageController.clear();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Text(widget.userName[0]),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userName),
                const Text(
                  'Online',
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.block),
                        title: const Text('Block User'),
                        onTap: () {
                          Navigator.pop(context);
                          // TODO: Implement block user
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete, color: Colors.red),
                        title: const Text(
                          'Clear Chat',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() => _messages.clear());
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.isEmpty ? 1 : _messages.length,
              itemBuilder: (context, index) {
                if (_messages.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'No messages yet. Start a conversation!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                final message = _messages[index];
                return MessageBubble(
                  message: message['message'],
                  isMe: message['isMe'],
                  time: '${message['time'].hour}:${message['time'].minute}',
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildAttachmentOption(
                                Icons.image,
                                'Image',
                                Colors.purple,
                              ),
                              _buildAttachmentOption(
                                Icons.camera_alt,
                                'Camera',
                                Colors.red,
                              ),
                              _buildAttachmentOption(
                                Icons.file_copy,
                                'File',
                                Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        // TODO: Implement attachment handling
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
