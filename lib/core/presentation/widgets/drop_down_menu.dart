import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({
    Key? key,
    required this.optionList,
    required this.callback,
  }) : super(key: key);

  final List<String> optionList;
  final void Function(String?) callback;

  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: (dropDownValue == null) ? widget.optionList.first : dropDownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        if (newValue != dropDownValue) {
          setState(() {
            dropDownValue = newValue!;
          });
          widget.callback(newValue);
        }
      },
      items: widget.optionList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
