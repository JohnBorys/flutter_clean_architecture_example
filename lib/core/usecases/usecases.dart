// ignore_for_file: one_member_abstracts, document_ignores

import 'package:flutter_clean_architecture_example/core/utils/typedef.dart';

abstract class UsecasesWithParams<Type, Params> {
  const UsecasesWithParams();
  FutureResult<Type> call(Params params);
}

abstract class UsecasesWithoutParams<Type> {
  FutureResult<Type> call();
}
