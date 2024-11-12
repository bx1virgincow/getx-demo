import 'dart:developer';

import 'package:demo/core/data/results.dart';
import 'package:demo/features/home/data/data_sources/remote_data_source.dart';
import 'package:demo/features/home/domain/entities/todo_entity.dart';
import 'package:demo/features/home/domain/repository/todo_repo.dart';

import '../data_sources/local_data_source.dart';

class TodoRepositoryImpl extends TodoRepo {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  TodoRepositoryImpl(this._remoteDataSource, this._localDataSource);
  @override
  Future<Results<List<TodoEntity>>> getTodos() async {
    try {
      //make query to fetch data from local database
      final localResults = await _localDataSource.getItems();
      // //check if local database has data
      if (localResults is Success<List<TodoEntity>>) {
        if (localResults.value.isNotEmpty) {
          return Success(value: localResults.value);
        }
      }
      //local data is not available
      final remoteResults = await _remoteDataSource.fetchRemoteData();
      if (remoteResults is Success) {
        //save to local database
        for (var todo in remoteResults.value) {
          await _localDataSource.insertItem(todo.toMap());
        }
        return Success(value: remoteResults.value);
      } else if (remoteResults is Failure) {
        return Failure(errorMessage: remoteResults.errorMessage);
      } else {
        return Failure(errorMessage: 'Unexpected error occurred');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Results<void>> createItem(Map<String, dynamic> data) async {
    try {
      final results = await _localDataSource.insertItem(data);
      if (results is Success) {
        return Success(value: null);
      } else {
        return Failure(errorMessage: 'Failed to add data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Results<List<TodoEntity>>> refreshEntity() async {
    try {
      final remoteResults = await _remoteDataSource.fetchRemoteData();
      log('remote result first time: $remoteResults');
      if (remoteResults is Success) {
        //delete previous data
        await _localDataSource.deleteItems();
        //update local database
        for (var result in remoteResults.value) {
          //insert new results into local database
          await _localDataSource.insertItem(result.toMap());
        }
        return Success(value: remoteResults.value);
      } else {
        return Failure(errorMessage: 'failed to update data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Results<void>> deleteLocalItems() async {
    try {
      await _localDataSource.deleteItems();
      return Success(value: null);
    } catch (e) {
      return Failure(errorMessage: e.toString());
    }
  }
}
