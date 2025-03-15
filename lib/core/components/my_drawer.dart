import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kohab/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Center(
        child: CupertinoSwitch(
          value: Provider.of<ThemeProvider>(context).isDarkMode,
          onChanged: (_) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
        ),
      ),
    );
  }
}
