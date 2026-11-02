import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dokkan/core/network/error_handler/failure.dart';

Future<Either<Failure, List<Object?>>> waitFailFast(
  List<Future<Either<Failure, Object?>>> futures,
) {
  final completer = Completer<Either<Failure, List<Object?>>>();
  final results = List<Object?>.filled(futures.length, null);
  var done = 0;

  if (futures.isEmpty) return Future.value(Right(results));

  for (var i = 0; i < futures.length; i++) {
    futures[i].then((either) {
      if (completer.isCompleted) return;
      either.fold(
        (failure) => completer.complete(Left(failure)), // أول فشل يكسب
        (value) {
          results[i] = value;
          if (++done == futures.length) completer.complete(Right(results));
        },
      );
    }).catchError((Object e, StackTrace s) {
      if (!completer.isCompleted) completer.completeError(e, s);
    });
  }
  return completer.future;
}