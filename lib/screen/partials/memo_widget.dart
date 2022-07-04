import 'package:flutter/material.dart';

class MemoWidget extends StatefulWidget {
  final String title;

  final String message;

  final VoidCallback? action;

  MemoWidget({
    Key? key,
    required this.title,
    required this.message,
    this.action,
  }) : super(key: key);

  @override
  _MemoWidgetState createState() => _MemoWidgetState();
}

class _MemoWidgetState extends State<MemoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
