import 'package:flutter/material.dart';
import 'package:epicture/core/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final linearGradient = const LinearGradient(
      colors: Constants.epictureTextGradient,
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: EpictureBottomAppBar(
          selectedIndex: selectedIndex,
          updateCallback: _updateWidget,
        ),
        appBar: epictureAppBar(linearGradient),
        body: IndexedStack(
          index: selectedIndex,
          children: Constants.pages,
        ));
  }

  void _updateWidget(int newSelectedIndex) {
    setState(() {
      selectedIndex = newSelectedIndex;
    });
  }
}

AppBar epictureAppBar(Shader linearGradient) {
  return AppBar(
      elevation: 5,
      backgroundColor: Colors.white,
      title: Text(
        'Epicture',
        style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            foreground: Paint()..shader = linearGradient),
      ));
}

class EpictureBottomAppBar extends StatefulWidget {
  const EpictureBottomAppBar({
    Key? key,
    required this.selectedIndex,
    required this.updateCallback,
  }) : super(key: key);

  final int selectedIndex;
  final Function(int) updateCallback;

  @override
  _EpictureBottomAppBarState createState() => _EpictureBottomAppBarState();
}

class _EpictureBottomAppBarState extends State<EpictureBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          ),
        ],
      ),
      child: BottomNavigationBar(
        selectedItemColor: Colors.black,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: const IconThemeData(size: 30),
        selectedIconTheme: const IconThemeData(size: 40),
        iconSize: 35,
        onTap: _onItemTapped,
        currentIndex: widget.selectedIndex,
        items: bottomNavigationBarItemList,
      ),
    );
  }

  List<BottomNavigationBarItem> get bottomNavigationBarItemList {
    return const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        activeIcon: Icon(Icons.home),
        icon: Icon(
          Icons.home_outlined,
          color: Colors.grey,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(Icons.search),
        icon: Icon(Icons.search_outlined),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(Icons.add_a_photo),
        icon: Icon(Icons.add_a_photo_outlined),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(Icons.favorite),
        icon: Icon(Icons.favorite_outline),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(Icons.contact_page),
        icon: Icon(Icons.contact_page_outlined),
        label: '',
      ),
    ];
  }

  void _onItemTapped(int index) {
    widget.updateCallback(index);
  }
}
