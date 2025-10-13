import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/constants.dart';
import 'home_screen.dart';

class ContactPermissionScreen extends StatelessWidget {
  const ContactPermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    Icons.contacts,
                    size: 100,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Title
              const Text(
                'Access to Contacts',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                'To help you connect with friends and family, we need permission to access your contacts. This will allow you to easily find people you know on LinkUp.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Permission details
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
                    _buildPermissionItem(
                      Icons.person_add,
                      'Find friends automatically',
                      'See which of your contacts are on LinkUp',
                    ),
                    const SizedBox(height: 16),
                    _buildPermissionItem(
                      Icons.sync,
                      'Sync contacts',
                      'Keep your contact list up to date',
                    ),
                    const SizedBox(height: 16),
                    _buildPermissionItem(
                      Icons.security,
                      'Privacy protected',
                      'Your contacts are never shared without permission',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Action buttons
              CustomButton(
                text: 'Allow Access to Contacts',
                onPressed: () {
                  // In a real app, this would request actual permission
                  // For now, we'll just navigate to the home screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Continue without contacts',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 30,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}