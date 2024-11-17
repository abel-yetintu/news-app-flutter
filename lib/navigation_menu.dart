import 'package:echo/features/articles/presentation/screens/search_screen.dart';
import 'package:echo/features/articles/presentation/screens/top_headlines_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final List<Widget> _screens = [
    const TopHeadlinesScreen(),
    const SearchScreen(),
    const Center(
      child: Text('Saved Screen'),
    ),
  ];
  int _navigationMenuIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _screens[_navigationMenuIndex],
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: _navigationMenuIndex,
        onDestinationSelected: (value) {
          setState(() {
            _navigationMenuIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.newspaper), label: 'Top Headlines'),
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.magnifyingGlass), label: 'Search'),
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.bookmark), label: 'Saved'),
        ],
      ),
    );
  }
}
