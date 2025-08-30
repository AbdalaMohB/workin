import 'package:flutter/material.dart';

class AppRadioList extends StatefulWidget {
  final List<Widget> labels;

  final int initialValue;

  final bool isForgetful;

  final bool isEnabled;

  final Function(int? idx) onChanged;

  final Color highlightColor;
  final Color splashColor;

  final EdgeInsets padding;
  final List<ShapeBorder> customBorders;

  final List<Widget> trailing;

  const AppRadioList._initial({
    super.key,
    required this.labels,
    required this.onChanged,
    required this.initialValue,
    required this.highlightColor,
    required this.splashColor,
    required this.padding,
    required this.customBorders,
    required this.trailing,
    required this.isEnabled,
    required this.isForgetful,
  });

  const AppRadioList({
    Key? key,
    List<Widget> labels = const [],
    required Function(int?) onChanged,
    int initialValue = 1,
    Color highlightColor = Colors.deepPurple,
    Color splashColor = Colors.black12,
    EdgeInsets padding = EdgeInsets.zero,
    List<ShapeBorder> customBorders = const [],
    List<Widget> trailing = const [],
    bool isEnabled = true,
    bool isForgetful = false,
  }) : this._initial(
         key: key,
         labels: labels,
         onChanged: onChanged,
         initialValue: initialValue,
         highlightColor: highlightColor,
         splashColor: splashColor,
         padding: padding,
         customBorders: customBorders,
         trailing: trailing,
         isEnabled: isEnabled,
         isForgetful: isForgetful,
       );

  @override
  State<StatefulWidget> createState() {
    return _AppRadioListState();
  }
}

class _AppRadioListState extends State<AppRadioList> {
  late int _value;
  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  Widget _getRadioDesign(int index) {
    return InkWell(
      customBorder: widget.customBorders.isEmpty
          ? null
          : widget.customBorders[index % widget.customBorders.length],
      splashColor: widget.splashColor,
      onTap: widget.isEnabled
          ? () {
              setState(() {
                _value = index + 1;
                widget.onChanged(_value);
              });
            }
          : null,
      child: Row(
        children: [
          SizedBox(
            child: Radio(
              value: index + 1,
              groupValue: widget.isForgetful ? widget.initialValue : _value,
              onChanged: null,
              fillColor: WidgetStateProperty.resolveWith((v) {
                if (v.contains(WidgetState.selected)) {
                  return widget.highlightColor;
                }
                return Colors.grey;
              }),
            ),
          ),
          widget.labels[index],
          Spacer(),
          Padding(
            padding: EdgeInsetsGeometry.only(right: 20),
            child: widget.trailing.isEmpty
                ? Text("")
                : widget.trailing[index % widget.trailing.length],
          ),
        ],
      ),
    );
  }

  Widget _getRadioColumn() {
    final List<Widget> radio = [];
    for (var i = 0; i < widget.labels.length; i++) {
      radio.add(_getRadioDesign(i));
    }
    return Padding(
      padding: widget.padding,
      child: Column(children: radio),
    );
  }
  //List<Widget> _getRadioList();

  @override
  Widget build(BuildContext context) {
    return _getRadioColumn();
  }
}
