import 'package:rumii/models/login_model.dart';

class LoginViewModel {
  final Login login;

  LoginViewModel({required this.login});

  String get username {
    return login.username;
  }

  String get password {
    return login.password;
  }

  String get email {
    return login.email;
  }

  String get houseKey {
    return login.houseKey;
  }

  int get uniqueId {
    return login.uniqueId;
  }

  bool get signedIn {
    return login.signedIn;
  }

  int get verification {
    return login.verification;
  }
}
