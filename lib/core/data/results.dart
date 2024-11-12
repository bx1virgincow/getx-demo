abstract class Results<T> {}

class Loading<T> extends Results {}

class Success<T> extends Results<T> {
  final T value;
  Success({required this.value});
}

class Failure<T> extends Results<T> {
  final String errorMessage;
  Failure({required this.errorMessage});
}
