import 'status.dart';

/// Generic API / UI state wrapper used by ViewModels.
class ApiResponse<T> {
  ApiResponse({
    this.status = Status.notStarted,
    this.data,
    this.message,
  });

  Status status;
  T? data;
  String? message;

  void setLoading() {
    status = Status.loading;
    message = null;
  }

  void setCompleted(T value) {
    status = Status.completed;
    data = value;
    message = null;
  }

  void setError(String msg) {
    status = Status.error;
    message = msg;
  }
}
