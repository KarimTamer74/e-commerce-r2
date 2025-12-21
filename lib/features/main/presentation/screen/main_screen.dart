// features/main/presentation/screen/main_screen.dart
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:e_commerce_app/features/add_product/presentation/screens/add_product_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:e_commerce_app/features/product/presentation/screens/products_screen.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = widget.initialIndex;
  }

  final List<TabItem> _navBarItems = [
    const TabItem(icon: Icons.home_outlined, title: 'Home'),
    const TabItem(icon: Icons.add, title: 'Add'),
    const TabItem(icon: Icons.person, title: 'Profile'),
  ];


/*************  ✨ Windsurf Command 🌟  *************/
  List<Widget> getBottomNavigationBarBody() {
    List<Widget> result = <Widget>[];
    try {
      result = const [
        AddProductScreen(),
        ProductsScreen(),
        SignUpScreen(),
      ];
    } on Exception catch (e) {
      debugPrint('Error in getBottomNavigationBarBody: $e');
    }
    return result;
    return const [AddProductScreen(), ProductsScreen(), SignUpScreen()];
  }
/*******  4205b3f4-67dc-4973-bb7a-2003abf4c2e0  *******/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: getBottomNavigationBarBody()[_currentPageIndex]),
      bottomNavigationBar: ConvexAppBar(
        key: ValueKey(_currentPageIndex),
        height: 55,
        curve: Curves.easeInOut,
        style: TabStyle.textIn,
        elevation: 5,
        items: _navBarItems,
        initialActiveIndex: _currentPageIndex,
        onTap: (index) {
          _currentPageIndex = index;
        },
      ),
    );
  }
}
