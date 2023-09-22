import 'package:flutter/material.dart';

Widget textField({
  required TextEditingController controller,
  required String hintText,
  String? labelText,
  required double borderRadius,
  required bool obscure,
  required TextInputType keyboard,
  VoidCallback? onTap,
  VoidCallback? prefixTap,
  VoidCallback? hidePassword,
  IconData? prefixIcon,
  IconData? suffixIcon,
  IconData? icon,
  Color? fillColor, // Rename the parameter to fillColor
  int? maxLength,
  final focusNode,
  int? maxLines,
  bool showPrefixIcon = true,
  final String? Function(String?)? validator,
}) {
  return TextFormField(
    validator: validator,
    focusNode: focusNode,
    maxLines: maxLines,
    onTap: onTap,
    maxLength: maxLength,
    controller: controller,
    keyboardType: keyboard,
    obscureText: obscure,
    textAlign: TextAlign.left,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.yellow),
          borderRadius: BorderRadius.circular(borderRadius)),
      disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(borderRadius)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(borderRadius)),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(borderRadius)),
      suffixIcon: InkWell(
        onTap: hidePassword,
        child: Icon(
          suffixIcon,
          color: const Color(0xffACAEBD),
        ),
      ),
      prefixIcon: showPrefixIcon
          ? IconButton(
              splashRadius: 20,
              onPressed: prefixTap,
              icon: Icon(
                prefixIcon,
                color: Colors.black,
              ),
            )
          : null,
      contentPadding: EdgeInsets.symmetric(
          horizontal: showPrefixIcon ? 12 : 12, vertical: 16.5),
      labelText: labelText,
      hintText: hintText,
      filled: true,
      fillColor: fillColor,
      labelStyle: const TextStyle(
        letterSpacing: 0.6,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.black26,
      ),
      hintStyle: const TextStyle(
        letterSpacing: 0.6,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.black26,
      ),
    ),
  );
}

Widget textFieldSheet({
  required TextEditingController controller,
  required String hintText,
  String? labelText,
  required double borderRadius,
  required bool obscure,
  required TextInputType keyboard,
  VoidCallback? onTap,
  VoidCallback? suffixTap,
  IconData? suffixIcon,
  Color? fillColor, // Rename the parameter to fillColor
  int? maxLength,
  final focusNode,
  int? maxLines,
  final String? Function(String?)? validator,
}) {
  return TextFormField(
    validator: validator,
    focusNode: focusNode,
    maxLines: maxLines,
    onTap: onTap,
    maxLength: maxLength,
    controller: controller,
    keyboardType: keyboard,
    obscureText: obscure,
    textAlign: TextAlign.left,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(borderRadius)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(borderRadius)),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(borderRadius)),
      suffixIcon: IconButton(
        splashRadius: 20,
        onPressed: suffixTap,
        icon: Icon(
          suffixIcon,
          color: Colors.black,
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 16.5),
      labelText: labelText,
      hintText: hintText,
      filled: true,
      fillColor: fillColor,
      labelStyle: const TextStyle(
        letterSpacing: 0.6,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.black26,
      ),
      hintStyle: const TextStyle(
        letterSpacing: 0.6,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.black26,
      ),
    ),
  );
}
