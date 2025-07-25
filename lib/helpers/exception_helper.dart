import 'dart:io';

String getExceptionMessage(Exception? error) {
  if (error == null) {
    return 'No error occurred';
  }

  if (error is HttpException) {
    return error.message;
  }

  return error.toString();
}
