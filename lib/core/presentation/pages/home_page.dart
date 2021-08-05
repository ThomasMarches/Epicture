import 'package:flutter/material.dart';
import 'package:very_good_starter/core/utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final linearGradient = const LinearGradient(
      colors: Constants.epictureTextGradient,
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const EpictureBottomAppBar(),
        appBar: epictureAppBar(linearGradient),
        body: Center(
          child: Container(),
        ));
  }
}

AppBar epictureAppBar(Shader linearGradient) {
  return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        'Epicture',
        style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            foreground: Paint()..shader = linearGradient),
      ));
}

class EpictureBottomAppBar extends StatelessWidget {
  const EpictureBottomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 30,
      unselectedItemColor: Colors.black,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      unselectedIconTheme: const IconThemeData(size: 30),
      selectedIconTheme: const IconThemeData(size: 40),
      iconSize: 35,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const RadialGradient(
                center: Alignment.topLeft,
                radius: 0.5,
                colors: Constants.epictureTextGradient,
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: const Icon(Icons.home),
          ),
          icon: const Icon(Icons.home, color: Colors.grey),
          label: '',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.add_a_photo), label: ''),
        const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
        const BottomNavigationBarItem(
            icon: Icon(Icons.contact_page), label: ''),
      ],
    );
  }
}
