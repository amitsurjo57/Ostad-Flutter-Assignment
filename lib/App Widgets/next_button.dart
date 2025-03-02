import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonActionName;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.onPressed,
    required this.buttonActionName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.maxFinite,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          buttonActionName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
