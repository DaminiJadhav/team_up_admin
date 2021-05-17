import 'dart:io';
import 'package:flutter/material.dart';
import 'package:teamupadmin/Screens/List/AdminsScreen.dart';
import 'package:teamupadmin/Screens/List/ApprovedHackathons.dart';
import 'package:teamupadmin/Screens/List/DeletedAccounts.dart';
import 'package:teamupadmin/Screens/List/EventsScreen.dart';
import 'package:teamupadmin/Screens/List/PostedAdsScreen.dart';
import 'package:teamupadmin/Screens/List/ProfileScreen.dart';
import 'package:teamupadmin/Screens/List/CompletedProjectsScreen.dart';
import 'package:teamupadmin/Screens/List/VerifiedOrganizationScreen.dart';
import 'package:teamupadmin/SharedPreference/SharedPref.dart';
import 'package:teamupadmin/Widgets/AddAdmin.dart';
import 'package:teamupadmin/Widgets/Hachathon.dart';
import 'package:teamupadmin/Widgets/ReqEvents.dart';
import 'package:teamupadmin/Widgets/ReqOrganization.dart';
import 'package:teamupadmin/Widgets/ReqProject.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final widgetOptions = [
    new RequestedEvents(),
    new RequestedProject(),
    new RequestedOrganization(),
    new Hachathon(),
    new AddAdmin()
  ];

  @override
  void initState() {
    super.initState();
    Preference.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.event), title: Text('Event')),
            BottomNavigationBarItem(
                icon: Icon(Icons.pages), title: Text('Project')),
            BottomNavigationBarItem(
                icon: Icon(Icons.business), title: Text('Organization')),
            BottomNavigationBarItem(
                icon: Icon(Icons.code), title: Text('Hachathon')),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle), title: Text('Add Admin')),
          ],
          onTap: (currentIndex) {
            setState(() {
              _currentIndex = currentIndex;
            });
          },
        ),
        drawer: AppDrawer(),
        body: widgetOptions.elementAt(_currentIndex));
  }
}

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  _pageNavigator(Widget PageName, BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PageName));
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm"),
        content: Text('Are you sure. Do you want to logout.'),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("No"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          new FlatButton(
              onPressed: () {
                setState(() {
                  Preference.setIsLogin(false);
                  Preference.setAdminId(0);
                  Preference.setUserName('');
                  Preference.setEmail('');
                  Preference.setName('');
                });
                Future.delayed(const Duration(milliseconds: 1000), () {
                  exit(0);
                });
              },
              child: Text('Yes'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.face,
              text: 'Profile',
              onTap: () => _pageNavigator(Profile(), context)),
          _createDrawerItem(
              icon: Icons.supervised_user_circle,
              text: 'Admin List',
              onTap: () => _pageNavigator(Admins(), context)),
          Divider(),
          _createDrawerItem(
              icon: Icons.pages,
              text: 'Completed Projects',
              onTap: () => _pageNavigator(CompletedProjects(), context)),
          _createDrawerItem(
              icon: Icons.verified_user,
              text: 'Verified Organization',
              onTap: () => _pageNavigator(VerifiedOrganization(), context)),
          _createDrawerItem(
              icon: Icons.delete,
              text: 'De-Activated Accounts',
              onTap: () => _pageNavigator(DeletedAccounts(), context)),
          _createDrawerItem(
              icon: Icons.code,
              text: 'Approved Hackathon',
              onTap: () => _pageNavigator(ApprovedHackathons(), context)),
          _createDrawerItem(
              icon: Icons.event,
              text: 'Posted Events',
              onTap: () => _pageNavigator(PostedEvents(), context)),
          _createDrawerItem(
              icon: Icons.ac_unit,
              text: 'Posted Ads',
              onTap: () => _pageNavigator(PostedAds(), context)),
          Divider(),
          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Logout',
              onTap: () => _showAlert(context)),
        ],
      ),
    );
  }
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              // fit: BoxFit.fill,
              image: AssetImage('assets/splashscreen/icon.png'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 8.0,
            left: 16.0,
            child: Center(
              child: Text(Preference.getName(),
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500)),
            )),
      ]));
}
