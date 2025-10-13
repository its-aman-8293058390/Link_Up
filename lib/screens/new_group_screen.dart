import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../utils/constants.dart';

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({Key? key}) : super(key: key);

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  final List<int> _selectedContacts = [];

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'New Group',
        onBack: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: () {
              // Create group
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Group name input
          Container(
            padding: const EdgeInsets.all(16),
            child: CustomTextField(
              controller: _groupNameController,
              labelText: 'Group Name',
              prefixIcon: Icons.group,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a group name';
                }
                if (value.length < 3) {
                  return 'Group name must be at least 3 characters';
                }
                return null;
              },
            ),
          ),
          // Selected contacts header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Text(
              'Selected: ${_selectedContacts.length}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Selected contacts list
          if (_selectedContacts.isNotEmpty)
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedContacts.length,
                itemBuilder: (context, index) {
                  int contactId = _selectedContacts[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Stack(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${contactId}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 10),
          // Contacts header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Text(
              'Select Contacts',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Contacts list
          Expanded(
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) {
                bool isSelected = _selectedContacts.contains(index);
                return Container(
                  color: Theme.of(context).cardColor,
                  child: ListTile(
                    leading: Container(
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
                    title: Text(
                      'Contact ${index + 1}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Last seen recently',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: Icon(
                      isSelected
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: isSelected ? AppColors.primary : Colors.grey,
                    ),
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedContacts.remove(index);
                        } else {
                          _selectedContacts.add(index);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Create group button
          Container(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'Create Group',
              onPressed: () {
                if (_selectedContacts.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select at least one contact'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                if (_groupNameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a group name'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                // Create group logic
              },
            ),
          ),
        ],
      ),
    );
  }
}