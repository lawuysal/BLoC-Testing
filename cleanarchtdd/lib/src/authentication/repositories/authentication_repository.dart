import 'dart:async';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  createUser(
      {required String createdAt,
      required String name,
      required String avatar});
}
