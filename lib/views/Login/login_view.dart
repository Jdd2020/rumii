import 'package:flutter/material.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/views/Dashboard/dashboard_view.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:provider/provider.dart';

import 'package:rumii/constants.dart';

//Initial view for basic login operations
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // ignore: prefer_typing_uninitialized_variables
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<LoginListViewModel>(context, listen: false).fetchData();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final vm = Provider.of<LoginListViewModel>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/rumii-logo.png',
              height: 28.00, width: 70.00),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Align(
                alignment: FractionalOffset.center,
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  //Image.asset('assets/images/house.png', height: 100, width: 100,),
                  const SizedBox(height: 15),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      obscureText: false,
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            //await userBase.fetchUser(_usernameController.text);
                            if (Provider.of<LoginListViewModel>(context,
                                    listen: false)
                                .loginCheck(_usernameController.text,
                                    _passwordController.text)) {
                              var user = Provider.of<LoginListViewModel>(
                                      context,
                                      listen: false)
                                  .fetchUser(_usernameController.text);
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, dashRoute,
                                  arguments: SessionData.data(
                                      user.username, user.houseKey));
                            } else {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      content:
                                          Text("Invalid username or password"),
                                    );
                                  });
                            }
                          },
                          child: const Text("Submit"))),
                  const SizedBox(height: 20),
                  InkWell(
                    child: const Text("New User? Register Here!"),
                    onTap: () => {
                      Navigator.pushNamed(context, registerRoute,
                          arguments: SessionData.data("", ""))
                    },
                  ),
                ]))));
  }
}
