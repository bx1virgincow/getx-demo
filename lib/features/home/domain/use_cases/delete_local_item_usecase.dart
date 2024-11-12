import 'package:demo/core/data/results.dart';
import 'package:demo/core/data/usecase.dart';
import 'package:demo/features/home/domain/repository/todo_repo.dart';

class DeleteLocalItemUsecase extends UseCase<Results, NoParams> {
  final TodoRepo _todoRepo;
  DeleteLocalItemUsecase(this._todoRepo);
  @override
  Future<Results> call(NoParams params) {
    return _todoRepo.deleteLocalItems();
  }
}
