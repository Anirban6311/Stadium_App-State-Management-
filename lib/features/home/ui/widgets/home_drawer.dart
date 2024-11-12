import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero_animation/features/about/ui/about_page.dart';
import 'package:hero_animation/features/country/ui/search_country_page.dart';
import 'package:hero_animation/features/notes/ui/notes_page.dart';
import 'package:hero_animation/features/wishlist/ui/wishlist_page.dart';

import '../../../planned/ui/planned_page.dart';
import '../home.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.indigo,
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Anirban Sinha Roy'),
            accountEmail: const Text('asinharoy33@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/247_logo.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.teal,
              // image: DecorationImage(fit: BoxFit.cover, image: ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            title: const Text(
              'Favorites',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WishlistPage()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.event_note_outlined,
              color: Colors.white,
            ),
            title: const Text(
              'Planned Stadiums',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PlannedPage()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.checklist,
              color: Colors.white,
            ),
            title: const Text(
              'Task Manager',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotesPage()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.flag,
              color: Colors.white,
            ),
            title: const Text(
              'Country',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchCountryPage()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.description,
              color: Colors.white,
            ),
            title: const Text(
              'About Software',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(Icons.home, color: Colors.white),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          ListTile(
            title: const Text(
              'Exit',
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(Icons.exit_to_app, color: Colors.white),
            onTap: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }
}
