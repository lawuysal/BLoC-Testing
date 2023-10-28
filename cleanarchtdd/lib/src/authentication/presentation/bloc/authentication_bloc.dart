import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cleanarchtdd/src/authentication/domain/entities/user.dart';
import 'package:cleanarchtdd/src/authentication/domain/usecases/create_user.dart';
import 'package:cleanarchtdd/src/authentication/domain/usecases/get_users.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserEventHandler);
    on<GetUsersEvent>(_getUsersEventHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  FutureOr<void> _createUserEventHandler(
      CreateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CreatingUserState());

    final result = await _createUser(CreateUserParams(
      createdAt: event.createdAt,
      name: event.name,
      avatar: event.avatar,
    ));

    result.fold(
      (failure) => emit(AuthenticationErrorState(failure.errorMessage)),
      (success) => emit(const UserCreatedState()),
    );
  }

  FutureOr<void> _getUsersEventHandler(
      GetUsersEvent event, Emitter<AuthenticationState> emit) async {
    emit(const GettingUsersState());
    final result = await _getUsers();

    result.fold(
      (failure) => emit(AuthenticationErrorState(failure.errorMessage)),
      (users) => emit(UsersLoadedState(users)),
    );
  }
}
