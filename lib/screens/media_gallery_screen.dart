import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../utils/constants.dart';

class MediaGalleryScreen extends StatelessWidget {
  const MediaGalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Media Gallery',
        onBack: () => Navigator.pop(context),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            // Tab bar
            Container(
              color: Theme.of(context).cardColor,
              child: const TabBar(
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Photos'),
                  Tab(text: 'Videos'),
                  Tab(text: 'Documents'),
                ],
              ),
            ),
            // Tab views
            Expanded(
              child: TabBarView(
                children: [
                  // Photos tab
                  _buildMediaGrid(20, Icons.photo),
                  // Videos tab
                  _buildMediaGrid(10, Icons.videocam),
                  // Documents tab
                  _buildDocumentList(15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaGrid(int count, IconData icon) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: count,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 40,
              color: AppColors.primary,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDocumentList(int count) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: count,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(
                  Icons.insert_drive_file,
                  color: AppColors.primary,
                ),
              ),
            ),
            title: Text('Document ${index + 1}.pdf'),
            subtitle: Text('${(index * 123 + 456) % 1000} KB'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Open document
            },
          ),
        );
      },
    );
  }
}