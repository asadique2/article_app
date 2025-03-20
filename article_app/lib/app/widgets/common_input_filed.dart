import 'package:article_app/app/widgets/common_text.dart';
import 'package:article_app/utils/text_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../themes/app_colors.dart';

class CommonInputField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final int? maxLength;
  final int? maxLine;
  final TextInputType inputType;
  final TextFieldWrapper wrapper;
  final bool isEnabled;
  final bool obscureText;
  final bool isHintCapital;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final validator;
  final String? prefixText;
  final TextStyle? hintStyle;

  const CommonInputField({
    super.key,
    required this.wrapper,
    this.isHintCapital = false,
    this.hintText = '',
    this.labelText = '',
    this.maxLength,
    this.maxLine = 1,
    this.inputType = TextInputType.text,
    this.isEnabled = true,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding,
    this.textInputAction,
    this.validator,
    this.inputFormatters,
    this.focusNode,
    this.onChanged,
    this.prefixText,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            maxLines: maxLine,
            controller: wrapper.controller,
            maxLength: maxLength,
            keyboardType: inputType,
            enabled: isEnabled,
            obscureText: obscureText,
            textInputAction: textInputAction,
            validator: validator,
            autovalidateMode: AutovalidateMode.disabled,
            inputFormatters: inputFormatters ?? [],
            focusNode: focusNode,
            decoration: InputDecoration(
              prefixText: prefixText,
              labelText: labelText,
              errorMaxLines: null,
              isDense: true,
              errorText: wrapper.errorText.isEmpty ? null : wrapper.errorText,
              hintStyle: hintStyle,
              counterText: '',
              fillColor: isEnabled ? Colors.white : Colors.grey.shade200,
              filled: true,
              hintText: isHintCapital ? hintText : hintText.capitalizeFirst,
              enabled: isEnabled,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              contentPadding: contentPadding,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              errorBorder: border(),
              border: border(),
              enabledBorder: border(),
              disabledBorder: border(),
              focusedBorder: border(),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.baseColor),
      borderRadius: BorderRadius.circular(8.r),
    );
  }
}
