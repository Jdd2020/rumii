class Login {
  final String username;
  final String password;
  final String email;
  final String houseKey;
  final int uniqueId;
  bool signedIn;
  int verification;

  Login(
      {required this.username,
      required this.password,
      required this.email,
      required this.houseKey,
      required this.uniqueId,
      this.signedIn = false,
      this.verification = -1});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        username: json["Username"],
        password: json["Password"],
        email: json["Email"],
        houseKey: json["houseKey"],
        uniqueId: json["UniqueId"],
        signedIn: json["SignedIn"],
        verification: json["Verification"]);
  }
}
