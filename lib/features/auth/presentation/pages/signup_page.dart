import 'package:flutter/material.dart';
import 'package:kohab/core/components/my_snackbar.dart';
import 'package:kohab/core/components/my_text_form_field.dart';
import 'package:kohab/features/auth/data/models/sign_up_req_params.dart';
import 'package:kohab/features/auth/domain/usecases/signup_usecase.dart';
import 'package:kohab/features/home/presentation/pages/home_page.dart';

import 'package:kohab/service_locator.dart';
import 'package:reactive_button/reactive_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static route() => MaterialPageRoute(builder: (context) => const SignupPage());

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController _emailController, _passwordController, _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<dynamic> regsiter() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    if (password == confirmPassword) {
      await sl<SignupUsecase>().call(params: SignUpReqParams(email: email, password: password));
    } else {
      MySnackbar.displayErrorMessage('Passwords do not match', context);
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
              MyTextFormField(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 24),
              ReactiveButton(
                title: 'Register',
                activeColor: Theme.of(context).colorScheme.primary,
                onPressed: regsiter,
                onSuccess: () => Navigator.pushReplacement(context, HomePage.route()),
                onFailure: (error) => MySnackbar.displayErrorMessage(error.toString(), context),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(' Login here', style: TextStyle(fontWeight: FontWeight.bold)),
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
