import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../utils/constants.dart';

class PinnedMessagesScreen extends StatelessWidget {
  const PinnedMessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pinned Messages',
        onBack: () => Navigator.pop(context),
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Chat info
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index % 5 + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chat ${index % 5 + 1}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Pinned on ${DateTime.now().subtract(Duration(days: index % 30)).day}/${DateTime.now().subtract(Duration(days: index % 30)).month}/${DateTime.now().subtract(Duration(days: index % 30)).year}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.push_pin, color: AppColors.primary),
                      onPressed: () {
                        // Unpin message
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Message content
                Text(
                  'This is pinned message ${index + 1}. It contains important information that needs to be easily accessible.',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                // Message preview
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From: User ${index % 8 + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Message: ${_generateMessagePreview(index)}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _generateMessagePreview(int index) {
    List<String> messages = [
      'Hey, are we still meeting tomorrow?',
      'Don\'t forget to send the report',
      'The meeting has been rescheduled',
      'Can you check the latest design?',
      'Thanks for your help with this project',
      'Let\'s discuss this in detail',
      'I\'ve sent you the documents',
      'Please review and let me know',
      'The deadline has been extended',
      'We need to finalize this soon'
    ];
    return messages[index % messages.length];
  }
}