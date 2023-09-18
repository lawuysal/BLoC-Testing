import 'dart:convert';

import 'package:cleanarchtdd/core/utils/typedef.dart';
import 'package:cleanarchtdd/src/authentication/data/models/user_model.dart';
import 'package:cleanarchtdd/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testModel = UserModel.empty();
  final testJson = fixture('user.json');
  final testMap = jsonDecode(testJson) as DataMap;

  test('should be a subclass of entity [User]', () {
    // Arrange (Stub)
    // Assert
    expect(testModel, equals(isA<User>()));
  });

  group('fromMap and toMap', () {
    test('fromMap, should return a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromMap(testMap);
      // Assert
      expect(result, equals(testModel));
    });

    test('toMap, should return a [Map] with the right data', () {
      // Act
      final result = testModel.toMap();
      // Assert
      expect(result, equals(testMap));
    });
  });

  group('fromJson and toJson', () {
    test('fromJson, should return [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromJson(testJson);
      // Assert
      expect(result, equals(testModel));
    });

    test('toJson, should return [JSON] with the right data ', () {
      // Act
      final result = testModel.toJson();
      // Assert
      expect(result, equals(testJson));
    });
  });

  test('should return correct "given" values', () {
    // Act
    final result1 = testModel.copyWith(name: "Laura");
    final result2 = testModel.copyWith(avatar: "LoL");
    // Assert
    expect(result1.name, equals("Laura"));
    expect(result2.avatar, equals("LoL"));
  });
}
