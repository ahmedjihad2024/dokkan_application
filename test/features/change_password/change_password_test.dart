import 'package:dokkan/features/authentication/data/request/change_password_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ChangePasswordRequest serializes expected POST body keys', () {
    const request = ChangePasswordRequest(
      currentPassword: 'Ahe@#3123',
      newPassword: 'Ahe@#3123',
      confirmNewPassword: 'Ahe@#3123',
    );

    expect(request.toJson(), {
      'currentPassword': 'Ahe@#3123',
      'newPassword': 'Ahe@#3123',
      'confirmNewPassword': 'Ahe@#3123',
    });
  });
}

