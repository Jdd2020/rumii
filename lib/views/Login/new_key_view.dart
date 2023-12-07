import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/constants.dart';
import 'package:rumii/models/login_model.dart';
import 'package:rumii/models/user_model.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:rumii/views/Dashboard/dashboard_view.dart';

class NewHousekeyView extends StatefulWidget {
  final String username;
  final String password;
  final String email;
  const NewHousekeyView(
      {super.key,
      required this.username,
      required this.password,
      required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _NewHousekeyViewState createState() => _NewHousekeyViewState();
}

class _NewHousekeyViewState extends State<NewHousekeyView> {
  final TextEditingController _housekeyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<LoginListViewModel>(context, listen: false).fetchData();
  }

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
                  const Text("Welcome to Rumii!",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text(
                    "We have a few questions to get you started",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      obscureText: false,
                      controller: _housekeyController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Housekey',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Enter a key that'll be used to join your house!",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                          child: const Text("New Home"),
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
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      content: Text("This key already exists"),
                                    );
                                  });
                            } else {
                              // ignore: use_build_context_synchronously
                              Provider.of<LoginListViewModel>(context,
                                      listen: false)
                                  .addUserNewKey(user);
                              Provider.of<LoginListViewModel>(context,
                                      listen: false)
                                  .writeData();
                              Navigator.pushNamed(context, dashRoute,
                                  arguments: SessionData.data(
                                      user.username, user.houseKey));
                            }
                          }))
                ]))));
  }
}
