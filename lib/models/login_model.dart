/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.

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

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  Login.fromJson(Map<String, dynamic> json)
      : username = json['username'] as String,
        password = json['password'] as String,
        email = json['email'] as String,
        houseKey = json['houseKey'] as String,
        uniqueId = json['uniqueId'] as int,
        signedIn = json['signedIn'] as bool,
        verification = json['verification'] as int;

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'email': email,
        'houseKey': houseKey,
        'uniqueId': uniqueId,
        'signedIn': signedIn,
        'verification': verification
      };

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
}
