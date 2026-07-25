import 'package:demo_proj/core/exception/app_exception.dart';

class NetworkException extends AppException {
  const NetworkException([super.message = "No internet connection."]);
}

class TimeoutException extends AppException {
  const TimeoutException([super.message = "Connection timeout."]);
}
