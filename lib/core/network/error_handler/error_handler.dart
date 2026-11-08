// ignore_for_file: constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dokkan/core/network/base_response.dart';

import 'failure.dart';

Future<Either<Failure, T>> fastHandler<R, T>({
  required Future<R> Function() request,
  required T Function(R response) mapper,
}) async {
  try {
    final response = await request();
    if (response is BasicResponse && !response.success) {
      return Left(ServerError(message: response.message));
    }
    return Right(mapper(response));
  } catch (e) {
    return Left(e.handle);
  }
}

extension ErrorHandler on Object {
  Failure get handle => switch (this) {
    final DioException e => _handleDioException(e),
    _ => UnexpectedError(message: toString()),
  };
}

Failure _handleDioException(DioException e) => switch (e.type) {
  DioExceptionType.badResponse => _handleBadResponse(e.response),
  DioExceptionType.connectionError => const NoInternetConnection(),
  DioExceptionType.connectionTimeout => const CustomDioLocalError(
    error: LocalErrorType.CONNECTION_TIMEOUT,
  ),
  DioExceptionType.sendTimeout => const CustomDioLocalError(
    error: LocalErrorType.SEND_TIMEOUT,
  ),
  DioExceptionType.receiveTimeout => const CustomDioLocalError(
    error: LocalErrorType.RECEIVE_TIMEOUT,
  ),
  DioExceptionType.transformTimeout => const CustomDioLocalError(
    error: LocalErrorType.TRANSFORM_TIMEOUT,
  ),
  DioExceptionType.cancel => const CustomDioLocalError(error: LocalErrorType.CANCEL),
  DioExceptionType.badCertificate => const CustomDioLocalError(
    error: LocalErrorType.BAD_CERTIFICATION,
  ),
  DioExceptionType.unknown => switch (e.error) {
    final Failure f => f,
    _ => _isSessionDeadError(e.error)
        ? const CustomServerError(error: ApiErrorType.UNAUTHORIZED)
        : const CustomDioLocalError(error: LocalErrorType.UNKNOWN),
  },
};

bool _isSessionDeadError(Object? err) {
  if (err == null) return false;
  final str = err.toString().toLowerCase();
  return str.contains('invalidrefresh') ||
      str.contains('refresh token') ||
      str.contains('session expired');
}

Failure _handleBadResponse(Response? response) {
  final status = response?.statusCode;

  final message = _extractMessage(response?.data);
  if (message == null) {
    if (status == 500) {
      return const ServerError(
        message: 'This email is already registered or a server error occurred.',
      );
    }
    return ServerError(message: response?.statusMessage ?? 'An unknown error occurred.');
  }

  final apiError = ApiErrorType.from(status, message);
  return apiError != null
      ? CustomServerError(error: apiError)
      : ServerError(message: message);
}

/// Keys the backend may use to send the error message (by priority).
const _messageKeys = ['message', 'error', 'detail', 'title'];

/// Finds the error message in any response shape:
/// - "text"
/// - {"message": "text"}
/// - {"message": ["a", "b"]}
/// - {"error": {"message": "text"}}
/// - {"title": "...", "errors": {"Email": ["..."]}}  (validation errors)
/// - {"statusCode": 400, "message": "One or more errors occurred!", "errors": {"generalErrors": ["Invalid email or password."]}}
String? _extractMessage(dynamic data) {
  if (data == null) return null;

  if (data is String) {
    final text = data.trim();
    // ignore empty text and HTML pages (e.g. 502 from a proxy)
    return text.isEmpty || text.startsWith('<') ? null : text;
  }

  if (data is List) {
    final parts = data
        .map(_extractMessage)
        .whereType<String>()
        .where((s) => s.isNotEmpty && s != 'One or more errors occurred!')
        .toList();
    if (parts.isNotEmpty) return parts.join('\n');
    final allParts = data.map(_extractMessage).whereType<String>().toList();
    return allParts.isEmpty ? null : allParts.join('\n');
  }

  if (data is Map) {
    // 1. Field validation and general errors first: more specific than wrapper title/message
    final errors = data['errors'] ?? data['modelState'] ?? data['generalErrors'];
    if (errors != null) {
      if (errors is Map) {
        final messages = <String>[];
        for (final value in errors.values) {
          final msg = _extractMessage(value);
          if (msg != null && msg.isNotEmpty && msg != 'One or more errors occurred!') {
            messages.add(msg);
          }
        }
        if (messages.isNotEmpty) {
          return messages.join('\n');
        }
      } else {
        final msg = _extractMessage(errors);
        if (msg != null && msg.isNotEmpty && msg != 'One or more errors occurred!') {
          return msg;
        }
      }
    }

    // 2. Check prioritized message keys, ignoring generic wrapper messages if possible
    for (final key in _messageKeys) {
      final val = data[key];
      if (val != null) {
        final msg = _extractMessage(val);
        if (msg != null && msg.isNotEmpty && msg != 'One or more errors occurred!') {
          return msg;
        }
      }
    }

    // 3. Fallback to any available message key even if generic
    for (final key in _messageKeys) {
      final val = data[key];
      if (val != null) {
        final msg = _extractMessage(val);
        if (msg != null && msg.isNotEmpty) {
          return msg;
        }
      }
    }
  }

  return null;
}

enum LocalErrorType {
  CONNECTION_TIMEOUT('Connection to the server timed out.'),
  SEND_TIMEOUT('Request timed out while sending.'),
  RECEIVE_TIMEOUT('Response timed out while receiving.'),
  TRANSFORM_TIMEOUT('Response processing timed out.'),
  CANCEL('Request was cancelled.'),
  BAD_CERTIFICATION('Invalid certificate from the server.'),
  UNKNOWN('Something went wrong. Please try again.');

  final String message;
  const LocalErrorType(this.message);
}

enum ApiErrorType {
  USER_NOT_CONFIRMED(401, 'User is not confirmed.'),
  UNAUTHORIZED(401, 'غير مصرح'),
  EMAIL_TAKEN(400, 'An account with the given email already exists.'),
  INCORRECT_CREDENTIALS(400, 'Invalid email or password.'),
  INCORRECT_CREDENTIALS_401(401, 'Incorrect username or password.'),
  INVALID_CODE(400, 'Invalid code provided, please request a code again.'),
  INVALID_REFRESH_TOKEN(400, 'Invalid Refresh Token'),
  EMAIL_NOT_VERIFIED(400, 'Email not verified, please verify your email first.');

  final int statusCode;
  final String message;
  const ApiErrorType(this.statusCode, this.message);

  static ApiErrorType? from(int? statusCode, String message) {
    final lower = message.toLowerCase().trim();
    for (final e in values) {
      if ((e.statusCode == statusCode || statusCode == null) &&
          (e.message.toLowerCase() == lower || lower.contains(e.message.toLowerCase()))) {
        return e;
      }
    }
    return null;
  }
}
