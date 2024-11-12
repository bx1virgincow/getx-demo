import 'dart:developer';

import 'package:demo/features/home/domain/entities/todo_entity.dart';
import 'package:demo/local_db/sql_local_database.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/data/results.dart';

abstract class LocalDataSource {
  Future<Results<void>> insertItem(Map<String, dynamic> data);
  Future<Results<List<TodoEntity>>> getItems();
  Future<Results<TodoEntity?>> getItem(int id);
  Future<Results<void>> updateItem(Map<String, dynamic> data);
  Future<Results<void>> deleteItem(int id);
  Future<Results<void>> deleteItems();
}

class LocalDataSourceImplementation extends LocalDataSource {
  final SqlLocalDatabase _sqlLocalDatabase;
  LocalDataSourceImplementation(this._sqlLocalDatabase);

  @override
  Future<Results> deleteItem(int id) async {
    try {
      final db = await _sqlLocalDatabase.database;
      final result = db?.delete(
        _sqlLocalDatabase.itemTable,
        where: 'id=?',
        whereArgs: [id],
      );
      return Success(value: result);
    } catch (e) {
      return Failure(errorMessage: e.toString());
    }
  }

  @override
  Future<Results<TodoEntity?>> getItem(int id) async {
    try {
      final db = await _sqlLocalDatabase.database;
      final List<Map<String, dynamic>> result = await db!.query(
        _sqlLocalDatabase.itemTable,
        where: 'id=?',
        whereArgs: [id],
      );
      if (result.isNotEmpty) {
        return Success(value: TodoEntity.fromJson(result.first));
      } else {
        return Success(value: null);
      }
    } catch (e) {
      return Failure(errorMessage: e.toString());
    }
  }

  @override
  Future<Results<List<TodoEntity>>> getItems() async {
    try {
      final db = await _sqlLocalDatabase.database;
      final List<Map<String, dynamic>> data = await db!.query(
        _sqlLocalDatabase.itemTable,
        orderBy: 'id',
      );

      final List<TodoEntity> items =
          data.map((item) => TodoEntity.fromMap(item)).toList();

      return Success(value: items);
    } catch (e) {
      return Failure(errorMessage: e.toString());
    }
  }

  @override
  Future<Results<void>> insertItem(Map<String, dynamic> data) async {
    try {
      final db = await _sqlLocalDatabase.database;

      await db!.insert(
        _sqlLocalDatabase.itemTable,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      log('insert success: i made it here}');
      return Success(value: null);
    } catch (e) {
      log('insert exception: ${e.toString()}');
      return Failure(errorMessage: e.toString());
    }
  }

  @override
  Future<Results> updateItem(Map<String, dynamic> data) async {
    try {
      final db = await _sqlLocalDatabase.database;

      final results = db?.update(
        _sqlLocalDatabase.itemTable,
        data,
        where: 'id=?',
        whereArgs: [data['id']],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      log('update success: i made it here}');
      return Success(value: results);
    } catch (e) {
      log('update exception: ${e.toString()}');
      return Failure(errorMessage: e.toString());
    }
  }

  @override
  Future<Results<void>> deleteItems() async {
    try {
      final db = await _sqlLocalDatabase.database;
      final results = await db?.delete(_sqlLocalDatabase.itemTable);
      log('delete results: $results}');
      return Success(value: results);
    } catch (e) {
      log('delete exception: ${e.toString()}');
      return Failure(errorMessage: e.toString());
    }
  }
}
