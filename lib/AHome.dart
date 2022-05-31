import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flag/flag.dart';
import 'Abuttons.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  String oneValue = '';

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: Column(
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ButtonsScreen()),
              ).then((value) => {getValue()});
            },
            child: const Icon(Icons.add),
          ),
          Image.asset(
            'icons/flags/png/2.5x/${oneValue}.png',
            package: 'country_icons',
            height: 11,
          ),
        ],
      ),
    );
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      oneValue = prefs.getString('selected_radio') ?? '';
    });
  }
}