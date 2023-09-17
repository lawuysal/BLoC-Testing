// what does the class depend on?
// ANSWER : It depends on Authentication Repository
// how can we create the fake version of this dependency?
// ANSER : with using Mocktail package
// how do we control what our dependencies do?
// ANSWER : using the mocktail's API

import 'package:cleanarchtdd/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:cleanarchtdd/src/authentication/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'authentication_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test(
    'Should call [AuthenticationRepository.createUser]',
    () async {
      // Arrange or Stub
      when(
        () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));

      //Act
      final result = await usecase(params);
      //Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repository.createUser(
            createdAt: params.createdAt,
            name: params.name,
            avatar: params.avatar),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
