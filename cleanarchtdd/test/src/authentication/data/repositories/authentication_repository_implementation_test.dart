import 'package:cleanarchtdd/core/errors/exceptions.dart';
import 'package:cleanarchtdd/core/errors/failure.dart';
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

  const testException = APIException(
    message: "Unknown error",
    statusCode: 500,
  );

  group('createUser', () {
    const createdAt = '_whatever_createdAt';
    const name = '_whatever_name';
    const avatar = '_whatever_avatar';
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
      },
    );

    test("should return a [ServerFailure] value when call to the remote",
        () async {
      // stubbing
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenThrow(testException);

      // act
      final result = await authRepoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // assert
      expect(
        result,
        equals(
          Left(
            ApiFailure(
                message: testException.message,
                statusCode: testException.statusCode),
          ),
        ),
      );

      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
