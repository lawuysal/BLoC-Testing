import 'package:cleanarchtdd/src/authentication/domain/entities/user.dart';
import 'package:cleanarchtdd/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:cleanarchtdd/src/authentication/domain/usecases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late GetUsers usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = GetUsers(repository);
  });

  const testResponse = [User.empty()];

  test(
      'It should call [AuthenticationRepository.getUsers] and return [List<User>]',
      () async {
    // Arrange
    when(() => repository.getUsers())
        .thenAnswer((_) async => const Right(testResponse));
    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(const Right<dynamic, List<User>>(testResponse)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
