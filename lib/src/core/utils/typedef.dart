import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/src/core/error/failure.dart';

typedef FutureResult<T> = Future<Either<Failure, T>>;
typedef ResultVoid = Future<Either<Failure, void>>;
typedef DataMap = Map<String, dynamic>;
