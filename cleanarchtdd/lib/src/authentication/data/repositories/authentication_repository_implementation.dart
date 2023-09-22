import 'package:cleanarchtdd/core/utils/typedef.dart';
import 'package:cleanarchtdd/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:cleanarchtdd/src/authentication/domain/entities/user.dart';
import 'package:cleanarchtdd/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    /// Test driven development ///
    /// call the remote data source
    /// if it doesn't throw exception, make sure it returns proper data
    /// if it throws exceptition, we return a failure

    await _remoteDataSource.createUser(
      createdAt: createdAt,
      name: name,
      avatar: avatar,
    );

    return const Right(null);
  }

  @override
  ResultFuture<List<User>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
