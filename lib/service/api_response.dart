class ApiResponse<T> {
  String? message;
  T? data;
  Status? status;

  ApiResponse.initial(this.message) : status = Status.INITIAL;
  ApiResponse.haveShops(this.data) : status = Status.HAVE;
  ApiResponse.error(this.message) : status = Status.ERROR;
  ApiResponse.haveNotShops(this.message) : status = Status.HAVENOT;
}

enum Status { INITIAL, HAVE, HAVENOT, ERROR }
