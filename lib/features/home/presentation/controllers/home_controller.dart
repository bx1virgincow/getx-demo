import 'package:demo/core/data/results.dart';
import 'package:demo/core/data/usecase.dart';
import 'package:demo/features/home/domain/entities/todo_entity.dart';
import 'package:demo/features/home/domain/use_cases/add_local_item_usecase.dart';
import 'package:demo/features/home/domain/use_cases/get_todo_use_case.dart';
import 'package:get/get.dart';

import '../../domain/use_cases/delete_local_item_usecase.dart';
import '../../domain/use_cases/refresh_usecase.dart';

class HomeController extends GetxController {
  // Declaration of use-cases
  final GetTodoUseCase _getTodoUseCase;
  final AddLocalItemUsecase _addLocalItemUseCase;
  final RefreshUsecase _refreshUsecase;
  final DeleteLocalItemUsecase _deleteLocalItemUsecase;
  HomeController(
    this._getTodoUseCase,
    this._addLocalItemUseCase,
    this._refreshUsecase,
    this._deleteLocalItemUsecase,
  );

  // Variables
  final RxList<TodoEntity> _todoList = <TodoEntity>[].obs;
  RxList<TodoEntity> get todoList => _todoList;

  final RxInt _currentIndex = 0.obs;
  RxInt get currentIndex => _currentIndex;

  // Flag to indicate if new feeds are available
  final RxBool _newFeedsAvailable = false.obs;
  RxBool get newFeedsAvailable => _newFeedsAvailable;

  //check value
  final isChecked = <int, bool>{}.obs;

  final allItemsChecked = false.obs;

  //loading bool
  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  // Instance of the get controller
  static HomeController get instance => Get.find();

  // Instance of future
  late Future future;

  @override
  void onInit() {
    super.onInit();
    future = getTodoEntities();
  }

  // Change pages on bottom navigation
  void onTap(int index) {
    _currentIndex.value = index;
  }

  setLoading(bool value) {
    _isLoading.value = value;
  }

  // Fetch entities
  Future<Results<List<TodoEntity>>> getTodoEntities() async {
    //If list is not empty
    if (_todoList.isNotEmpty) {
      return Success(value: _todoList);
    }
    // Else make a new API call to fetch data
    final result = await _getTodoUseCase(NoParams());
    //if result is success and todolist is empty
    if (result is Success<List<TodoEntity>>) {
      _todoList.addAll(result.value);
      // no new feed since the list is newly populated
      _newFeedsAvailable.value = false;
      return Success(value: _todoList);
    } else if (result is Failure<List<TodoEntity>>) {
      return Failure(errorMessage: result.errorMessage);
    } else {
      return Failure(
        errorMessage: 'Oops! Unexpected error occurred, please try again.',
      );
    }
  }

  Future<Results<void>> addItem(Map<String, dynamic> data) async {
    try {
      await _addLocalItemUseCase(data);
      return Success(value: null);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //mark entities
  void markEntities(bool? value) {
    for (var todo in _todoList) {
      isChecked[todo.id ?? todo.hashCode] = value as bool;
    }
  }

  //check item
  bool isItemChecked(int index) {
    return isChecked[index] ?? false;
  }

  //mark entities
  void markEntity(int index, bool? value) {
    isChecked[index] = value ?? false;
  }

  // Refresh entities
  Future<Results> refreshEntities() async {
    final result = await _refreshUsecase(NoParams());
    if (result is Success<List<TodoEntity>>) {
      // Check if there are new feeds
      if (result.value.isNotEmpty && result.value.first != _todoList.first) {
        //update local database
        _newFeedsAvailable.value = true; // New feeds are available
      }
      _todoList.addAll(result.value);
      return Success(value: _todoList);
    } else {
      return Failure(errorMessage: 'errorMessage');
    }
  }

  // Clear new feeds flag
  void clearNewFeedsFlag() {
    _newFeedsAvailable.value = false;
  }

  Future<Results<void>> deleteItemsController() async {
    try {
      await _deleteLocalItemUsecase(NoParams());
      return Success(value: null);
    } catch (e) {
      return Failure(errorMessage: e.toString());
    }
  }
}
