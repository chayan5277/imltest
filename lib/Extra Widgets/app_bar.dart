import 'package:flutter/material.dart';

import '../Constants/spacing.dart';

class GradientAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon;
  VoidCallback? onTapFunction;

  GradientAppBar(
      {super.key, required this.title, this.icon, this.onTapFunction});

  @override
  State<GradientAppBar> createState() => _GradientAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _GradientAppBarState extends State<GradientAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.yellow],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [gap(0), Text(widget.title), gap(30)],
        ),
        actions: [
          if (widget.icon !=
              null) // Only show the IconButton if icon is provided
            IconButton(
              icon: Icon(widget.icon!),
              onPressed: widget.onTapFunction,
            ),
        ],
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0, // Remove the shadow
      ),
    );
  }
}
