import 'package:cleanarchtdd/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:cleanarchtdd/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation authRepoImpl;

  setUp(() {
    remoteDataSource = MockAuthenticationRemoteDataSource();
    authRepoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  group('createUser', () {
    test(
        'should call [RemoteDataSource.createUser] and complete successfully when the call to remote data source is successful',
        () async {
      // Arrange (Stub)

      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => Future.value(null));

      const createdAt = '_whatever_createdAt';
      const name = '_whatever_name';
      const avatar = '_whatever_avatar';

      // Act

      final result = await authRepoImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      // Assert

      expect(result, const Right(null));
      verify(() => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          )).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
