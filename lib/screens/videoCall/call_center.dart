import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/videoCall/page_call.dart';
import 'package:bionmed_app/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';

class CallCenterScreen extends StatefulWidget {
  const CallCenterScreen({Key? key}) : super(key: key);
  static const routeName = "/call_center_screen";

  @override
  State<CallCenterScreen> createState() => _CallCenterScreenState();
}

class _CallCenterScreenState extends State<CallCenterScreen> {
  String title = "Call Center";
  String callId = "TestCallId";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ButtonPrimary(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CallScreen(
                        userid: "1111", userName: "Dokter", callId: callId)));
              },
              label: "Dokter"),
          verticalSpace(30),
          ButtonPrimary(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CallScreen(
                        userid: "2222", userName: "Pasien", callId: callId)));
              },
              label: "Pasien")
        ]),
      ),
    );
  }
}
