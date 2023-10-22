import 'dart:convert';

import 'package:cleanarchtdd/core/errors/exceptions.dart';
import 'package:cleanarchtdd/core/utils/constants.dart';
import 'package:cleanarchtdd/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:cleanarchtdd/src/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSourceImplementation(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('Should complete successfully when the status code is 200 or 201',
        () async {
      // Stubbing

      when(() => client.post(
            any(),
            body: any(named: 'body'),
          )).thenAnswer(
        (_) async => http.Response('User Created Successfully', 201),
      );

      // Act

      final methodCall = remoteDataSource.createUser;

      // Assert
      expect(
          methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          completes);

      verify(
        () => client.post(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode(
            {
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            },
          ),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
    test('Should throw [APIException] when the status code is not 200 or 201',
        () async {
      // stubbing
      when(() => client.post(
            any(),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response(
            'Invalid email address',
            400,
          ));

      // act
      final methodCall = remoteDataSource.createUser;

      // assert
      expect(
        () async => methodCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
        throwsA(
          const APIException(
            message: 'Invalid email address',
            statusCode: 400,
          ),
        ),
      );

      verify(
        () => client.post(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode(
            {
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            },
          ),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  }); //

  group('getUsers', () {
    const testList = [UserModel.empty()];
    test('Should return a [List<UserModel>] when the status code is 200',
        () async {
      // stubbing
      when(
        () => client.get(
          any(),
        ),
      ).thenAnswer((_) async =>
          http.Response(jsonEncode([testList.first.toMap()]), 200));

      // act
      final result = await remoteDataSource.getUsers();

      // assert
      expect(result, equals(testList));

      verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)))
          .called(1);
      verifyNoMoreInteractions(client);
    });
    test('Should throw an [APIException] when the status code is not 200',
        () async {
      // stubbing
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(
          'Server is down',
          505,
        ),
      );

      // act
      final methodCall = remoteDataSource.getUsers;

      // assert
      expect(
        () => methodCall(),
        throwsA(
          const APIException(
            message: 'Server is down',
            statusCode: 505,
          ),
        ),
      );

      verify(
        () => client.get(
          Uri.https(kBaseUrl, kGetUsersEndpoint),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
