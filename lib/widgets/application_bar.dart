import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cryptmark/theme/theme_model.dart';

class ApplicationBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  ApplicationBar({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
          return AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            title: const Text(
              "Cryptmark",
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    themeNotifier.isDark
                        ? themeNotifier.isDark = false
                        : themeNotifier.isDark = true;
                  },
                  icon: Icon(themeNotifier.isDark
                      ? Icons.nightlight_rounded
                      : Icons.wb_sunny))
            ],
          );
        }));
  }
}
