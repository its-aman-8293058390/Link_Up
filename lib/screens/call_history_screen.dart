import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CallHistoryScreen extends StatelessWidget {
  const CallHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Call history list
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                bool isMissed = index % 5 == 0;
                bool isVideo = index % 3 == 0;
                
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Profile picture
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User ${index + 1}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  isMissed
                                      ? Icons.call_missed
                                      : isVideo
                                          ? Icons.videocam
                                          : Icons.call,
                                  size: 16,
                                  color: isMissed
                                      ? Colors.red
                                      : AppColors.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isMissed
                                      ? 'Missed call'
                                      : isVideo
                                          ? 'Video call'
                                          : 'Voice call',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isMissed
                                        ? Colors.red
                                        : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${index % 12 + 1}:${(index * 2) % 60}'.padLeft(2, '0'),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.call, color: AppColors.primary),
                        onPressed: () {
                          // Make call
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          // Navigate to new call screen
        },
        child: const Icon(
          Icons.add_call,
          color: Colors.white,
        ),
      ),
    );
  }
}