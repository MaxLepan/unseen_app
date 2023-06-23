import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet_b3/Informations/informations_view.dart';
import 'package:projet_b3/firebase_options.dart';
import 'package:projet_b3/routes.dart';
import 'package:provider/provider.dart';
import 'Search/search_view.dart';
import 'Map/map_view.dart';
import 'Themes/app_bar.dart';
import 'Themes/colors.dart';
import 'coming_soon_view.dart';
import 'filters_state.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => FilterState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: materialGreeBrown,
        scaffoldBackgroundColor: white,
      ),
      home: MediaQuery(
        data: const MediaQueryData(),
        child: Scaffold(
          body: MyTabView(),
        ),
      ),
      routes: routes,
      initialRoute: '/',
    );
  }
}

class MyTabView extends StatefulWidget {
  @override
  _MyTabViewState createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView> {
  int _selectedIndex = 1;
  final List<Widget> _pages = [
    const SearchView(),
    const MapView(),
    InformationsView(),
    const ComingSoonView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _pages.length,
      initialIndex: _selectedIndex,
      child: Scaffold(
        body: TabBarView(
          children: _pages,
        ),
        bottomNavigationBar: MyBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}


