import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

// ignore: must_be_immutable
class InputPrimary extends StatefulWidget {
  final String hintText;
  final String? Function(String?)? validate;
  final Function(String) onChange;
  final Function() onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final bool obsecureText;
  final bool? enable;
  FocusNode? focusNode;

   InputPrimary({
    Key? key,
    this.hintText = '',
    this.validate,
    this.focusNode,
    required this.onChange,
    this.prefixIcon,
    this.suffixIcon,
    this.label = '',
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.obsecureText = false,
    this.enable = true,
    required this.onTap,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InputPrimaryState createState() => _InputPrimaryState();
}

class _InputPrimaryState extends State<InputPrimary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Insets.med),
      child: TextFormField(
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        enabled: widget.enable,
        enableInteractiveSelection: true,
        cursorColor: Colors.blueAccent,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: widget.onChange,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.obsecureText,
        inputFormatters: widget.inputFormatters,
        textCapitalization: widget.textCapitalization,
        validator: widget.validate,
        style: TextStyles.body2,
        decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.bgForm,
            suffixIcon: widget.suffixIcon,
            contentPadding: EdgeInsets.symmetric(
                horizontal: Insets.med, vertical: Insets.sm),
            hintText: widget.hintText,
            border: BorderStyles.enableTextField,
            focusedBorder: BorderStyles.focusTextField,
            enabledBorder: BorderStyles.enableTextField,
            errorBorder: BorderStyles.errorTextField,
            disabledBorder: BorderStyles.disableTextField,
            errorMaxLines: 5,
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints:
                BoxConstraints(minHeight: Sizes.lg, minWidth: Sizes.xl),
            hintStyle:
                TextStyles.body2.copyWith(color: AppColor.bodyColor.shade500)),
      ),
    );
  }
}
