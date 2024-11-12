import 'package:demo/core/data/results.dart';
import 'package:demo/features/home/domain/entities/todo_entity.dart';
import 'package:demo/features/home/domain/repository/todo_repo.dart';

import '../../../../core/data/usecase.dart';

class GetTodoUseCase extends UseCase<Results<List<TodoEntity>>, NoParams> {
  final TodoRepo _todoRepo;

  GetTodoUseCase(this._todoRepo);

  @override
  Future<Results<List<TodoEntity>>> call(NoParams params) {
    return _todoRepo.getTodos();
  }
}
