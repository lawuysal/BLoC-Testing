import 'package:cleanarchtdd/core/usecase/usecase.dart';
import 'package:cleanarchtdd/core/utils/typedef.dart';
import 'package:cleanarchtdd/src/authentication/domain/entities/user.dart';
import 'package:cleanarchtdd/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async {
    return _repository.getUsers();
  }
}
