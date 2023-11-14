import 'package:flutter/material.dart';
import 'package:rumii/views/dashboard_view.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:provider/provider.dart';

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
    //Provider.of<LoginListViewModel>(context, listen: true);
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
              height: 28.00, width: 70.00), //const Text("Rumii"),
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
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
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
                          onPressed: () async {
                            var userBase = context.read<LoginListViewModel>();
                            await userBase.fetchUser(_usernameController.text);
                            setState(() {});
                            if (userBase.users.isNotEmpty) {
                              // ignore: use_build_context_synchronously
                              if (userBase.users[0].password ==
                                      _passwordController.text &&
                                  userBase.users[0].username ==
                                      _usernameController.text) {
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DashboardView()));
                                setState(() {});
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
                            }
                            // ignore: use_build_context_synchronously
                            else {
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

                            /*
                            //vm.clear();
                            vm.fetchUser(_usernameController.text);
                            if (vm.users.isNotEmpty) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(vm.users[0].password),
                                  );
                                },
                              );
                              vm.clear();
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                        "invalid user: ${_usernameController.text}"),
                                  );
                                },
                              );
                            }
                            */
                            /*
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboardView()));
                                      */
                          },
                          child: const Text("Submit"))),
                  const SizedBox(height: 20),
                  InkWell(
                    child: const Text("New User? Register Here!"),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()))
                    },
                  ),
                ]))));
  }
}

//Register view for new users
class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Rumii")),
        body: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Align(
                alignment: FractionalOffset.center,
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 250,
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 250,
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 250,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 250,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 50,
                      width: 250,
                      child: ElevatedButton(
                        child: const Text("Register"),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DashboardView()))
                        },
                      )),
                ]))));
  }
}
