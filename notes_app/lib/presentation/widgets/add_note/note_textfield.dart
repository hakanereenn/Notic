import 'package:flutter/material.dart';

class NoteTextField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final TextStyle textStyle;
  final bool autoFocus;
  final FocusNode focusNode;
  final Function onSubmitted;
  final int maxLines;
  final TextEditingController textEditingController;
  NoteTextField({
    @required this.hintText,
    @required this.onChanged,
    @required this.textStyle,
    @required this.autoFocus,
    this.focusNode,
    this.onSubmitted,
    this.maxLines,
    this.textEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      style: textStyle,
      maxLines: maxLines,
      cursorWidth: 2,
      autofocus: autoFocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        hintStyle: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
