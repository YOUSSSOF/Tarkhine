import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utility/extentions.dart';

class YxField extends StatelessWidget {
  const YxField({
    Key? key,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.icon,
    this.onSubmit,
    this.onChanged,
    this.height,
    this.width,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.enabled,
  }) : super(key: key);
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Icon? icon;
  final double? height;
  final double? width;
  final int? maxLines;
  final bool? enabled;
  final Function(String?)? onSubmit;
  final Function(String?)? onChanged;
  final TextCapitalization textCapitalization;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        enabled: enabled,
        textCapitalization: textCapitalization,
        maxLines: maxLines,
        onFieldSubmitted: onSubmit,
        onChanged: onChanged,
        keyboardType: keyboardType,
        textDirection: TextDirection.rtl,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon,
          contentPadding: const EdgeInsets.only(bottom: 2, right: 10, left: 10),
          labelText: hint,
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: 'Estedad',
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      )
          .sizedBox(height: height ?? 35, width: width)
          .margin(width.nullOrNot ? 20 : 0),
    ).center;
  }
}
