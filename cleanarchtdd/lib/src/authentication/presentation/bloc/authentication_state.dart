part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class CreatingUserState extends AuthenticationState {
  const CreatingUserState();
}

class GettingUsersState extends AuthenticationState {
  const GettingUsersState();
}

class UserCreatedState extends AuthenticationState {
  const UserCreatedState();
}

class UsersLoadedState extends AuthenticationState {
  const UsersLoadedState(this.users);

  final List<User> users;

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthenticationErrorState extends AuthenticationState {
  const AuthenticationErrorState(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
