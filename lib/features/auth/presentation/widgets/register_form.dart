import 'package:flutter/material.dart';
import 'package:scb_login/core/utils/user_storage_helper.dart';
import 'package:scb_login/features/auth/data/models/user_model.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onSwitchToLogin;

  const RegisterForm({super.key, required this.onSwitchToLogin});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalIdController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nationalIdController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool isStrongPassword(String password) {
    final regex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*(),.?":{}|<>]).{8,}$',
    );
    return regex.hasMatch(password);
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration Successful'),
        content: const Text('Your account has been created.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog

              // ✅ Clear form
              fullNameController.clear();
              emailController.clear();
              phoneController.clear();
              nationalIdController.clear();
              passwordController.clear();
              confirmPasswordController.clear();

              // ✅ Go back to login
              widget.onSwitchToLogin();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Text(
              'Create Bank Account',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            buildField(controller: fullNameController, label: 'Full Name'),
            buildField(
                controller: emailController,
                label: 'Email',
                type: TextInputType.emailAddress),
            buildField(
                controller: nationalIdController,
                label: 'National ID',
                type: TextInputType.number),
            buildPasswordField(passwordController, 'Password', true),
            buildPasswordField(
                confirmPasswordController, 'Confirm Password', false),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF01528c),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final newUser = UserModel(
                    id: nationalIdController.text,
                    name: fullNameController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  );

                  await UserStorageHelper.saveUser(
                      newUser); // ✅ Save user to Hive
                  showSuccessDialog(); // ✅ Show success dialog
                }
              },
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: widget.onSwitchToLogin,
              child: const Text(
                'Already have an account? Log in',
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField({
    required TextEditingController controller,
    required String label,
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter $label';
          return null;
        },
        decoration: _inputDecoration(label),
      ),
    );
  }

  Widget buildPasswordField(
      TextEditingController controller, String label, bool isMainPassword) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: isMainPassword ? obscurePassword : obscureConfirm,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter $label';
          if (isMainPassword && !isStrongPassword(value)) {
            return 'Password must be at least 8 characters\nInclude upper, lower, number, special char';
          }
          if (!isMainPassword && value != passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
        decoration: _inputDecoration(label).copyWith(
          suffixIcon: IconButton(
            icon: Icon(
              isMainPassword
                  ? (obscurePassword ? Icons.visibility : Icons.visibility_off)
                  : (obscureConfirm ? Icons.visibility : Icons.visibility_off),
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                if (isMainPassword) {
                  obscurePassword = !obscurePassword;
                } else {
                  obscureConfirm = !obscureConfirm;
                }
              });
            },
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
