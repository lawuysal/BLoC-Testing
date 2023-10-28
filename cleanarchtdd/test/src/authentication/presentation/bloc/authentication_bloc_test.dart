import 'package:bloc_test/bloc_test.dart';
import 'package:cleanarchtdd/src/authentication/domain/usecases/create_user.dart';
import 'package:cleanarchtdd/src/authentication/domain/usecases/get_users.dart';
import 'package:cleanarchtdd/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateUser extends Mock implements CreateUser {}

class MockGetUser extends Mock implements GetUsers {}

void main() {
  late CreateUser createUser;
  late GetUsers getUsers;
  late AuthenticationBloc bloc;
  const testCreateUserParams = CreateUserParams.empty();

  setUp(() {
    createUser = MockCreateUser();
    getUsers = MockGetUser();
    bloc = AuthenticationBloc(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(testCreateUserParams);
  });

  tearDown(() => bloc.close());

  test('initial state should be [Authentication Initial]', () {
    expect(bloc.state, isA<AuthenticationInitial>());
  });

  group('createUser', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
        'Should emit [CreatingUserState, UserCreatedState] when successful',
        build: () {
          when(() => createUser(testCreateUserParams))
              .thenAnswer((_) async => const Right(null));
          return bloc;
        },
        act: (bloc) => bloc.add(CreateUserEvent(
            createdAt: testCreateUserParams.createdAt,
            name: testCreateUserParams.name,
            avatar: testCreateUserParams.avatar)),
        expect: () => const [CreatingUserState(), UserCreatedState()],
        verify: (bloc) {
          verify(() => createUser(testCreateUserParams)).called(1);

          verifyNoMoreInteractions(createUser);
        });
  });
}
