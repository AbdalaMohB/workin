import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workin/core/services/firebase_auth_service.dart';
import 'package:workin/modules/home/components/custom_navbar.dart';
import 'package:workin/modules/home/providers/home_provider.dart';
import 'package:workin/modules/home/screens/home_screen_job_posts.dart';
import 'package:workin/shared/components/unifinished_message.dart';
import 'package:workin/shared/resources/app_colors.dart';

class HomeScreenBase extends StatelessWidget {
  const HomeScreenBase({super.key});

  Widget _body(HomeProvider provider) {
    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (provider.currentTab == 0) {
      return HomeScreenJobPosts();
    }
    return unfinishedMessage("Everything");
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomeProvider>().init();
    return Consumer<HomeProvider>(
      builder: (_, provider, _) {
        return Scaffold(
          backgroundColor: AppColors.primaryBg,
          bottomNavigationBar: CustomNavbar(
            onTabChange: provider.onTabChange,
            isOwner: FirebaseAuthService.currentUser?.isOwner ?? false,
          ),
          appBar: getCustomAppBar(),
          body: _body(provider),
        );
      },
    );
  }
}
