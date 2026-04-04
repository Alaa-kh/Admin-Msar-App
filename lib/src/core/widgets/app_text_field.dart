import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.obscure = false,
    this.keyboardType,
    this.suffix,
    this.isValid = false,
    this.maxLines,
    this.minLines,
    this.textColor,
    this.hintColor,
    this.textDirection,
    this.hintTextDirection,
    this.onChanged,
    this.prefix,
    this.fillColor,
    this.formatter,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final Widget? prefix;
  final Color? fillColor;
  final bool isValid;
  final int? maxLines;
  final int? minLines;
  final Color? textColor;
  final Color? hintColor;
  final TextDirection? textDirection;
  final List<TextInputFormatter>? formatter;
  final TextDirection? hintTextDirection;
  final Function(String)? onChanged;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool hasText = false;
  bool isFocused = false;

  late FocusNode _focusNode;
  late TextDirection dynamicDirection;

  bool _isArabic(String text) {
    if (text.isEmpty) return false;
    final first = text.codeUnitAt(0);
    return (first >= 0x0600 && first <= 0x06FF) ||
        (first >= 0x0750 && first <= 0x077F);
  }

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    final initialText = widget.controller?.text ?? '';
    if (initialText.isEmpty) {
      dynamicDirection =
          widget.hintTextDirection ?? widget.textDirection ?? TextDirection.rtl;
      hasText = false;
    } else {
      hasText = true;
      if (widget.textDirection != null) {
        dynamicDirection = widget.textDirection!;
      } else {
        dynamicDirection = _isArabic(initialText)
            ? TextDirection.rtl
            : TextDirection.ltr;
      }
    }

    _focusNode.addListener(() {
      if (!mounted) return;
      setState(() => isFocused = _focusNode.hasFocus);
    });

    widget.controller?.addListener(() {
      if (!mounted) return;

      final text = widget.controller!.text;
      final filled = text.isNotEmpty;

      TextDirection newDirection = dynamicDirection;

      if (text.isEmpty) {
        newDirection =
            widget.hintTextDirection ??
            widget.textDirection ??
            TextDirection.rtl;
      } else {
        if (widget.textDirection != null) {
          newDirection = widget.textDirection!;
        } else {
          newDirection = _isArabic(text)
              ? TextDirection.rtl
              : TextDirection.ltr;
        }
      }

      if (filled != hasText || newDirection != dynamicDirection) {
        setState(() {
          hasText = filled;
          dynamicDirection = newDirection;
        });
      }

      widget.onChanged?.call(text);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMultiLine = widget.maxLines != null || widget.minLines != null;

    final Color borderColor = (isFocused || hasText)
        ? AppColors.primary
        : AppColors.border;

    final wrapperDirection = widget.textDirection ?? TextDirection.rtl;

    return Directionality(
      textDirection: wrapperDirection,
      child: Container(
        height: isMultiLine ? null : 64,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          inputFormatters: widget.formatter ?? [],
          focusNode: _focusNode,
          controller: widget.controller,
          obscureText: widget.obscure,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines ?? 1,
          minLines: widget.minLines,

          textDirection: dynamicDirection,
          textAlign: dynamicDirection == TextDirection.ltr
              ? TextAlign.left
              : TextAlign.right,

          style: TextStyle(
            color: widget.textColor ?? Colors.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor ?? Colors.white,
            labelText: widget.label,
            hintText: widget.hint,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 18,
            ),
            labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            hintStyle: TextStyle(
              color: widget.hintColor ?? const Color(0xff9B9B9B),
              fontSize: 13,
            ),
            suffixIcon: widget.suffix,
            prefixIcon: widget.prefix,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor, width: .3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor, width: .3),
            ),
          ),
        ),
      ),
    );
  }
}
