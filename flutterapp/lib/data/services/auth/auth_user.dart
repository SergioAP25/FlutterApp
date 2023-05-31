import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String? email;
  final String? provider;

  const AuthUser({required this.email, required this.provider});

  factory AuthUser.fromFirebase(User user, String provider) =>
      AuthUser(email: user.email, provider: provider);
}
