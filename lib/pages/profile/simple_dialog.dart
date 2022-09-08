import 'package:flutter/material.dart';

class SimpleDialog extends StatelessWidget {
  const SimpleDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Simple Alert Dialog'),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('ok'),
        )
      ],
    );
  }
}
