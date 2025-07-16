import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_login/features/auth/presentation/cubit/login_cubit.dart';
import 'package:scb_login/features/auth/presentation/widgets/login_form.dart';
import 'package:scb_login/features/auth/presentation/widgets/register_form.dart';
import 'package:scb_login/injection_container.dart';
import '../widgets/background_section.dart';
import '../widgets/top_bar_section.dart';
import '../widgets/welcome_section.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool showRegisterForm = false; // ✅ Toggle state

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  void toggleForm() {
    setState(() {
      showRegisterForm = !showRegisterForm;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          BackgroundSection(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBarSection(),
                  const SizedBox(height: 340),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: WelcomeSection(
                      fadeAnimation: _fadeAnimation,
                      slideAnimation: _slideAnimation,
                    ),
                  ),
                  BlocProvider(
                    create: (context) => sl<LoginCubit>(),
                    child: showRegisterForm
                        ? RegisterForm(onSwitchToLogin: toggleForm)
                        : LoginForm(onSwitchToRegister: toggleForm),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
