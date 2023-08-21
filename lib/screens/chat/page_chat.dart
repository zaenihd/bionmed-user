import 'package:bionmed_app/screens/chat/chat_poppup.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatScreen extends StatefulWidget {
  final String userid;
  final String userName;
  // final String callId;
  const ChatScreen({Key? key, required this.userid, required this.userName})
      : super(key: key);
  static const routeName = "/chat";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String title = "chat";

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesan"),
        actions: [
          ChatPopUp(
            userid: widget.userid,
          )
        ],
      ),
      body: ZIMKitConversationListView(
        onPressed: (context, conversation, defaultAction) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ZIMKitMessageListPage(
                  conversationID: conversation.id,
                  conversationType: conversation.type,
                  onMessageSent: (p0) {
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
