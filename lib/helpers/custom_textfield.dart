import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String name;
  final IconData prefixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;
  final TextInputAction textInputAction;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.name,
    required this.prefixIcon,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    required this.inputType,
    this.textInputAction = TextInputAction.done,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextField(
        enabled: true,
        controller: widget.controller,
        textCapitalization: widget.textCapitalization,
        maxLength: 32,
        maxLines: 1,
        obscureText: widget.name.toLowerCase() == 'password'
            ? _isHidden
            : widget.obscureText,
        keyboardType: widget.inputType,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Colors.black,
          height: 2,
          fontSize: 16,
        ),
        textInputAction: widget.textInputAction, // Pass the TextInputAction
        onSubmitted: (_) {},
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon),
          isDense: true,
          labelText: widget.name,
          counterText: "",
          labelStyle: const TextStyle(color: Colors.grey),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF16A34A),
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: widget.name.toLowerCase() == 'password'
              ? InkWell(
                  onTap: _togglePasswordView,
                  child: Icon(
                    _isHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
