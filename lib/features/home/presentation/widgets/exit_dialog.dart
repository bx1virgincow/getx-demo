import 'package:flutter/material.dart';

AlertDialog buildAlertDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Exit'),
    content: const Text('Are you sure you want to exit?'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        child: const Text('Yes'),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context, false);
        },
        child: const Text(
          'No',
          style: TextStyle(color: Colors.red),
        ),
      ),
    ],
  );
}
