// what does the class depend on?
// ANSWER : It depends on Authentication Repository
// how can we create the fake version of this dependency?
// ANSER : with using Mocktail package
// how do we control what our dependencies do?
// ANSWER : using the mocktail's API

import 'package:cleanarchtdd/core/errors/failure.dart';
import 'package:cleanarchtdd/core/utils/typedef.dart';
import 'package:cleanarchtdd/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:cleanarchtdd/src/authentication/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late CreateUser usecase;
  late AuthenticationRepository _repository;

  setUp(() {
    _repository = MockAuthenticationRepository();
    usecase = CreateUser(_repository);
  });

  test(
    'Should call [AuthenticationRepository.createUser]',
    () async {
      // Arrange or Stub
      when(
        () => _repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));

      //Act

      //Assert
    },
  );
}
