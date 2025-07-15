import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_login/core/utils/UserJsonExporter.dart';
import 'package:scb_login/core/utils/user_storage_helper.dart';
import 'package:scb_login/features/auth/data/models/user_model.dart';
import 'package:scb_login/features/auth/presentation/cubit/login_cubit.dart';
import 'package:scb_login/features/auth/presentation/pages/forget_password_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showCustomDialog(BuildContext context, String status, String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(status),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          showCustomDialog(
              context, 'Success', 'You have logged in successfully');
        } else if (state is LoginFailure) {
          showCustomDialog(context, 'Failure', state.erroMsg);
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        final isFailLoading = state is LoginOfflineLoading;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Log in to manage your finances',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: usernameController,
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        iconColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        } else {
                          return null;
                        }
                      },
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () async {
                        final newUser = UserModel(
                          id: '1',
                          name: 'Alice',
                          email: 'alice@example.com',
                          password: 'pass123',
                        );

                        await UserStorageHelper.saveUser(newUser);
                        print('✅ User saved to Hive');

                        await UserJsonExporter.exportUsersToJsonFile();


                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ForgotPasswordPage()),
                        );
                      },
                      child: Container(
                        width: 380,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot password?',
                              style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        logInBtn(
                          context: context,
                          logInText: 'Log in',
                          isLoading: isLoading,
                          isOnline: true,
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: const Color(0xFF01528c),
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/face-id.png',
                                scale: 1.2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    logInBtn(
                      context: context,
                      logInText: 'Offline Log in',
                      isLoading: isFailLoading,
                      isOnline: false,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  GestureDetector logInBtn({
    required BuildContext context,
    required String logInText,
    required bool isLoading,
    required bool isOnline,
  }) {
    return GestureDetector(
      onTap: () {
        if (formKey.currentState!.validate()) {
          final username = usernameController.text;
          final password = passwordController.text;
          log('Logging in with $username and $password');

          if (isOnline) {
            context
                .read<LoginCubit>()
                .login(username: username, password: password);
          } else {
            context.read<LoginCubit>().offlineLogin();
          }
        }
      },
      child: Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF01528c),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  logInText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
