import 'package:either_dart/either.dart';
import 'package:k_bus_driver/util/app_exception/app_exception.dart';

typedef EitherResponse<T> = Future<Either<AppException, T>>;
