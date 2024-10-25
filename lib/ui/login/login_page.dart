import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/style/app_color.dart';

import '../../business logic/bloc/login/login_bloc.dart';
import '../../common_widget/animated_button.dart';
import '../../common_widget/text_widget.dart';
import '../../common_widget/textfield_widget.dart';
import '../../route/route_list.dart';
import '../../src/const_string.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isFocus = false;
  bool? condition;
  late LoginBloc _loginBloc;

  bool _invalidName = false;
  bool _invalidPassword = false;

  final FocusNode _usernameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _loginBloc = context.read<LoginBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        GestureDetector(
          onDoubleTap: () {
            context.pushTo(route: RouteList.adminLoginPage);
          },
          child: Container(
            color: Colors.white,
            height: 15,
            width: double.infinity,
            child: const Align(
              alignment: Alignment.center,
              child: Text(ConstString.version),
            ),
          ),
        )
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _logoWidget(),
            const SizedBox(height: 20),
            _usernameField(),
            const SizedBox(height: 20),
            _passwordField(),
            const SizedBox(height: 20),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    ButtonStatus status = ButtonStatus.start;
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          context.pushReplace(route: RouteList.dashboardPage);
        }
      },
      builder: (context, state) {
        if (state.status == LoginStatus.loading) {
          status = ButtonStatus.loading;
        } else if (state.status == LoginStatus.fail) {
          status = ButtonStatus.fail;
        } else if (state.status == LoginStatus.initial) {
          status = ButtonStatus.start;
        }
        return GestureDetector(
          onTap: () {
            _invalidName = !_isInputValid(_usernameController.text);
            _invalidPassword = !_isInputValid(_passwordController.text);
            print("Username valid status : ${!_invalidName}");
            print("Password valid status : ${!_invalidPassword}");
            if (!_invalidPassword && !_invalidName) {
              _loginBloc.add(EmployeeLoginEvent(
                  username: _usernameController.text,
                  password: _passwordController.text));
            } else {
              setState(() {});
            }
          },
          child: AnimatedButton(
            buttonText: 'Login',
            status: status,
            buttonColor: AppColors.primaryColor,
          ),
        );
      },
    );
  }

  bool _isInputValid(String text) {
    if (text == '') {
      return false;
    }
    return true;
  }

  Widget _usernameField() {
    return TextFieldWidget(
      controller: _usernameController,
      validator: (username) {
        if (username == null || username == '') {
          return 'required';
        }
        return null;
      },
      hintText: "username",
      prefixIcon: const Icon(Icons.person),
      backgroundColor: Colors.white,
      accentColor: AppColors.primaryColor,
      borderRadius: 10,
      showWarning: _invalidName,
      isShadow: false,
      height: 50,
      focusNode: _usernameNode,
    );
  }

  Widget _passwordField() {
    return TextFieldWidget(
      validator: (password) {
        if (password == null || password == '') {
          return 'required';
        }
        return null;
      },
      controller: _passwordController,
      focusNode: _passwordNode,
      hintText: "password",
      prefixIcon: const Icon(Icons.key),
      backgroundColor: Colors.white,
      accentColor:AppColors.primaryColor,
      borderRadius: 10,
      isShadow: false,
      isPassword: true,
      showWarning: _invalidPassword,
      suffixIcon: const Icon(Icons.remove_red_eye),
      height: 50,
    );
  }

  Widget _logoWidget() {
    return GestureDetector(
      onTap: () async {
        // context.pushTo(route: RouteList.scannerPage);
      },
      child: const TextWidget(
        ConstString.appName,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:logistic/src/extension/navigator_extension.dart';
//
// import '../business_logic/bloc/login/login_bloc.dart';
// import '../common_widget/animated_button.dart';
// import '../common_widget/textfield_widget.dart';
// import '../route/route_list.dart';
// import '../src/const_string.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   bool isFocus = false;
//   bool? condition;
//   late LoginBloc _loginBloc;
//
//   bool _invalidName = false;
//   bool _invalidPassword = false;
//
//   final FocusNode _usernameNode = FocusNode();
//   final FocusNode _passwordNode = FocusNode();
//
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _loginBloc = context.read<LoginBloc>();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       persistentFooterButtons: [
//         GestureDetector(
//           onDoubleTap: () {
//             context.pushTo(route: RouteList.adminLoginPage);
//           },
//           child: Container(
//             color: Colors.white,
//             height: 15,
//             width: double.infinity,
//             child: const Align(
//               alignment: Alignment.center,
//               child: Text(ConstString.version),
//             ),
//           ),
//         )
//       ],
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _logoWidget(),
//             const SizedBox(height: 20),
//             _usernameField(),
//             const SizedBox(height: 20),
//             _passwordField(),
//             const SizedBox(height: 20),
//             _loginButton(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _loginButton() {
//     ButtonStatus status = ButtonStatus.start;
//     return BlocConsumer<LoginBloc, LoginState>(
//       listener: (context, state) {
//         if (state.status == LoginStatus.success) {
//           context.pushReplace(route: RouteList.dashboardPage);
//         }
//       },
//       builder: (context, state) {
//         if (state.status == LoginStatus.loading) {
//           status = ButtonStatus.loading;
//         } else if (state.status == LoginStatus.fail) {
//           status = ButtonStatus.fail;
//         } else if (state.status == LoginStatus.initial) {
//           status = ButtonStatus.start;
//         }
//         return GestureDetector(
//           onTap: () {
//             // _invalidName = !_isInputValid(_usernameController.text);
//             // _invalidPassword = !_isInputValid(_passwordController.text);
//             // print("Username valid status : ${!_invalidName}");
//             // print("Password valid status : ${!_invalidPassword}");
//             // if (!_invalidPassword && !_invalidName) {
//             //   _loginBloc.add(EmployeeLoginEvent(
//             //       username: _usernameController.text,
//             //       password: _passwordController.text));
//             // } else {
//             //   setState(() {});
//             // }
//             context.pushReplace(route: RouteList.dashboardPage);
//           },
//           child: AnimatedButton(
//             buttonText: 'Login',
//             status: status,
//             buttonColor: Colors.orangeAccent,
//           ),
//         );
//       },
//     );
//   }
//
//   bool _isInputValid(String text) {
//     if (text == '') {
//       return false;
//     }
//     return true;
//   }
//
//   Widget _usernameField() {
//     return TextFieldWidget(
//       controller: _usernameController,
//       validator: (username) {
//         if (username == null || username == '') {
//           return 'required';
//         }
//       },
//       hintText: "username",
//       prefixIcon: const Icon(Icons.person),
//       backgroundColor: Colors.white,
//       accentColor: Colors.orangeAccent,
//       borderRadius: 10,
//       showWarning: _invalidName,
//       isShadow: false,
//       height: 50,
//       focusNode: _usernameNode,
//     );
//   }
//
//   Widget _passwordField() {
//     return TextFieldWidget(
//       validator: (password) {
//         if (password == null || password == '') {
//           return 'required';
//         }
//       },
//       controller: _passwordController,
//       focusNode: _passwordNode,
//       hintText: "password",
//       prefixIcon: const Icon(Icons.key),
//       backgroundColor: Colors.white,
//       accentColor: Colors.orangeAccent,
//       borderRadius: 10,
//       isShadow: false,
//       isPassword: true,
//       showWarning: _invalidPassword,
//       suffixIcon: const Icon(Icons.key),
//       height: 50,
//     );
//   }
//
//   Widget _logoWidget() {
//     return const Text(
//       "HTZ",
//       style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//     );
//   }
// }
