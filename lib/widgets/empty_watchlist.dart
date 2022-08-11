import 'dart:ui';

import 'package:cryptmark/routing/router.dart';
import 'package:flutter/material.dart';

class EmptyWatchlist extends StatefulWidget {
  const EmptyWatchlist({Key? key}) : super(key: key);

  @override
  State<EmptyWatchlist> createState() => _EmptyWatchlistState();
}
// TODO: Use image without background

class _EmptyWatchlistState extends State<EmptyWatchlist> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/empty_watchlist.png'),
        Text(
          'There\'s nothing here.',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20),
        Text(
          'Add a new coin to get started!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, searchRoute);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: const Text('Add to Watchlist'),
          ),
        )
      ],
    );
  }
}
