import 'package:demo/core/data/results.dart';

import '../entities/todo_entity.dart';

abstract class TodoRepo {
  //remote
  Future<Results<List<TodoEntity>>> getTodos();
  Future<Results<List<TodoEntity>>> refreshEntity();
  //local
  Future<Results<void>> createItem(Map<String, dynamic> data);
  Future<Results<void>> deleteLocalItems();
}
