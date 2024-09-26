import 'package:authenticatio_samplen/pages/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(child: Icon(Icons.messenger)),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: ListTile(
                    title: Text("HOME"),
                    leading: Icon(Icons.home),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage())),
                child: const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: ListTile(
                    title: Text("SETTINGS"),
                    leading: Icon(Icons.settings),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/wall');
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: ListTile(
                    title: Text("WALL"),
                    leading: Icon(Icons.settings),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: signOut,
            child: const Padding(
              padding: EdgeInsets.only(left: 15, bottom: 10),
              child: ListTile(
                title: Text("LOGOUT"),
                leading: Icon(Icons.logout),
              ),
            ),
          )
        ],
      ),
    );
  }
}
