import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/theme/app_pallet.dart';
import 'package:music_app/core/widgets/circular_indicator.dart';
import 'package:music_app/core/utils/utils.dart';
import 'package:music_app/features/auth/view/pages/signin_page.dart';
import 'package:music_app/features/auth/viewmodel/auth_viewmodel.dart';

import '../../../../core/widgets/auth_gradient_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
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
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == false),
    );

    ref.listen(authViewModelProvider, (prev, next) {
      next?.when(
        data: (data) {
          showSnackBar(
            message: 'Account created successfully! Please login to continue!.',
            context: context,
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SigninPage()),
          );
        },
        error: (error, stack) {
          showSnackBar(message: error.toString(), context: context);
        },
        loading: () {},
      );
    });
    return Scaffold(
      appBar: AppBar(),
      body:
          isLoading
              ? const CustomCircularIndicator()
              : Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign Up.',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomField(
                        hintText: "Name",
                        controller: _nameController,
                      ),
                      const SizedBox(height: 15),
                      CustomField(
                        hintText: "Email",
                        controller: _emailController,
                      ),
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
                            await ref
                                .read(authViewModelProvider.notifier)
                                .signUpUser(
                                  name: _nameController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  email: _emailController.text.trim(),
                                );
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
                              text: 'Sign In',
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
