import 'package:flutter/material.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:provider/provider.dart';

import 'package:rumii/constants.dart';

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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final vm = Provider.of<LoginListViewModel>(context, listen: true);
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 90),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/rumii-pink.png',
                          height: 220,
                          width: 220,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Row(children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: TextField(
                          obscureText: false,
                          controller: _usernameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: '   Username',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: TextField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: '   Password',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.pink),
                              shape: MaterialStatePropertyAll<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: const BorderSide(
                                    color: Color.fromARGB(0, 255, 255, 255),
                                    width: 0,
                                  ),
                                ),
                              ),
                            ),
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
                                        content: Text(
                                            "Invalid username or password"),
                                      );
                                    });
                              }
                            },
                            child: const Text("Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          )),
                      const SizedBox(height: 18),
                      const Text("- or -"),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: const BorderSide(
                                  color: Colors.pink,
                                  width: 1.25,
                                ),
                              ),
                            ),
                          ),
                          child: const Text("Create an Account",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          onPressed: () => {
                            Navigator.pushNamed(context, registerRoute,
                                arguments: SessionData.data("", ""))
                          },
                        ),
                      )
                    ]))));
  }
}
