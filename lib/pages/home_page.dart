import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          )
        ]));
  }
}
