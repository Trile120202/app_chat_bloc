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

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              // User Profile Section
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.userName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '+1 234 567 890',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Chat Options
              _buildOptionTile(
                icon: Icons.notifications,
                title: 'Custom Notifications',
                onTap: () {
                  // TODO: Implement custom notifications
                  Navigator.pop(context);
                },
              ),
              _buildOptionTile(
                icon: Icons.lock,
                title: 'Protected Chat',
                onTap: () {
                  // TODO: Implement protected chat
                  Navigator.pop(context);
                },
              ),
              _buildOptionTile(
                icon: Icons.visibility_off,
                title: 'Hide Chat',
                onTap: () {
                  // TODO: Implement hide chat
                  Navigator.pop(context);
                },
              ),
              _buildOptionTile(
                icon: Icons.history,
                title: 'Hide Chat History',
                onTap: () {
                  // TODO: Implement hide chat history
                  Navigator.pop(context);
                },
              ),
              _buildOptionTile(
                icon: Icons.group_add,
                title: 'Add to Group',
                onTap: () {
                  // TODO: Implement add to group
                  Navigator.pop(context);
                },
              ),
              _buildOptionTile(
                icon: Icons.color_lens,
                title: 'Custom Chat Color',
                onTap: () {
                  // TODO: Implement custom chat color
                  Navigator.pop(context);
                },
              ),
              _buildOptionTile(
                icon: Icons.wallpaper,
                title: 'Custom Background',
                onTap: () {
                  // TODO: Implement custom background
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              // Danger Zone
              _buildOptionTile(
                icon: Icons.block,
                title: 'Block User',
                textColor: Colors.red,
                onTap: () {
                  // TODO: Implement block user
                  Navigator.pop(context);
                },
              ),
              _buildOptionTile(
                icon: Icons.delete,
                title: 'Clear Chat',
                textColor: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _messages.clear());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      onTap: onTap,
    );
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
            onPressed: () => _showOptions(context),
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
