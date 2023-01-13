import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final Widget? leading;
  final Widget? trailing;
  final bool? isPassword;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool? readOnly;
  final String? Function(String?)? validator;
  const InputField({Key? key, required this.controller, this.hintText, this.labelText, this.leading, this.trailing, this.isPassword, this.keyboardType, this.onTap, this.onChanged, this.readOnly, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      // height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ?? false,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType,
        onTap: onTap,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          hintText: hintText,
          labelText: labelText,
          prefixIcon: leading,
          suffixIcon: trailing
        ),
      ),
    );
  }
}
