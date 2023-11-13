import 'package:flutter/material.dart';
import 'package:rumii/views/widgets/CustomBottomNavigationBar.dart';

class ChoreListView extends StatefulWidget {
  const ChoreListView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChoreListViewState createState() => _ChoreListViewState();
}

class _ChoreListViewState extends State<ChoreListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset('assets/images/rumii-logo.png', height: 28.00, width: 70.00), //const Text("Rumii"),
          centerTitle: true,
          automaticallyImplyLeading: false,
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            const SizedBox(height: 10),
            const Text('Chore List', style: (TextStyle(fontSize: 26, fontWeight: FontWeight.bold,))),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    child: const Text(
                      "+ New",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NewChore()))
                        })),
          ]),),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentRoute: '/chores',
          onRouteChanged: (route) {
            Navigator.of(context)
                .pushNamed(route); // navigate to a different view
          }),
    );
  }
}

//NewChore View
class NewChore extends StatelessWidget {
  const NewChore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: <Widget>[
          const SizedBox(height: 10),
          const Text('New Chore', style: (TextStyle(fontSize: 26, fontWeight: FontWeight.bold,))),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
                child: const Text('Cancel',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChoreListView()))
                    }),
            InkWell(
                child: const Text('Save',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChoreListView()))
                    }),
          ]),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            width: 1500,
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Name your Chore'),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            width: 1500,
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Assign User'),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            width: 1500,
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Due Date'),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 1500,
            child: DropdownButton<String>(
              items: [
                DropdownMenuItem<String>(
                  value: 'Daily',
                  child: Text('Daily'),
                ),
                DropdownMenuItem<String>(
                  value: 'Weekly',
                  child: Text('Weekly'),
                ),
                DropdownMenuItem<String>(
                  value: 'Bi-weekly',
                  child: Text('Bi-weekly'),
                ),
                DropdownMenuItem<String>(
                  value: 'Monthly',
                  child: Text('Monthly'),
                ),
              ],
              onChanged: (String? value) {
                //hanlde the selected
                return;
              },
              hint: Text('Repetition'),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            width: 1500,
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Reminder'),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            width: 1500,
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Note'),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            width: 1500,
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Points'),
            ),
          ),
        ]),
      ),
    );
  }
}
