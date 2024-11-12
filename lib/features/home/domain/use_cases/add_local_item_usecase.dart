import 'package:demo/core/data/results.dart';
import 'package:demo/features/home/domain/repository/todo_repo.dart';

import '../../../../core/data/usecase.dart';

class AddLocalItemUsecase extends UseCase<Results, Map<String, dynamic>> {
  final TodoRepo _todoRepo;
  AddLocalItemUsecase(this._todoRepo);
  @override
  Future<Results> call(Map<String, dynamic> params) {
    return _todoRepo.createItem(params);
  }
}
