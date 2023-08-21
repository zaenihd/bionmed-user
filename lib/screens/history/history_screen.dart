import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/widgets/card/card_history.dart';
import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String title = "History";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        titleTextStyle: TextStyles.subtitle1,
        title: Text(title),
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.gradient1,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: defaultPadding),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return const CardHistory();
        },
      ),
    );
  }
}