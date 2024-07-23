import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function()? onTap;

  const DefaultTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
   controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      keyboardType: keyboardType,
      onTap: onTap,
    );
  }
}
