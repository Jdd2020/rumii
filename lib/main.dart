import 'package:flutter/material.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:rumii/views/Login/login_view.dart';
import 'package:provider/provider.dart';
import 'router.dart' as local_router;
import 'constants.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: ChangeNotifierProvider(
        create: (context) => LoginListViewModel(),
        child: const LoginView(),
      ),
      onGenerateRoute: local_router.Router.generateRoute,
      initialRoute: loginRoute,
    );
  }
}
