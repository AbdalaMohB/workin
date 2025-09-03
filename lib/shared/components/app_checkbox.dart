import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  final Widget? label;

  bool initialState;

  final void Function(bool? value) onChange;

  final EdgeInsets padding;

  final Color checkedColor;

  AppCheckbox._initial({
    super.key,
    required this.label,
    required this.initialState,
    required this.onChange,
    required this.padding,
    required this.checkedColor,
  });

  AppCheckbox({
    Key? key,
    Widget? label,
    required Function(bool? value) onChange,
    bool initState = false,
    EdgeInsets padding = EdgeInsets.zero,
    Color checkedColor = Colors.purple,
  }) : this._initial(
         key: key,
         label: label,
         initialState: initState,
         onChange: onChange,
         padding: padding,
         checkedColor: checkedColor,
       );

  @override
  State<StatefulWidget> createState() {
    return _AppCheckboxState();
  }
}

class _AppCheckboxState extends State<AppCheckbox> {
  late bool? _value;

  @override
  void initState() {
    _value = widget.initialState;
    super.initState();
  }

  //TODO: REPLACE widget.initialState in build with _value for internal state management

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: InkWell(
        onTap: () {
          setState(() {
            widget.initialState = !widget.initialState;
          });
          widget.onChange(widget.initialState);
        },
        child: Row(
          children: [
            SizedBox(
              child: Checkbox(
                value: widget.initialState,
                onChanged: null,
                hoverColor: Colors.white,
                fillColor: WidgetStateProperty.resolveWith((v) {
                  if (v.contains(WidgetState.selected)) {
                    return widget.checkedColor;
                  }
                  return Colors.white;
                }),
              ),
            ),
            widget.label ?? Text(""),
          ],
        ),
      ),
    );
  }
}
