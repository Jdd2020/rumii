import 'package:flutter/material.dart';
import 'package:rumii/views/login_view.dart';
import 'package:provider/provider.dart';

import 'router.dart' as local_router;
import 'constants.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: ChangeNotifierProvider(
        create: (context) => null,
        child: const LoginView(),
      ),
      onGenerateRoute: local_router.Router.generateRoute,
      initialRoute: loginRoute,
    );
  }
}
