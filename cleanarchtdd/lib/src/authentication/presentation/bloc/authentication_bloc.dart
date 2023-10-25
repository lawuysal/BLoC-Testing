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
    on<CreateUserEvent>(_createUserEvent);
    on<GetUsersEvent>(_getUsersEvent);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  FutureOr<void> _createUserEvent(
      CreateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CreatingUserState());

    final result = await _createUser(CreateUserParams(
      createdAt: event.createdAt,
      name: event.name,
      avatar: event.avatar,
    ));
  }

  FutureOr<void> _getUsersEvent(
      GetUsersEvent event, Emitter<AuthenticationState> emit) {}
}
