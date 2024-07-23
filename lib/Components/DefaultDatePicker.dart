import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DefaultDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final DateTime? initialDate;
  final Function(DateTime) onDatePicked;

  const DefaultDatePicker({
    Key? key,
    required this.controller,
    required this.labelText,
    this.initialDate,
    required this.onDatePicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      readOnly: true,
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          final formattedDate = DateFormat('dd/MM/yyyy').format(date);
          controller.text = formattedDate;
          onDatePicked(date);
        }
      },
    );
  }
}
