import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../business logic/bloc/login/login_bloc.dart';
import '../route/route_list.dart';
import '../src/style/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>()..add(LoginSessionCheckEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                width: 100,
                height: 100,
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (BuildContext context, LoginState state) {
                    if (state.status == LoginStatus.success) {
                      delayAndGoNextPage(RouteList.homePage);
                    }
                    if (state.status == LoginStatus.fail) {
                      delayAndGoNextPage(RouteList.loginPage);
                    }
                  },
                  builder: (BuildContext context, LoginState state) {
                    print('Status:::::::::${state.status.name}');
                    if (state.status == LoginStatus.success) {
                      return const Icon(FontAwesomeIcons.circleCheck,
                          color: Colors.green);
                    }
                    if (state.status == LoginStatus.fail) {
                      return const Icon(FontAwesomeIcons.circleXmark,
                          size: 50, color: Colors.red);
                    }
                    // return const Icon(FontAwesomeIcons.circleXmark,
                    //     size: 50, color: Colors.red);

                    return  SpinKitChasingDots(
                      size: 50,
                      color: AppColors.primaryColorPale,
                    );
                  },
                )),
          ),
          Positioned.fill(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TyperAnimatedText(
                        'MMT',
                        textStyle: const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 500),
                      ),
                    ],
                  ),
                  const Text("developed by mmt").padding(padding: 10.verticalPadding)
                ]),
          ),
        ],
      ),
    );
  }

  void delayAndGoNextPage(String route) {
    Future.delayed(const Duration(seconds: 2))
        .then((value) => context.pushReplace(route: route));
  }
}
