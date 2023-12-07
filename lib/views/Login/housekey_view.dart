import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumii/models/login_model.dart';
import 'package:rumii/models/user_model.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:rumii/views/Login/has_key_view.dart';
import 'package:rumii/views/Login/new_key_view.dart';

class HousekeyView extends StatefulWidget {
  final String username;
  final String password;
  final String email;
  const HousekeyView(
      {super.key,
      required this.username,
      required this.password,
      required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _HousekeyViewState createState() => _HousekeyViewState();
}

class _HousekeyViewState extends State<HousekeyView> {
  @override
  void initState() {
    super.initState();
    //Provider.of<LoginListViewModel>(context, listen: true);
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
                  const Text("Have a houhold at Rumii already?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ChangeNotifierProvider(
                                        create: (context) =>
                                            LoginListViewModel(),
                                        child: HasHousekeyView(
                                          username: widget.username,
                                          password: widget.password,
                                          email: widget.password,
                                        ),
                                      )));
                        },
                        child: const Text("Yes, I have a household")),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                          create: (context) =>
                                              LoginListViewModel(),
                                          child: NewHousekeyView(
                                            username: widget.username,
                                            password: widget.password,
                                            email: widget.password,
                                          ),
                                        )));
                          },
                          child: const Text("No, create a household"))),
                ]))));
  }
}
