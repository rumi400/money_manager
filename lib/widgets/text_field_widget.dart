import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final bool? readonly;
  final Widget? leading;
  final Widget? trailing;
  final String? hintText;
  final String? labelText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const TextFieldWidget({Key? key, required this.controller, this.hintText, this.labelText, this.onTap, this.readonly, this.leading, this.trailing, this.keyboardType, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 0),
      child: TextField(

        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        readOnly: readonly ?? false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            prefixIcon: leading,
            suffixIcon: trailing,
            border: const OutlineInputBorder(
                gapPadding: 0
            ),
            hintText: hintText,
            labelText: labelText,
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10)
        ),
      ),
    );
  }
}
