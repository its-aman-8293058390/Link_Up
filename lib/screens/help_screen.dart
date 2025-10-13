import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../utils/constants.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Help',
        onBack: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Getting Started'),
          _buildHelpItem(
            context,
            Icons.question_answer,
            'FAQ',
            'Frequently asked questions',
            () {
              // Show FAQ
            },
          ),
          _buildHelpItem(
            context,
            Icons.help,
            'How to use LinkUp',
            'Guide to using the app',
            () {
              // Show user guide
            },
          ),
          const SizedBox(height: 20),
          _buildSectionHeader('Contact Us'),
          _buildHelpItem(
            context,
            Icons.email,
            'Send Feedback',
            'Report issues or suggest improvements',
            () {
              // Open email client
            },
          ),
          _buildHelpItem(
            context,
            Icons.support,
            'Support',
            'Get help from our support team',
            () {
              // Open support chat
            },
          ),
          const SizedBox(height: 20),
          _buildSectionHeader('Legal'),
          _buildHelpItem(
            context,
            Icons.description,
            'Terms of Service',
            'Read our terms of service',
            () {
              // Show terms of service
            },
          ),
          _buildHelpItem(
            context,
            Icons.lock,
            'Privacy Policy',
            'Read our privacy policy',
            () {
              // Show privacy policy
            },
          ),
          const SizedBox(height: 20),
          _buildSectionHeader('About'),
          _buildHelpItem(
            context,
            Icons.info,
            'About LinkUp',
            'Learn more about the app',
            () {
              // Show about dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('About LinkUp'),
                  content: const Text(
                    'LinkUp Chat App\nVersion 1.0.0\n\nA premium WhatsApp-like chat application built with Flutter and Firebase.\n\n© 2023 LinkUp. All rights reserved.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
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

  Widget _buildHelpItem(
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