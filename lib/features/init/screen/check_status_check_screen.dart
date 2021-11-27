import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/di/di.dart';
import 'package:fluttercommerce/features/init/bloc/check_status_bloc.dart';
import 'package:fluttercommerce/features/init/state/check_status_state.dart';
import 'package:fluttercommerce/routes/router.gr.dart';

class CheckStatusScreen extends StatefulWidget {
  final bool checkForAccountStatusOnly;

  const CheckStatusScreen({this.checkForAccountStatusOnly = false});

  @override
  _CheckStatusScreenState createState() => _CheckStatusScreenState();
}

class _CheckStatusScreenState extends State<CheckStatusScreen> {
  final checkStatusBloc = DI.container<CheckStatusBloc>();

  @override
  void initState() {
    super.initState();
    checkStatusBloc.checkStatus(widget.checkForAccountStatusOnly);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckStatusBloc, CheckStatusState>(
      bloc: checkStatusBloc,
      listener: (context, state) {
        if (state is NavigateToMainHomeState) {
          Navigator.of(context).pushReplacementNamed(MainHomeScreenRoute.name);
        } else if (state is NavigateToAddUserState) {
          Navigator.of(context).pushReplacementNamed(
              AddUserDetailScreenRoute.name,
              arguments: AddUserDetailScreenRouteArgs(newAddress: true));
        } else if (state is NavigateToLoginState) {
          Navigator.of(context).pushReplacementNamed(LoginScreenRoute.name);
        }
      },
      child: const Scaffold(
        body: Center(
          child: SizedBox(
            height: 70,
            width: 70,
            child: CircularProgressIndicator(
              strokeWidth: 7,
            ),
          ),
        ),
      ),
    );
  }
}