import 'auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;

  Future<void> initialize();

  Future<AuthUser> logIn({required String email, required String password});

  Future<AuthUser> logInWithGoogle();

  Future<AuthUser> createUser(
      {required String email, required String password});

  Future<void> logOut();
}
