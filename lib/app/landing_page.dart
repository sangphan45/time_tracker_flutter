import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/home_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage({required this.auth});
  final AuthBase auth;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
    widget.auth.onAuthStateChanges.listen((user) {
      print('user: ${user?.uid}');
    });
  }

  Future<void> _checkCurrentUser() async {
    UserModel? user = await widget.auth.currentUser();
    _updateUser(user);
  }

  void _updateUser(UserModel? user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        auth: widget.auth,
        onSignIn: _updateUser,
      );
    }
    return HomePage(
      auth: widget.auth,
      onSignOut: () => _updateUser(null),
    );
  }
}
