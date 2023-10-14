import 'package:cleanarchtdd/core/errors/exceptions.dart';
import 'package:cleanarchtdd/core/errors/failure.dart';
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

    try {
      await _remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
