import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/managers/navigator_manager.dart';
import 'package:scmp_mobile_assg/repositories/login_repository.dart';
import 'package:scmp_mobile_assg/repositories/staffs_repository.dart';
import 'package:scmp_mobile_assg/services/api_service.dart';
import 'package:scmp_mobile_assg/services/secure_storage_service.dart';
import 'package:scmp_mobile_assg/widgets/components/loading_indicator.dart';
import 'package:scmp_mobile_assg/widgets/home/components/staff_list.dart';
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
  final _scrollController = ScrollController();

  @override
  void initState() {
    _viewModel.addListener(() {
      setState(() {});
    });
    _viewModel.firstLoad();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        if (_viewModel.isLoading || _viewModel.isRefreshing) return;
        _viewModel.loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _scrollController.dispose();
    super.dispose();
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
      appBar: AppBar(
        title: Text(_viewModel.token),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _viewModel.deleteToken();
              if (!context.mounted) return;
              _navigatorManager.navigateToLogin(context);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _viewModel.refresh,
        child: StaffList(
          staffList: _viewModel.staffList,
          scrollController: _scrollController,
          hideLoadMoreIndicator: _viewModel.hideLoadMoreIndicator,
        ),
      ),
    );
  }
}
