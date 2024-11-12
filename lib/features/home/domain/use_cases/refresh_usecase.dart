import 'package:demo/core/data/results.dart';
import 'package:demo/core/data/usecase.dart';
import 'package:demo/features/home/domain/entities/todo_entity.dart';
import 'package:demo/features/home/domain/repository/todo_repo.dart';

class RefreshUsecase extends UseCase<Results<List<TodoEntity>>, NoParams> {
  final TodoRepo _todoRepo;
  RefreshUsecase(this._todoRepo);

  @override
  Future<Results<List<TodoEntity>>> call(NoParams params) {
    return _todoRepo.refreshEntity();
  }
}
