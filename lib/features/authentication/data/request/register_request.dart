class RegisterRequest {
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;

  const RegisterRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'firstName': firstName,
        'lastName': lastName,
      };

  @override
  String toString() => 'RegisterRequest(email: $email)';
}
