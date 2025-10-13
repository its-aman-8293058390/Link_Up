import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../utils/constants.dart';

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({Key? key}) : super(key: key);

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final List<Map<String, dynamic>> _allItems = [
    {'type': 'chat', 'name': 'John Doe', 'subtitle': 'Hey, how are you?'},
    {'type': 'chat', 'name': 'Family Group', 'subtitle': 'Mom: Dinner at 7 PM'},
    {'type': 'chat', 'name': 'Work Team', 'subtitle': 'Meeting tomorrow at 10 AM'},
    {'type': 'contact', 'name': 'Jane Smith', 'subtitle': 'jane@example.com'},
    {'type': 'contact', 'name': 'Mike Johnson', 'subtitle': 'mike@example.com'},
    {'type': 'message', 'name': 'Project Update', 'subtitle': 'Check the latest design'},
    {'type': 'message', 'name': 'Meeting Notes', 'subtitle': 'Action items from today'},
    {'type': 'status', 'name': 'Sarah\'s Status', 'subtitle': 'Posted 2 hours ago'},
    {'type': 'status', 'name': 'Team Update', 'subtitle': 'Posted 1 hour ago'},
  ];

  List<Map<String, dynamic>> get _filteredItems {
    if (_searchQuery.isEmpty) return [];
    return _allItems
        .where((item) => item['name']
            .toString()
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        onBack: () => Navigator.pop(context),
        child: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
      ),
      body: _searchQuery.isEmpty
          ? _buildEmptyState()
          : _filteredItems.isEmpty
              ? _buildNoResults()
              : _buildSearchResults(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Text(
            'Search for chats, messages, contacts, and more',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Text(
            'No results found for "$_searchQuery"',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        IconData icon;
        Color iconColor;

        switch (item['type']) {
          case 'chat':
            icon = Icons.chat;
            iconColor = AppColors.primary;
            break;
          case 'contact':
            icon = Icons.person;
            iconColor = AppColors.primary;
            break;
          case 'message':
            icon = Icons.message;
            iconColor = AppColors.primary;
            break;
          case 'status':
            icon = Icons.camera_alt;
            iconColor = AppColors.primary;
            break;
          default:
            icon = Icons.help;
            iconColor = Colors.grey;
        }

        return ListTile(
          leading: Icon(
            icon,
            color: iconColor,
          ),
          title: Text(
            item['name'],
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            item['subtitle'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          onTap: () {
            // Navigate to appropriate screen based on item type
          },
        );
      },
    );
  }
}