import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatPopUp extends StatefulWidget {
  final String userid;

  const ChatPopUp({super.key, required this.userid});

  @override
  State<ChatPopUp> createState() => _ChatPopUpState();
}

class _ChatPopUpState extends State<ChatPopUp> {
  final userIDController = TextEditingController();
  final groupNameController = TextEditingController();
  final groupUsersController = TextEditingController();
  final groupIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      position: PopupMenuPosition.under,
      icon: const Icon(CupertinoIcons.add_circled),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'New Chat',
            child: const ListTile(
                leading: Icon(CupertinoIcons.chat_bubble_2_fill),
                title: Text('New Chat', maxLines: 1)),
            onTap: () =>
                ZIMKit().showDefaultNewPeerChatDialog(context),
          ),
          PopupMenuItem(
            value: 'New Group',
            child: const ListTile(
                leading: Icon(CupertinoIcons.person_2_fill),
                title: Text('New Group', maxLines: 1)),
            onTap: () => ZIMKit().showDefaultNewGroupChatDialog(context),
          ),
          PopupMenuItem(
            value: 'Join Group',
            child: const ListTile(
                leading: Icon(Icons.group_add),
                title: Text('Join Group', maxLines: 1)),
            onTap: () => ZIMKit().showDefaultJoinGroupDialog(context),
          ),
        ];
      },
    );
  }
}
