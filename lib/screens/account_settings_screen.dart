import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../utils/constants.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Account',
        onBack: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Privacy'),
          _buildSettingsItem(
            context,
            Icons.lock,
            'Privacy Settings',
            'Manage your privacy preferences',
            () {
              // Navigate to privacy settings
            },
          ),
          _buildSettingsItem(
            context,
            Icons.security,
            'Security',
            'Manage your security settings',
            () {
              // Navigate to security settings
            },
          ),
          const SizedBox(height: 20),
          _buildSectionHeader('Account Information'),
          _buildSettingsItem(
            context,
            Icons.person,
            'Profile',
            'Your profile information',
            () {
              // Navigate to profile settings
            },
          ),
          _buildSettingsItem(
            context,
            Icons.phone,
            'Phone Number',
            'Your phone number',
            () {
              // Navigate to phone settings
            },
          ),
          _buildSettingsItem(
            context,
            Icons.email,
            'Email',
            'Your email address',
            () {
              // Navigate to email settings
            },
          ),
          const SizedBox(height: 20),
          _buildSectionHeader('Preferences'),
          _buildSettingsItem(
            context,
            Icons.notifications,
            'Notifications',
            'Manage notification settings',
            () {
              // Navigate to notification settings
            },
          ),
          _buildSettingsItem(
            context,
            Icons.language,
            'Language',
            'App language',
            () {
              // Navigate to language settings
            },
          ),
          const SizedBox(height: 20),
          _buildSectionHeader('Data and Storage'),
          _buildSettingsItem(
            context,
            Icons.storage,
            'Storage Usage',
            'Manage storage and data usage',
            () {
              // Navigate to storage settings
            },
          ),
          _buildSettingsItem(
            context,
            Icons.cloud_download,
            'Chat Backup',
            'Backup your chats',
            () {
              // Navigate to chat backup settings
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