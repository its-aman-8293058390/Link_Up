import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../utils/constants.dart';

class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  // In a real app, this would be stored in shared preferences
  int _selectedTheme = 0; // 0: System, 1: Light, 2: Dark

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Theme',
        onBack: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Select Theme'),
          _buildThemeOption(
            0,
            'System Default',
            'Use system theme settings',
            _selectedTheme == 0,
            () {
              setState(() {
                _selectedTheme = 0;
              });
            },
          ),
          _buildThemeOption(
            1,
            'Light Theme',
            'Bright and clean interface',
            _selectedTheme == 1,
            () {
              setState(() {
                _selectedTheme = 1;
              });
            },
          ),
          _buildThemeOption(
            2,
            'Dark Theme',
            'Easy on the eyes in low light',
            _selectedTheme == 2,
            () {
              setState(() {
                _selectedTheme = 2;
              });
            },
          ),
          const SizedBox(height: 30),
          // Preview section
          _buildSectionHeader('Preview'),
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: _selectedTheme == 2
                  ? AppColors.backgroundDark
                  : AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Theme Preview',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _selectedTheme == 2
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Button',
                      style: TextStyle(
                        color: _selectedTheme == 2
                            ? Colors.white
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
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

  Widget _buildThemeOption(
    int id,
    String title,
    String subtitle,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(
        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isSelected ? AppColors.primary : Colors.grey,
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
      onTap: onTap,
    );
  }
}