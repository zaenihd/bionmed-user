import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/chat/page_chat.dart';
import 'package:bionmed_app/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatCenterScreen extends StatefulWidget {
  const ChatCenterScreen({Key? key}) : super(key: key);
  static const routeName = "/call_center_screen";

  @override
  State<ChatCenterScreen> createState() => _ChatCenterScreenState();
}

class _ChatCenterScreenState extends State<ChatCenterScreen> {
  String title = "Call Center";
  String callId = "TestVoiceId";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ButtonPrimary(
              onPressed: () async {
                await ZIMKit().connectUser(id: '1111', name: "Dokter");
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      const ChatScreen(userid: "1111", userName: "Dokter"),
                ));
              },
              label: "Dokter"),
          verticalSpace(30),
          ButtonPrimary(
              onPressed: () async {
                await ZIMKit().connectUser(id: '2222', name: "Pasien");
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      const ChatScreen(userid: "2222", userName: "Pasien"),
                ));
              },
              label: "Pasien")
        ]),
      ),
    );
  }
}
