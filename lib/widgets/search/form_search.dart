import 'package:bionmed_app/screens/services/controller_service_on_call.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';




class FormSearch extends StatefulWidget {
  const FormSearch({
    Key? key,
    required this.hinText,
  }) : super(key: key);
  final String hinText;

  @override
  State<FormSearch> createState() => _FormSearchState();
}

class _FormSearchState extends State<FormSearch> {

  final myC = Get.put(ControllerServiceOnCall());

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [AppColor.shadow],
      ),
      child: TextFormField(
        onChanged: (value) {
          if(myC.controllerSearch.value.text == ""){
            myC.searchDoctor.clear();
          }else{

          myC.serviceSearch();
          }
        },
        controller: myC.controllerSearch,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.whiteColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColor.bluePrimary2.withOpacity(0.5), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColor.weakColor.withOpacity(0.6), width: 1.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          hintText: widget.hinText,
          hintStyle: const TextStyle(color: AppColor.weakColor, fontSize: 14),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: AppColor.bodyColor[500],
            ),
          ),
        ),
      ),
    );
  }
}
