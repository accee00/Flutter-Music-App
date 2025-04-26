import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:music_app/core/theme/app_pallet.dart';
import 'package:music_app/features/auth/repositories/auth_remote_repo.dart';
import 'package:music_app/features/auth/view/pages/signin_page.dart';

import '../widgets/auth_gradient_button.dart';
import '../widgets/text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late TapGestureRecognizer _signInRecognizer;

  @override
  void initState() {
    _signInRecognizer =
        TapGestureRecognizer()
          ..onTap = () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SigninPage()),
            );
          };
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _signInRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              CustomField(hintText: "Name", controller: _nameController),
              const SizedBox(height: 15),
              CustomField(hintText: "Email", controller: _emailController),
              const SizedBox(height: 15),
              CustomField(
                hintText: "Password",
                controller: _passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 15),
              AuthGradientButton(
                text: 'Sign Up',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final res = await AuthRemoteRepo().signUp(
                      name: _nameController.text.trim(),
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );

                    final val = switch (res) {
                      fpdart.Left(value: final l) => l,
                      fpdart.Right(value: final r) => r,
                    };
                    print(val);
                  }
                },
              ),
              const SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  text: 'Already have an account?',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: ' Sign In',
                      style: const TextStyle(
                        color: Pallete.gradient2,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: _signInRecognizer,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
