import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDropdown<T> extends StatelessWidget {
  final String? title;

  final List<DropdownMenuItem<T>>? items;

  final List<T>? data;
  final DropdownMenuItem<T> Function(T item, int index)? builder;

  final T? initialValue;

  final void Function(T? item) onSelect;

  final String? Function(T? item)? validator;

  const AppDropdown._internal({
    super.key,
    required this.title,
    required this.data,
    required this.items,
    required this.builder,
    required this.onSelect,
    required this.initialValue,
    required this.validator,
  });

  const AppDropdown.builder({
    Key? key,
    String? title,
    required List<T> data,
    required DropdownMenuItem<T> Function(T item, int index) builder,
    required void Function(T? item) onSelect,
    T? initialValue,
    String? Function(T? item)? validator,
  }) : this._internal(
         title: title,
         key: key,
         items: null,
         data: data,
         builder: builder,
         onSelect: onSelect,
         initialValue: initialValue,
         validator: validator,
       );

  const AppDropdown({
    Key? key,
    String? title,
    List<T>? data,
    List<DropdownMenuItem<T>>? items,
    DropdownMenuItem<T> Function(T item, int index)? builder,
    required void Function(T? item) onSelect,
    T? initialValue,
    String? Function(T? item)? validator,
  }) : this._internal(
         title: title,
         key: key,
         items: items,
         data: data,
         builder: builder,
         onSelect: onSelect,
         initialValue: initialValue,
         validator: validator,
       );
  @override
  Widget build(BuildContext context) {
    return getDropdown();
  }

  List<DropdownMenuItem<T>> _getDropdownMenuItems() {
    final List<DropdownMenuItem<T>> menuItems = [];
    for (var i = 0; i < data!.length; i++) {
      menuItems.add(builder!(data![i], i));
    }
    return menuItems;
  }

  Widget getDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "$title",
            style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 14),
          child: DropdownButtonFormField<T>(
            validator: validator,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            value: initialValue,
            icon: Icon(Icons.keyboard_arrow_down),
            onChanged: (v) {
              onSelect(v);
            },
            items: data != null ? _getDropdownMenuItems() : items,
          ),
        ),
      ],
    );
  }
}
