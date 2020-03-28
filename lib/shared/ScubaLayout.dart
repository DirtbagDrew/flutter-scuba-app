import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/src/LogEntryForm/LogEntryForm.dart';
import 'package:scuba/src/Profile/Profile.dart';

class ScubaLayout extends StatelessWidget {
  const ScubaLayout(
      {Key key,
      @required this.slivers,
      this.selectedIndex,
      this.automaticallyImplyLeading = false})
      : super(key: key);
  final List<Widget> slivers;
  final int selectedIndex;
  final bool automaticallyImplyLeading;
  void _onItemTapped(BuildContext context, int index) {
    if (index != selectedIndex) {
      Widget result = LogEntryForm();
      if (index == 1) {
        result = Profile();
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => result),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: automaticallyImplyLeading,
            title: Text("<LOGO HERE>"),
          ),
          ...slivers
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.ScubaLayout),
          //   title: Text('ScubaLayout'),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            title: Text('Log New Dive'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          _onItemTapped(context, index);
        },
      ),
    );
  }
}
