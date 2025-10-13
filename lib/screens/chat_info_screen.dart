import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../utils/constants.dart';

class ChatInfoScreen extends StatelessWidget {
  final String chatName;
  final bool isGroup;
  
  const ChatInfoScreen({
    Key? key,
    required this.chatName,
    this.isGroup = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chat Info',
        onBack: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          // Chat info header
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).cardColor,
            child: Row(
              children: [
                // Profile picture
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isGroup ? Icons.group : Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chatName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isGroup ? 'Group · 5 members' : 'Online',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Edit chat name
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Media, links, and docs
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).cardColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMediaItem(Icons.photo, 'Media'),
                _buildMediaItem(Icons.insert_link, 'Links'),
                _buildMediaItem(Icons.insert_drive_file, 'Docs'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Chat settings
          _buildSectionHeader('Chat Settings'),
          _buildSettingsItem(
            context,
            Icons.notifications,
            'Mute Notifications',
            'Turn off notifications for this chat',
            () {
              // Toggle mute notifications
            },
          ),
          _buildSettingsItem(
            context,
            Icons.color_lens,
            'Chat Color',
            'Change the chat color',
            () {
              // Change chat color
            },
          ),
          _buildSettingsItem(
            context,
            Icons.wallpaper,
            'Chat Wallpaper',
            'Set a custom wallpaper',
            () {
              // Set chat wallpaper
            },
          ),
          const SizedBox(height: 20),
          if (isGroup) ...[
            _buildSectionHeader('Group Settings'),
            _buildSettingsItem(
              context,
              Icons.group,
              'Group Members',
              'View and manage group members',
              () {
                // View group members
              },
            ),
            _buildSettingsItem(
              context,
              Icons.exit_to_app,
              'Exit Group',
              'Leave this group',
              () {
                // Exit group
              },
            ),
          ] else ...[
            _buildSectionHeader('Contact Settings'),
            _buildSettingsItem(
              context,
              Icons.block,
              'Block',
              'Block this contact',
              () {
                // Block contact
              },
            ),
          ],
          const SizedBox(height: 20),
          // Danger zone
          _buildSectionHeader('Danger Zone'),
          _buildSettingsItem(
            context,
            Icons.delete,
            'Clear Chat',
            'Delete all messages in this chat',
            () {
              // Clear chat
            },
          ),
          _buildSettingsItem(
            context,
            Icons.delete_forever,
            'Delete Chat',
            'Delete this chat permanently',
            () {
              // Delete chat
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMediaItem(IconData icon, String title) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 30,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}