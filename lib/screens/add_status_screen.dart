import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../utils/constants.dart';

class AddStatusScreen extends StatefulWidget {
  const AddStatusScreen({Key? key}) : super(key: key);

  @override
  State<AddStatusScreen> createState() => _AddStatusScreenState();
}

class _AddStatusScreenState extends State<AddStatusScreen> {
  final TextEditingController _statusController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _statusController.dispose();
    super.dispose();
  }

  Future<void> _postStatus() async {
    if (_statusController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a status message'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSending = true;
    });

    try {
      // Simulate posting status
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Status posted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to post status: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Status',
        onBack: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Profile picture
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Status input
            TextField(
              controller: _statusController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'What\'s on your mind?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Status options
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
                  _buildOptionItem(
                    Icons.camera_alt,
                    'Camera',
                    'Take a photo',
                    () {
                      // Open camera
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildOptionItem(
                    Icons.photo,
                    'Gallery',
                    'Choose from gallery',
                    () {
                      // Open gallery
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildOptionItem(
                    Icons.text_fields,
                    'Text',
                    'Add text to your status',
                    () {
                      // Add text options
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Post button
            CustomButton(
              text: 'Post Status',
              isLoading: _isSending,
              onPressed: _postStatus,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
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
      onTap: onTap,
    );
  }
}