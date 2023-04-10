class SingInModel {
  final String email;
  final String password;

  const SingInModel({
    required this.email,
    required this.password,
  });

  toJson() {
    return {
      "Email": email,
      "Password": password,
    };
  }
}
