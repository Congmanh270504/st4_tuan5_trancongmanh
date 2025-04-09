import 'package:flutter/material.dart';
import 'package:st4_tuan5_trancongmanh/model/user.dart';
import 'edit_profile_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = sampleUsers;

  void _updateUser(User updatedUser) {
    setState(() {
      final index = users.indexWhere((user) => user.id == updatedUser.id);
      if (index != -1) {
        users[index] = updatedUser;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users'), centerTitle: false),
      body: ListView.separated(
        itemCount: users.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  user.profileImage != null
                      ? NetworkImage(user.profileImage!)
                      : null,
              child: user.profileImage == null ? Text(user.name[0]) : null,
            ),
            title: Text(user.name),
            subtitle: Text(user.email),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(user: user),
                ),
              );

              if (result != null && result is User) {
                _updateUser(result);
              }
            },
          );
        },
      ),
    );
  }
}
