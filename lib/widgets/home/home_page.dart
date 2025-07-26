import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/managers/navigator_manager.dart';
import 'package:scmp_mobile_assg/repositories/login_repository.dart';
import 'package:scmp_mobile_assg/repositories/staffs_repository.dart';
import 'package:scmp_mobile_assg/services/api_service.dart';
import 'package:scmp_mobile_assg/services/secure_storage_service.dart';
import 'package:scmp_mobile_assg/widgets/components/loading_indicator.dart';
import 'package:scmp_mobile_assg/widgets/components/main_button.dart';
import 'package:scmp_mobile_assg/widgets/home/home_page_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _navigatorManager = NavigatorManager();
  final _viewModel = HomePageViewModel(
    LoginRepository(ApiService(), SecureStorageService()),
    StaffsRepository(ApiService(), SecureStorageService()),
  );

  @override
  void initState() {
    _viewModel.addListener(() {
      setState(() {});
    });
    _viewModel.firstLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_viewModel.isUnauthenticated) {
      Future.microtask(() {
        if (!context.mounted) {
          return;
        }
        _navigatorManager.navigateToLogin(context);
      });
      return Scaffold(body: Center(child: LoadingIndicator()));
    }

    if (_viewModel.isLoading) {
      return Scaffold(body: Center(child: LoadingIndicator()));
    }
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
          child: MainButton(onPressed: () {
            _viewModel.deleteToken();
          }, title: _viewModel.token),
        ),
      ),
    );
  }
}
