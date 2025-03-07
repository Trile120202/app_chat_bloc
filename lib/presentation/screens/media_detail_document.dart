import 'package:flutter/material.dart';

class MediaDetailScreen extends StatefulWidget {
  const MediaDetailScreen({super.key});

  @override
  State<MediaDetailScreen> createState() => _MediaDetailScreenState();
}

class _MediaDetailScreenState extends State<MediaDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Media'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Media'),
            Tab(text: 'Links'),
            Tab(text: 'Documents'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Media Grid
          GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 20, // Demo data
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://picsum.photos/200/200?random=$index',
                  fit: BoxFit.cover,
                ),
              );
            },
          ),

          // Links List
          ListView.builder(
            itemCount: 15, // Demo data
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.link),
                title: Text('Link ${index + 1}'),
                subtitle: Text('https://example${index + 1}.com'),
                onTap: () {
                  // TODO: Open link
                },
              );
            },
          ),

          // Documents List
          ListView.builder(
            itemCount: 10, // Demo data
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.file_present),
                title: Text('Document ${index + 1}'),
                subtitle: Text('${(index + 1) * 100} KB'),
                trailing: const Icon(Icons.download),
                onTap: () {
                  // TODO: Open document
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
