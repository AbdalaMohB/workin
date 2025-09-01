import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workin/core/services/size_service.dart';
import 'package:workin/modules/login/components/login_fields.dart';
import 'package:workin/modules/login/providers/login_provider.dart';
import 'package:workin/shared/components/custom_app_bar.dart';
import 'package:workin/shared/resources/app_colors.dart';
import 'package:workin/shared/resources/app_sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Widget _appTitle() {
    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: 19),
      child: Text(
        "Workin",
        style: GoogleFonts.bungee(
          color: AppColors.primaryFg,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.textHeader,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _slogan() {
    return Text(
      "A Workspace You Can Trust!",
      style: GoogleFonts.bungee(
        color: AppColors.primaryFg,
        fontSize: 17,
        fontStyle: FontStyle.italic,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _successbody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            [
              Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 40)),
              SizedBox(
                height: SizeService.getWidthPercentage(
                  context,
                  percentage: 0.5,
                ),
                width: SizeService.getWidthPercentage(context, percentage: 0.5),
                child: Image.asset(
                  "assets/images/job2.webp",
                  fit: BoxFit.contain,
                ),
              ),
              _appTitle(),
              _slogan(),
            ] +
            getLoginForm(
              onLogin: () {},
              onRegister: () {
                showGeneralDialog(
                  context: context,
                  transitionBuilder: (c, a1, a2, widget) {
                    const begin = Offset(0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.easeOutCubic;
                    final tween = Tween(begin: begin, end: end);
                    final curvedAnimation = CurvedAnimation(
                      parent: a1,
                      curve: curve,
                    );
                    return SlideTransition(
                      position: tween.animate(curvedAnimation),
                      child: Opacity(
                        opacity: a1.value,
                        child: getRegistrationDialog(
                          onTrueRegister: () {},
                          context: c,
                        ),
                      ),
                    );
                  },
                  barrierDismissible: true,
                  barrierLabel: "",
                  transitionDuration: Duration(milliseconds: 900),
                  pageBuilder: (c, a1, a2) {
                    return Center();
                  },
                );
              },
            ),
      ),
    );
  }

  Widget _body() {
    return Consumer<LoginProvider>(
      builder: (context, value, _) {
        if (true) {
          return _successbody(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<LoginProvider>().init();
    return Scaffold(
      body: _body(),
      backgroundColor: AppColors.primaryBg,
      appBar: getCustomAppBar(color: AppColors.primaryBg),
    );
  }
}
