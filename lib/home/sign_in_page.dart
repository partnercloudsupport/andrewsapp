import 'package:flutter/material.dart';

import '../model/current_user_model.dart';
import '../model/user.dart';
import '../home/home_page.dart';
import 'package:taskist/model/current_user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../common/signin_form.dart';

// class SignInFab extends StatelessWidget {
//   const SignInFab();

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton.extended(
//       // onPressed: () => _handleSignIn(context),
//       icon: Image.asset('assets/google_g_logo.png', height: 24.0),
//       label: const Text('Sign in with Google'),
//     );
//   }

//   Future<void> _handleSignIn(BuildContext context, Map _formData) async {
//     final CurrentUserModel currentUserModel = CurrentUserModel.of(context);
//     await currentUserModel.signIn(_formData);
//     if (currentUserModel.status == Status.Unregistered) {
//       _navigateToRegistration(context);
//     } else if (currentUserModel.status == Status.Authenticated) {
//       final User user = currentUserModel.user;
//       _showSnackBar(context, 'Welcome ${user.fullName}');
//     }
//   }

//   void _showSnackBar(BuildContext context, String msg) {
//     final SnackBar snackBar = SnackBar(content: Text(msg));
//     Scaffold.of(context).showSnackBar(snackBar);
//   }

//   void _navigateToRegistration(BuildContext context) {
//     Navigator.pushNamed(context, RegisterPage.routeName);
//   }
// }
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
              if (model.status == Status.Unauthenticated) {
                return SiginForm();
              }
              if (model.status == Status.Unregistered) {
                return SiginForm();
              } else if (model.status == Status.Authenticated) {
                return const Center(
                  child: Text('Welcome'),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
  // return FloatingActionButton.extended(
  //   onPressed: () => _handleSignIn(context),
  //   icon: Image.asset('assets/google_g_logo.png', height: 24.0),
  //   label: const Text('Sign in with Google'),
  // );

  // Future<void> _handleSignIn(BuildContext context, formData) async {
  //   final CurrentUserModel currentUserModel = CurrentUserModel.of(context);
  //   await currentUserModel.signIn(formData);
  //   if (currentUserModel.status == Status.Unregistered) {
  //     _navigateToRegistration(context);
  //   } else if (currentUserModel.status == Status.Authenticated) {
  //     final User user = currentUserModel.user;
  //     _showSnackBar(context, 'Welcome ${user.fullName}');
  //   }
  // }

  void _showSnackBar(BuildContext context, String msg) {
    final SnackBar snackBar = SnackBar(content: Text(msg));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushNamed(context, DashboardPage.routeName);
  }
}
