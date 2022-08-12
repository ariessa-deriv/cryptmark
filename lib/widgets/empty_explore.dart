import 'dart:ui';

import 'package:cryptmark/routing/router.dart';
import 'package:flutter/material.dart';

class EmptyExplore extends StatefulWidget {
  const EmptyExplore({Key? key}) : super(key: key);

  @override
  State<EmptyExplore> createState() => _EmptyExploreState();
}

class _EmptyExploreState extends State<EmptyExplore> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/empty_explore.png'),
        Text(
          'There\'s always another coin.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20),
        Text(
          'Start searching now!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
