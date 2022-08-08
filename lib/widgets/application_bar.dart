import 'package:flutter/material.dart';

class ApplicationBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  ApplicationBar({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Cryptmark",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode, color: Colors.black),
            onPressed: () {},
          ),
        ]);
  }
}
