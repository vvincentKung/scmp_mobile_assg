import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/helpers/exception_helper.dart';
import 'package:scmp_mobile_assg/managers/navigator_manager.dart';
import 'package:scmp_mobile_assg/repositories/login_repository.dart';
import 'package:scmp_mobile_assg/services/api_service.dart';
import 'package:scmp_mobile_assg/widgets/components/loading_indicator.dart';
import 'package:scmp_mobile_assg/widgets/login/components/login_button.dart';
import 'package:scmp_mobile_assg/widgets/login/components/login_error_dialog.dart';
import 'package:scmp_mobile_assg/widgets/login/components/login_form.dart';
import 'package:scmp_mobile_assg/widgets/login/login_page_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _viewModel = LoginPageViewModel(LoginRepository(ApiService()));

  @override
  void initState() {
    _viewModel.addListener(() {
      setState(() {});
    });
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_emailController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16.0,
                children: [
                  LoginForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  LoginButton(
                    onPressed: _viewModel.isLoading
                        ? null
                        : () => onLoginButtonPressed(context),
                  ),
                ],
              ),
            ),
          ),
          if (_viewModel.isLoading)
            LoadingIndicator(),
        ],
      ),
    );
  }

  Future onLoginButtonPressed(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    await _viewModel.login();

    if (_viewModel.error != null && context.mounted) {
      await showDialog(context: context, barrierDismissible: false, builder: (context) {
        return LoginErrorDialog(message: getExceptionMessage(_viewModel.error));
      });
      return;
    }

    if (_viewModel.token.isNotEmpty && context.mounted) {
      NavigatorManager().navigateToHome(context);
      return;
    }
  }
}
