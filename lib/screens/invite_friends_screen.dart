import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../utils/constants.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Invite Friends',
        onBack: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Illustration
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.group,
                  size: 100,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Title
            const Text(
              'Invite Friends',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              'Invite your friends to join LinkUp and connect with them anytime, anywhere.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Invite methods
            _buildInviteMethod(
              Icons.link,
              'Invite via Link',
              'Share a link with your friends',
              () {
                // Share invite link
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invite link copied to clipboard'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildInviteMethod(
              Icons.message,
              'Invite via SMS',
              'Send an SMS to your contacts',
              () {
                // Send SMS
              },
            ),
            const SizedBox(height: 16),
            _buildInviteMethod(
              Icons.email,
              'Invite via Email',
              'Send an email to your contacts',
              () {
                // Send email
              },
            ),
            const SizedBox(height: 16),
            _buildInviteMethod(
              Icons.share,
              'Share',
              'Share via other apps',
              () {
                // Share via other apps
              },
            ),
            const SizedBox(height: 40),
            // Referral code
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Your Referral Code',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'LINKUP123456',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Copy Code',
                    onPressed: () {
                      // Copy referral code
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Referral code copied to clipboard'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteMethod(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.primary,
          size: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}