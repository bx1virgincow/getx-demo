import 'dart:convert';

import 'package:demo/core/api/api_constant.dart';
import 'package:demo/core/data/results.dart';
import 'package:demo/features/home/domain/entities/todo_entity.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<Results> fetchRemoteData();

  Future<Results> fetchSingleData(int id);

  Future<Results> updateData(int id);
}

class RemoteDataSourceImplementation extends RemoteDataSource {
  @override
  Future<Results> fetchRemoteData() async {
    try {
      final response = await http.get(Uri.parse(ApiConstant.baseUrl));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse is List) {
          final todoModel =
              jsonResponse.map((todo) => TodoEntity.fromJson(todo)).toList();

          return Success(value: todoModel);
        } else {
          return Success(value: TodoEntity.fromJson(jsonResponse));
        }
      } else {
        return Failure(errorMessage: response.reasonPhrase!);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Results> fetchSingleData(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Results> updateData(int id) {
    throw UnimplementedError();
  }
}
