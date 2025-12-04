import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../utils/constants.dart';
import '../models/user_model.dart';
import 'profile_screen.dart'; // Changed from profile_setup_screen.dart
import 'account_settings_screen.dart';
import 'privacy_settings_screen.dart';
import 'theme_settings_screen.dart';
import 'help_screen.dart';
import 'invite_friends_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  UserModel? _userModel;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final snapshot = await _db.child('users').child(user.uid).get();
      
      if (snapshot.exists) {
        final userData = Map<String, dynamic>.from(snapshot.value as Map);
        setState(() {
          _userModel = UserModel.fromMap(userData, user.uid);
        });
      }
    } catch (e) {
      // Silently fail, we'll just show default values
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Profile section
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
                    child: Text(
                      _userModel?.displayName?.isNotEmpty == true 
                          ? _userModel!.displayName!.substring(0, 1).toUpperCase() 
                          : FirebaseAuth.instance.currentUser?.email?.substring(0, 1).toUpperCase() ?? 'U',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
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
                        _userModel?.displayName ?? 'User Name',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        FirebaseAuth.instance.currentUser?.email ?? 'user@example.com',
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
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(), // Changed to ProfileScreen
                      ),
                    );
                    // Refresh profile data when returning
                    if (result == true || result == null) {
                      _fetchUserProfile();
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Settings sections
          _buildSectionHeader('Account'),
          _buildSettingsItem(
            context,
            Icons.account_circle,
            'Profile',
            () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(), // Changed to ProfileScreen
                ),
              );
              // Refresh profile data when returning
              if (result == true || result == null) {
                _fetchUserProfile();
              }
            },
          ),
          _buildSettingsItem(
            context,
            Icons.settings,
            'Account',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountSettingsScreen(),
                ),
              );
            },
          ),
          _buildSettingsItem(
            context,
            Icons.lock,
            'Privacy',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacySettingsScreen(),
                ),
              );
            },
          ),
          _buildSettingsItem(
            context,
            Icons.color_lens,
            'Theme',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeSettingsScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildSectionHeader('More'),
          _buildSettingsItem(
            context,
            Icons.help,
            'Help',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpScreen(),
                ),
              );
            },
          ),
          _buildSettingsItem(
            context,
            Icons.group,
            'Invite Friends',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InviteFriendsScreen(),
                ),
              );
            },
          ),
          _buildSettingsItem(
            context,
            Icons.info,
            'About',
            () {
              // Show about dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('About LinkUp'),
                  content: const Text(
                    'LinkUp Chat App\nVersion 1.0.0\n\nA premium WhatsApp-like chat application built with Flutter and Firebase.',
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
          const SizedBox(height: 20),
          // Logout button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}