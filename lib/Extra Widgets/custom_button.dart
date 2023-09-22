import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onTapFunction,
    this.buttonHeight = 55,
    required this.buttonColor,
    this.buttonTextColor,
    required this.radius,
    required this.gradientColors,
  });
  final String buttonText;
  final Color? buttonTextColor;
  final double radius;
  final VoidCallback onTapFunction;
  final double buttonHeight;
  final Color buttonColor;
  final List<Color> gradientColors; // Define gradient colors here

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: MaterialButton(
        elevation: 0,
        onPressed: onTapFunction,
        color: Colors.transparent, // Set transparent color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),

        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: TextStyle(
                    color: buttonTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
