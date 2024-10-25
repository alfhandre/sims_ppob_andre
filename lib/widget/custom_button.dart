import 'package:flutter/material.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';

class CustomButton extends StatefulWidget {
  final void Function() onPressed;
  final String text;
  const CustomButton({super.key, required this.onPressed, required this.text});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Center(
        child: Roboto.regular(
          text: widget.text,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
