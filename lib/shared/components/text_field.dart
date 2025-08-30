import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_proj/resources/app_colors.dart';

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
       );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (0 == 5)
            Text(
              "Task",
              style: GoogleFonts.roboto(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

          Padding(
            padding: EdgeInsets.only(bottom: 15, top: 15),
            child: Text(
              "$title",
              style: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
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
                  color: Colors.black,
                ),

                //label: Text("Title"),
              ),
              style: GoogleFonts.roboto(fontSize: 15),
              maxLines: maxLines != null && maxLines! >= 1 ? maxLines : 1,
            ),
          ),
        ],
      ),
    );
  }
}
