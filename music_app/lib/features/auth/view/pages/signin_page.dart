import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/theme/app_pallet.dart';
import 'package:music_app/core/widgets/circular_indicator.dart';
import 'package:music_app/core/utils/utils.dart';
import 'package:music_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:music_app/features/home/view/home_page.dart';
import '../../../../core/widgets/auth_gradient_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;
    ref.listen(authViewModelProvider, (prev, next) {
      next?.when(
        data: (data) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
            (_) => false,
          );
          showSnackBar(message: 'Login Successful', context: context);
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
                        'Sign In.',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 30),
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
                        text: 'Sign In',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await ref
                                .read(authViewModelProvider.notifier)
                                .loginUser(
                                  password: _passwordController.text.trim(),
                                  email: _emailController.text.trim(),
                                );
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            const TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(
                                color: Pallete.gradient2,
                                fontWeight: FontWeight.bold,
                              ),
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
