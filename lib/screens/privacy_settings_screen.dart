import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../utils/constants.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({Key? key}) : super(key: key);

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _lastSeen = true;
  bool _profilePhoto = true;
  bool _about = true;
  bool _readReceipts = true;
  bool _groupInvites = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Privacy',
        onBack: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Who can see my personal info'),
          _buildSwitchSetting(
            'Last seen',
            'Allow others to see when you were last online',
            _lastSeen,
            (value) {
              setState(() {
                _lastSeen = value;
              });
            },
          ),
          _buildSwitchSetting(
            'Profile photo',
            'Allow others to see your profile photo',
            _profilePhoto,
            (value) {
              setState(() {
                _profilePhoto = value;
              });
            },
          ),
          _buildSwitchSetting(
            'About',
            'Allow others to see your about info',
            _about,
            (value) {
              setState(() {
                _about = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildSectionHeader('Messages'),
          _buildSwitchSetting(
            'Read receipts',
            'Allow others to see when you read their messages',
            _readReceipts,
            (value) {
              setState(() {
                _readReceipts = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildSectionHeader('Groups'),
          _buildSwitchSetting(
            'Group invites',
            'Allow others to add you to groups',
            _groupInvites,
            (value) {
              setState(() {
                _groupInvites = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildSectionHeader('Blocked contacts'),
          ListTile(
            leading: const Icon(
              Icons.block,
              color: AppColors.primary,
            ),
            title: const Text(
              'Blocked contacts',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            subtitle: const Text(
              'Manage blocked contacts',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to blocked contacts screen
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

  Widget _buildSwitchSetting(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      activeColor: AppColors.primary,
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
      value: value,
      onChanged: onChanged,
    );
  }
}