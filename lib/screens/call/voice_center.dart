import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/call/page_voice.dart';
import 'package:bionmed_app/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({Key? key}) : super(key: key);
  static const routeName = "/call_center_screen";

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  String title = "Call Center";
  String callId = "TestVoiceId";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ButtonPrimary(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VoiceScreen(
                        userid: "1111", userName: "Dokter", callId: callId)));
              },
              label: "Dokter"),
          verticalSpace(30),
          ButtonPrimary(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VoiceScreen(
                        userid: "2222", userName: "Pasien", callId: callId)));
              },
              label: "Pasien")
        ]),
      ),
    );
  }
}
