import '../../../../core/shared/domain/model/user_profile_entity.dart';
import '../response/current_user_response.dart';

extension CurrentUserResponseMapper on CurrentUserResponse {
  UserProfileEntity toDomain() {
    return UserProfileEntity(
      userId: userId,
      email: email,
      fullName: fullName,
      profilePicture: profilePicture,
    );
  }
}

