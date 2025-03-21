import 'package:flutter/material.dart';
import 'package:kohab/common/helpers/app_navigator.dart';
import 'package:kohab/core/components/my_button.dart';
import 'package:kohab/core/components/my_snackbar.dart';
import 'package:kohab/core/components/my_text_form_field.dart';
import 'package:kohab/features/auth/data/models/login_req_params.dart';
import 'package:kohab/features/auth/domain/usecases/login_usecase.dart';
import 'package:kohab/features/auth/presentation/pages/signup_page.dart';
import 'package:kohab/features/home/presentation/pages/home_page.dart';
import 'package:kohab/service_locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController, _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    if (password.length >= 8) {
      final result = await sl<LoginUsecase>().call(params: LoginReqParams(email: email, password: password));
      result.fold(
        (err) => MySnackbar.displayErrorMessage(err.toString(), context),
        (_) => AppNavigator.pushReplacement(context, const HomePage()),
      );
    } else {
      MySnackbar.displayErrorMessage('Password must be atleast 8 characters long', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              //TODO: replace with app logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 24),
              MyTextFormField(
                hintText: 'Email',
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 10),
              MyTextFormField(
                hintText: 'Password',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              MyButton(
                text: 'Login',
                onTap: login,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? '),
                  GestureDetector(
                    onTap: () => AppNavigator.push(context, const SignupPage()),
                    child: const Text(' Register here', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
