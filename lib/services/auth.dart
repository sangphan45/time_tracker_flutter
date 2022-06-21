import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({required this.uid});
  final String uid;
}

abstract class AuthBase {
  Stream<UserModel?> get onAuthStateChanges;
  Future<UserModel?> currentUser();
  Future<UserModel?> signInAnonymously();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  UserModel? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }

    return UserModel(uid: user.uid);
  }

  @override
  Stream<UserModel?> get onAuthStateChanges {
    return _firebaseAuth
        .authStateChanges()
        .map((user) => _userFromFirebase(user));
  }

  @override
  Future<UserModel?> currentUser() async {
    final user = await _firebaseAuth.currentUser!;
    return _userFromFirebase(user);
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user!);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
