import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kohab/common/helpers/app_navigator.dart';
import 'package:kohab/core/components/my_button.dart';
import 'package:kohab/core/components/my_snackbar.dart';
import 'package:kohab/core/theme/theme_provider.dart';
import 'package:kohab/features/auth/domain/usecases/logout_usecase.dart';
import 'package:kohab/features/auth/presentation/pages/login_page.dart';
import 'package:kohab/service_locator.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context).isDarkMode,
                onChanged: (_) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
              ),
            ),
            const Spacer(),
            MyButton(
              text: 'Logout',
              onTap: () async {
                final result = await sl<LogoutUsecase>().call();
                result.fold(
                  (err) => MySnackbar.displayErrorMessage(err, context),
                  (_) => AppNavigator.pushAndRemove(context, const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
