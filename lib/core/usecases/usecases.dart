import 'package:flutter_clean_architecture_example/core/utils/typedef.dart';

abstract class UsecasesWithParams<Type, Params> {
  const UsecasesWithParams();
  FutureResult<Type> call(final Params params);
}

abstract class UsecasesWithoutParams<Type> {
  const UsecasesWithoutParams();
  FutureResult<Type> call();
}
