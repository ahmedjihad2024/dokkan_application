import '../../../../core/network/base_response.dart';
import '../models/user_model.dart';

class UserResponse implements BasicResponse {
  final UserModel? data;
  final bool? isSuccess;
  final String? responseMessage;

  const UserResponse({this.data, this.isSuccess, this.responseMessage});

  @override
  bool get success => isSuccess ?? (data != null);

  @override
  String get message =>
      responseMessage ?? (success ? 'Success' : 'Failed to fetch user data');

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    final userDataMap =
        json.containsKey('data') && json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    return UserResponse(
      data: UserModel.fromJson(userDataMap),
      isSuccess: json['status'] as bool? ?? true,
      responseMessage: json['message'] as String?,
    );
  }
}
