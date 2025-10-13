import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../utils/constants.dart';
import 'chat_screen.dart';
import 'settings_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  final TextEditingController _chatNameController = TextEditingController();
  bool _isCreatingChat = false;

  @override
  void dispose() {
    _chatNameController.dispose();
    super.dispose();
  }

  Future<void> _createNewChat() async {
    if (_chatNameController.text.trim().isEmpty) return;

    setState(() {
      _isCreatingChat = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Create a new chat
      final chatRef = _db.child('chats').push();
      final chatId = chatRef.key;
      
      if (chatId == null) return;

      final chatData = {
        'name': _chatNameController.text.trim(),
        'createdBy': user.uid,
        'createdByName': user.email?.split('@')[0] ?? 'Unknown',
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'members': {
          user.uid: true,
        }
      };

      await chatRef.set(chatData);

      // Navigate to the chat screen
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(chatId: chatId),
          ),
        );
      }

      _chatNameController.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create chat: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isCreatingChat = false;
      });
    }
  }

  Future<void> _joinChat(String chatId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Add user to chat members
      await _db.child('chats').child(chatId).child('members').child(user.uid).set(true);

      // Navigate to the chat screen
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(chatId: chatId),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to join chat: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chat Rooms',
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigate to settings screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Create new chat section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatNameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter chat room name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (_) => _createNewChat(),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: _isCreatingChat ? null : _createNewChat,
                  icon: _isCreatingChat
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(),
                        )
                      : const Icon(
                          Icons.add,
                          color: AppColors.primary,
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Chat list
          Expanded(
            child: StreamBuilder<DatabaseEvent>(
              stream: _db.child('chats').onValue,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final chats = Map<String, dynamic>.from(
                  snapshot.data?.snapshot.value as Map? ?? {},
                );

                if (chats.isEmpty) {
                  return const Center(
                    child: Text('No chat rooms available. Create one to get started!'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chatId = chats.keys.elementAt(index);
                    final chatData = Map<String, dynamic>.from(chats[chatId] as Map);
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          chatData['name'] ?? 'Unnamed Chat',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              'Created by: ${chatData['createdByName'] ?? 'Unknown'}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Members: ${Map<String, dynamic>.from(chatData['members'] as Map? ?? {}).length}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        trailing: CustomButton(
                          text: 'Join',
                          onPressed: () => _joinChat(chatId),
                          color: AppColors.primary,
                        ),
                        onTap: () => _joinChat(chatId),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Status and Call buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to status screen
                    // For now, we'll show a snackbar as a placeholder
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Status feature coming soon!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera_alt, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Status'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to call screen
                    // For now, we'll show a snackbar as a placeholder
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Call feature coming soon!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.call, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Call'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}