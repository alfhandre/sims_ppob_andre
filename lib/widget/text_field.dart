import 'package:flutter/material.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';
import '../theme.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle hintStyle;
  final Widget prefixIcon;
  final EdgeInsetsGeometry contentPadding;
  final bool isPassword;
  final String? Function(String?)? validator;
  final bool isError;
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.hintStyle,
    required this.prefixIcon,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
    this.isPassword = false,
    this.validator,
    this.isError = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      style: primaryTextStyle.copyWith(fontSize: 16),
      obscureText: _isObscure,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        contentPadding: widget.contentPadding,
        prefixIcon: IconTheme(
          data: IconThemeData(
            color: widget.isError ? Colors.orange[800] : Colors.black54,
            size: 18,
          ),
          child: SizedBox(
            width: 20,
            height: 20,
            child: widget.prefixIcon,
          ),
        ),
        suffixIcon: widget.isPassword ? _buildVisibilityToggle() : null,
        focusedBorder: _buildOutlineInputBorder(Colors.black87),
        errorBorder: _buildOutlineInputBorder(Colors.orange[800]!),
        border: _buildOutlineInputBorder(const Color(0xffB1B1B1)),
      ),
    );
  }

  Widget _buildVisibilityToggle() {
    return IconButton(
      icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
      onPressed: () {
        setState(() {
          _isObscure = !_isObscure;
        });
      },
    );
  }

  OutlineInputBorder _buildOutlineInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: borderColor),
    );
  }
}

class CustomTextFieldLabel extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextStyle hintStyle;
  final Widget prefixIcon;
  final EdgeInsetsGeometry contentPadding;
  final bool isPassword;
  final String? Function(String?)? validator;
  final bool isError;
  final TextInputType? keyboardType;
  final bool enabled;

  const CustomTextFieldLabel({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.hintStyle,
    required this.prefixIcon,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
    this.isPassword = false,
    this.validator,
    this.isError = false,
    this.keyboardType,
    required this.labelText,
    this.enabled = true,
  }) : super(key: key);

  @override
  _CustomTextFieldLabelState createState() => _CustomTextFieldLabelState();
}

class _CustomTextFieldLabelState extends State<CustomTextFieldLabel> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Roboto.regular(text: widget.labelText, fontSize: 14),
        const SizedBox(height: 4),
        TextFormField(
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          style: primaryTextStyle.copyWith(fontSize: 16),
          obscureText: _isObscure,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            contentPadding: widget.contentPadding,
            prefixIcon: IconTheme(
              data: IconThemeData(
                color: widget.isError ? Colors.orange[800] : Colors.black54,
                size: 18,
              ),
              child: SizedBox(
                width: 20,
                height: 20,
                child: widget.prefixIcon,
              ),
            ),
            suffixIcon: widget.isPassword ? _buildVisibilityToggle() : null,
            focusedBorder: _buildOutlineInputBorder(Colors.black87),
            errorBorder: _buildOutlineInputBorder(Colors.orange[800]!),
            border: _buildOutlineInputBorder(const Color(0xffB1B1B1)),
          ),
        ),
      ],
    );
  }

  Widget _buildVisibilityToggle() {
    return IconButton(
      icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
      onPressed: () {
        setState(() {
          _isObscure = !_isObscure;
        });
      },
    );
  }

  OutlineInputBorder _buildOutlineInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
