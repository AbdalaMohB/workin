import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workin/shared/resources/app_colors.dart';

String? _defaultValidator(String? input) {
  return null;
}

//class FormField can give anything a validator

class TaskFormField extends StatelessWidget {
  final String? title;

  final int? maxLines;

  final EdgeInsets padding;
  final obscuringCharacter = '*';
  final bool isObscured;
  final Widget? prefixIcon;
  final bool enable;
  final Function(DateTime? date)? onDatePicked;
  final String? value;
  final TextEditingController? controller;
  final String? Function(String? input) validator;
  final TextInputType keyboard;
  final Color borderColor;

  //private constructor for setting all data
  const TaskFormField._internal({
    super.key,
    required this.padding,
    required this.title,
    required this.maxLines,
    required this.prefixIcon,
    required this.enable,
    required this.onDatePicked,
    required this.value,
    required this.controller,
    required this.validator,
    required this.isObscured,
    required this.borderColor,
    required this.keyboard,
  });

  //named constructor for specific situations
  const TaskFormField.basic({
    Key? key,
    required String title,
    required int maxLines,
    Widget? prefixIcon,
    bool enable = true,
    Function(DateTime? date)? onDatePicked,
    String? value,
    TextEditingController? controller,
    String? Function(String? input) validator = _defaultValidator,
    EdgeInsets padding = EdgeInsets.zero,
    Color borderColor = Colors.blue,
    TextInputType keyboard = TextInputType.text,
  }) : this._internal(
         key: key,
         title: title,
         maxLines: maxLines,
         prefixIcon: prefixIcon,
         enable: enable,
         onDatePicked: onDatePicked,
         value: value,
         controller: controller,
         validator: validator,
         padding: padding,
         isObscured: false,
         borderColor: borderColor,
         keyboard: keyboard,
       );
  const TaskFormField.password({
    Key? key,
    required String title,
    required int maxLines,
    Widget? prefixIcon,
    bool enable = true,
    Function(DateTime? date)? onDatePicked,
    String? value,
    TextEditingController? controller,
    String? Function(String? input) validator = _defaultValidator,
    EdgeInsets padding = EdgeInsets.zero,
    Color borderColor = Colors.blue,
    TextInputType keyboard = TextInputType.text,
  }) : this._internal(
         key: key,
         title: title,
         maxLines: maxLines,
         prefixIcon: prefixIcon,
         enable: enable,
         onDatePicked: onDatePicked,
         value: value,
         controller: controller,
         validator: validator,
         padding: padding,
         isObscured: true,
         borderColor: borderColor,
         keyboard: keyboard,
       );

  const TaskFormField.selectDate({
    EdgeInsets padding = EdgeInsets.zero,
    Key? key,
    required String title,
    int? maxLines,
    required Widget prefixIcon,
    bool enable = false,
    required Function(DateTime? date) onDatePicked,
    String? value,
    TextEditingController? controller,
    String? Function(String? input) validator = _defaultValidator,
    Color borderColor = Colors.blue,
  }) : this._internal(
         key: key,
         title: title,
         maxLines: maxLines,
         prefixIcon: prefixIcon,
         enable: enable,
         onDatePicked: onDatePicked,
         value: value,
         controller: controller,
         validator: validator,
         padding: padding,
         isObscured: false,
         borderColor: borderColor,
         keyboard: TextInputType.text,
       );

  //normal constructor (gives user choice)
  const TaskFormField({
    Key? key,
    String? title,
    int? maxLines,
    Widget? prefixIcon,
    bool enable = false,
    Function(DateTime? date)? onDatePicked,
    String? value,
    TextEditingController? controller,
    String? Function(String? input) validator = _defaultValidator,
    EdgeInsets padding = EdgeInsets.zero,
    Color borderColor = Colors.blue,
    TextInputType keyboard = TextInputType.text,
  }) : this._internal(
         key: key,
         title: title,
         maxLines: maxLines,
         prefixIcon: prefixIcon,
         enable: enable,
         onDatePicked: onDatePicked,
         value: value,
         controller: controller,
         validator: validator,
         padding: padding,
         isObscured: false,
         borderColor: borderColor,
         keyboard: keyboard,
       );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () async {
              if (!enable) {
                final pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2025),
                  lastDate: DateTime(2026),
                );
                onDatePicked!(pickedDate);
              }
            },
            child: TextFormField(
              validator: validator,
              enabled: enable,
              controller: controller,
              obscuringCharacter: obscuringCharacter,
              obscureText: isObscured,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.secondaryFg,
                    width: 1,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor, width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                hintText: value != null ? "$value" : "$title",
                hintStyle: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: !enable ? FontWeight.bold : FontWeight.normal,
                  color: AppColors.secondaryText,
                ),

                //label: Text("Title"),
              ),
              style: GoogleFonts.roboto(
                fontSize: 15,
                color: AppColors.trietaryFg,
              ),
              maxLines: maxLines != null && maxLines! >= 1 ? maxLines : 1,
            ),
          ),
        ],
      ),
    );
  }
}
