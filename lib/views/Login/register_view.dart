import 'package:flutter/material.dart';
import 'package:rumii/views/Dashboard/dashboard_view.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:rumii/models/login_model.dart';
import 'package:rumii/views/Login/housekey_view.dart';

//import 'package:rumii/constants.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
    _emailController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Align(
                alignment: FractionalOffset.center,
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      obscureText: false,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                        labelText: '   Username',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      obscureText: false,
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: '   Email',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                        labelText: '   Password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      obscureText: true,
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                        labelText: '   Confirm Password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.pink),
                          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(
                                color: const Color.fromARGB(0, 255, 255, 255),
                                width: 0,
                              ),
                        ),),
                        ),
                        onPressed: () {
                          /*
                          var reg = Login(
                              username: _usernameController.text,
                              password: _passwordController.text,
                              email: _emailController.text,
                              houseKey: "",
                              uniqueId: 0,
                              signedIn: false,
                              verification: -1);

                          var userBase = context.read<LoginListViewModel>();
                          await userBase.writeUser(reg);
                          setState(() {});
                          */

                          /*
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(reg.password),
                                );
                              });
                            */

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ChangeNotifierProvider(
                                        create: (context) =>
                                            LoginListViewModel(),
                                        child: HousekeyView(
                                          username: _usernameController.text,
                                          password: _passwordController.text,
                                          email: _emailController.text,
                                        ),
                                      )));
                        },
                        child: const Text("Register"),
                      )),
                ]))));
  }
}
