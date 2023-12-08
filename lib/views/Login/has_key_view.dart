import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/constants.dart';
import 'package:rumii/models/login_model.dart';
import 'package:rumii/models/user_model.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:rumii/views/Dashboard/dashboard_view.dart';

class HasHousekeyView extends StatefulWidget {
  final String username;
  final String password;
  final String email;
  const HasHousekeyView(
      {super.key,
      required this.username,
      required this.password,
      required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _HasHousekeyViewState createState() => _HasHousekeyViewState();
}

class _HasHousekeyViewState extends State<HasHousekeyView> {
  final TextEditingController _housekeyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<LoginListViewModel>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Have a Household?")),
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Align(
                alignment: FractionalOffset.center,
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  const Text("Join the Household!",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold, height: 1.1)),
                  const SizedBox(height: 10),
                  const Text(
                    "Your housemates can find their House Key code on the Dashboard.",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 45,
                    width: 250,
                    child: TextField(
                      obscureText: false,
                      controller: _housekeyController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: ' Enter House Key',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 50,
                      width: 180,
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
                          ),
                        ),),
                          child: const Text("Join Household"),
                          onPressed: () {
                            var user = Login(
                                username: widget.username,
                                email: widget.email,
                                password: widget.password,
                                houseKey: _housekeyController.text,
                                uniqueId: 0);
                            if (Provider.of<LoginListViewModel>(context,
                                    listen: false)
                                .checkKey(user.houseKey)) {
                              Provider.of<LoginListViewModel>(context,
                                      listen: false)
                                  .addUserWithKey(user);
                              Provider.of<LoginListViewModel>(context,
                                      listen: false)
                                  .writeData();
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
                          }))
                ]))));
  }
}
