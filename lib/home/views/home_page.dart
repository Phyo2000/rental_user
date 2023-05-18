import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_user/authentication/controllers/login_controller.dart';
import 'package:rental_user/cart/widgets/cart_widget.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/widgets/home_widget.dart';
import 'package:rental_user/profile/views/profile_screen.dart';
import 'package:rental_user/user/model/user_model.dart';

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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => _children[_currentIndex]),
          // );
          // final CurvedNavigationBarState? navBarState =
          //     _bottomNavigationKey.currentState;
          // navBarState?.setPage(_currentIndex);
        },
        height: 53,
        color: mainColor,
        items: [
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
      widget = Home();
      break;
    case 1:
      widget = CartView();
      break;
    case 3:
      widget = ProfileView();
      break;
    default:
      widget = Home();
      break;
  }
  return widget;
}
