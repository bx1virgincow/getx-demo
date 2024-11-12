import 'package:demo/features/home/data/data_sources/local_data_source.dart';
import 'package:demo/features/home/data/data_sources/remote_data_source.dart';
import 'package:demo/features/home/data/repository/todo_repository_impl.dart';
import 'package:demo/features/home/domain/repository/todo_repo.dart';
import 'package:demo/features/home/domain/use_cases/add_local_item_usecase.dart';
import 'package:demo/features/home/domain/use_cases/delete_local_item_usecase.dart';
import 'package:demo/features/home/domain/use_cases/get_todo_use_case.dart';
import 'package:demo/features/home/domain/use_cases/refresh_usecase.dart';
import 'package:demo/features/home/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../local_db/sql_local_database.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<SqlLocalDatabase>(() => SqlLocalDatabase.instance)
      ..lazyPut<LocalDataSource>(
          () => LocalDataSourceImplementation(Get.find()))
      ..lazyPut<GetTodoUseCase>(() => GetTodoUseCase(Get.find()))
      ..lazyPut<AddLocalItemUsecase>(() => AddLocalItemUsecase(Get.find()))
      ..lazyPut<RefreshUsecase>(() => RefreshUsecase(Get.find()))
      ..lazyPut<DeleteLocalItemUsecase>(
          () => DeleteLocalItemUsecase(Get.find()))
      ..lazyPut<RemoteDataSource>(() => RemoteDataSourceImplementation())
      ..lazyPut<TodoRepo>(() => TodoRepositoryImpl(Get.find(), Get.find()))
      ..lazyPut<HomeController>(() => HomeController(
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
          ));
  }
}
