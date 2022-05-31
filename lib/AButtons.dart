// import 'package:flutpro/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AButtonsValues.dart';
import 'package:flag/flag.dart';

class ButtonsScreen extends StatefulWidget {
  @override
  State<ButtonsScreen> createState() => _ButtonsScreenState();
}

class _ButtonsScreenState extends State<ButtonsScreen> {
  final TextEditingController _countriesController = TextEditingController();
  var oneValue = 'us';

  @override
  void initState() {
    super.initState();
    getValue();
  }

  Future<void> getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('selected_radio') != null) {
      setState(() {
        oneValue = prefs.getString('selected_radio')!;
      });
    }
  }

  Future<void> setValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      oneValue = value.toString();
      prefs.setString('selected_radio', oneValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 239, 239),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 240, 239, 239),
          elevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 95,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    controller: _countriesController,
                    decoration: const InputDecoration(
                      hintText: "Search Countries",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    maxLines: null,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  itemCount: long.length,
                  controller: ScrollController(),
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) => MyRadioListTile<String>(
                    value: long[index],
                    groupValue: oneValue,
                    leading: short[index],
                    title: long[index],
                    flag: short[index],
                    onChanged: (value) => setValue(
                      value.toString(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final String title;
  final String flag;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    required this.title,
    required this.flag,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 41,
        child: Container(
          child: _customRadioButton,
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      width: 200,
      padding: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: isSelected ? Color.fromARGB(255, 111, 111, 111) : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Container(
                width: 25,
                height: 15,
                child:
                
                Flag.fromString(
                flag,
                width: 25,
                height: 15,
                fit: BoxFit.fill,
              ),
                
                
                //  Image.asset('icons/flags/png/2.5x/us.png',
                //     package: 'country_icons', height: 15, width: 25)

                // Below is what I've attempted and when I try it, I get an error.
                // Image.asset('icons/flags/png/2.5x/${leading}.png',
                // package: 'country_icons', height: 15, width: 25)

                ),
          ),
          Center(
            child: Container(
              width: 74,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[600]!,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}