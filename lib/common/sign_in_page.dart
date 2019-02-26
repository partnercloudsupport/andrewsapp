import 'package:flutter/material.dart';

import '../model/current_user_model.dart';
import '../model/user.dart';
import '../dashboard/dashboard_page.dart';
import 'package:taskist/model/current_user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'signin_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sigin In'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: ScopedModelDescendant<CurrentUserModel>(
            builder: (
              BuildContext context,
              Widget child,
              CurrentUserModel model,
            ) {
              if (model.status == UserStatus.Unauthenticated) {
                return SiginForm();
              }
              if (model.status == UserStatus.Unregistered) {
                return SiginForm();
              } else if (model.status == UserStatus.Authenticated) {
                _navigateToDashboard(context);
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String msg) {
    final SnackBar snackBar = SnackBar(content: Text(msg));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.pushNamed(context, DashboardPage.routeName);
  }
}
