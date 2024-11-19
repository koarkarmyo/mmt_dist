import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../../business logic/bloc/fetch_database/fetch_database_cubit.dart';
import '../../business logic/bloc/login/login_bloc.dart';
import '../../common_widget/animated_button.dart';
import '../../common_widget/text_widget.dart';
import '../../common_widget/textfield_widget.dart';
import '../../share_preference/sh_keys.dart';
import '../../share_preference/sh_utils.dart';
import '../../src/const_string.dart';
import '../../src/mmt_application.dart';
import '../../src/style/app_color.dart';


class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPage();
}

class _AdminLoginPage extends State<AdminLoginPage> {
  bool isFocus = false;
  bool? condition;
  String? _serverUrl;
  late LoginBloc _loginBloc;

  bool _invalidName = false;
  bool _invalidPassword = false;

  final FocusNode _usernameNode = FocusNode();
  final FocusNode _urlNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  final TextEditingController _usernameController = TextEditingController(text: "developer.mmtcompany@gmail.com");
  final TextEditingController _passwordController = TextEditingController(text: "password.ppt123");
  final TextEditingController _serverUrlController = TextEditingController(text: "161.97.187.243:8090");

  ValueNotifier<String> selectedDatabase =
      ValueNotifier(MMTApplication.loginDatabase);

  late FetchDatabaseCubit _fetchDatabaseCubit;

  @override
  void initState() {
    if (MMTApplication.serverUrl != '') {
      _serverUrl = MMTApplication.serverUrl;
      if (MMTApplication.serverUrl.startsWith('http://')) {
        _serverUrl = MMTApplication.serverUrl.split('http://')[1];
      }
      _serverUrlController.text = _serverUrl!;
    }
    _loginBloc = context.read<LoginBloc>();
    _fetchDatabaseCubit = context.read<FetchDatabaseCubit>()..fetchDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // _logoWidget(),
            _serverUrlWidget(),
            const SizedBox(height: 16),
            _databaseSelectorField(),
            const SizedBox(height: 16),
            _usernameField(),
            const SizedBox(height: 16),
            _passwordField(),
            const SizedBox(height: 16),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _databaseSelectorField() {
    bool fetchSuccess = false;

    return BlocConsumer<FetchDatabaseCubit, FetchDatabaseState>(
      listener: (context, state) {
        if (state is FetchDatabaseSuccess) {
          fetchSuccess = true;
          selectedDatabase.value = state.databaseList.firstOrNull ?? '';
        } else {
          fetchSuccess = false;
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            if (_serverUrl == null) {
              SnackBar snackBar = SnackBar(
                duration: 1000.milliseconds,
                content: const TextWidget(ConstString.urlRequired),
                backgroundColor: AppColors.dangerColor,
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              return;
            }
            _fetchDatabaseCubit.fetchDatabase();
            SharePrefUtils()
                .saveString(ShKeys.serverUrlKey, MMTApplication.serverUrl);
            if (fetchSuccess) {
              await _showDatabaseChoiceList();
            }
          },
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: 10.borderRadius),
            child: Row(
              children: [
                (state is FetchDatabaseFetching)
                    ? SpinKitFadingCircle(
                        color: AppColors.majorColorPale,
                        size: 30,
                      ).padding(padding: (8, 16).padding)
                    : const Icon(FontAwesomeIcons.database)
                        .padding(padding: (12, 16).padding),
                ValueListenableBuilder(
                  valueListenable: selectedDatabase,
                  builder: (context, value, child) => Text(
                    value,
                    style: TextStyle(
                        color: fetchSuccess ? Colors.black : Colors.grey),
                  ).boldSize(16).padding(padding: (12, 4).padding),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _loginButton() {
    ButtonStatus status = ButtonStatus.start;
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state.status == LoginStatus.success) {
          await Future.delayed(1.second).then((value) => context.pop());
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
              _loginBloc.add(UserLoginEvent(
                  username: _usernameController.text,
                  password: _passwordController.text,
                  database: selectedDatabase.value));
            } else {
              setState(() {});
            }
            // context.pushReplace(route: RouteList.homePageRoute);
          },
          child: AnimatedButton(
            buttonText: 'Login',
            status: status,
            buttonColor:  AppColors.primaryColor,
          ),
        );
      },
    );
  }

  Future<void> _showDatabaseChoiceList() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const TextWidget("Select database")
                .bold()
                .padding(padding: 8.verticalPadding),
            const Divider(
              color: Colors.grey,
            ),
            ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                              dense: true,
                              onTap: () {
                                selectedDatabase.value =
                                    MMTApplication.databaseList[index];
                                // selectedDatabase.notifyListeners();
                                context.pop();
                              },
                              title: Text(MMTApplication.databaseList[index])
                                  .bold())
                          .padding(padding: 16.horizontalPadding);
                    },
                    separatorBuilder: (context, index) => const Divider(
                          color: Colors.grey,
                        ),
                    itemCount: MMTApplication.databaseList.length)
                .expanded()
          ],
        );
      },
    );
  }

  bool _isInputValid(String text) {
    return text.isNotEmpty;
    // if (text == '' || text == null) {
    //   return false;
    // }
    // return true;
  }

  Widget _serverUrlWidget() {
    return TextFieldWidget(
      onChange: (value) {
        if (value.startsWith('http://') || value.startsWith('https://')) {
          MMTApplication.serverUrl = value;
          _serverUrl = value;
        } else {
          MMTApplication.serverUrl = 'http://$value';
          _serverUrl = 'http://$value';
        }
      },
      controller: _serverUrlController,
      validator: (url) {
        if (url == null || url == '') {
          return 'required';
        }
        return null;
      },
      inputAction: TextInputAction.next,
      hintText: "192.168.1.99",
      prefixIcon: const Icon(Icons.link),
      backgroundColor: Colors.white,
      accentColor: AppColors.primaryColor,
      borderRadius: 10,
      showWarning: _invalidName,
      isShadow: false,
      height: 50,
      focusNode: _urlNode,
    );
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
      inputAction: TextInputAction.next,
      hintText: "username",
      prefixIcon: const Icon(Icons.person),
      backgroundColor: Colors.white,
      accentColor:  AppColors.primaryColor,
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
      },
      controller: _passwordController,
      focusNode: _passwordNode,
      hintText: "password",
      prefixIcon: const Icon(Icons.key),
      backgroundColor: Colors.white,
      accentColor: AppColors.primaryColor,
      borderRadius: 10,
      isShadow: false,
      isPassword: true,
      showWarning: _invalidPassword,
      suffixIcon: const Icon(Icons.key),
      height: 50,
    );
  }

}
