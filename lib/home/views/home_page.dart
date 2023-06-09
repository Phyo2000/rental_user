import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_user/cart/views/cart_page.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/widgets/home_widget.dart';
import 'package:rental_user/profile/views/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  // GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  // final List<Widget> _children = [
  //   HomePage(),
  //   ProfilePage(),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getWidget(index: _currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        height: 53,
        color: mainColor,
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.cart_fill,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        index: _currentIndex,
        letIndexChange: (index) => true,
      ),
    );
  }
}

Widget getWidget({required int index}) {
  Widget widget;
  switch (index) {
    case 0:
      widget = const Home();
      break;
    case 1:
      widget = const CartPage();
      break;
    case 3:
      widget = const ProfileView();
      break;
    default:
      widget = const Home();
      break;
  }
  return widget;
}
