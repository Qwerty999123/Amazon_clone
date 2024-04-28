import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/features/admin/screens/products_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  List<Widget> adminPages = [
    ProductsScreen(),
    const Center(child: Text('Analytics'),),
    const Center(child: Text('Orders'),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: Image.asset(
            'assets/images/amazon_in.png',
            height: 40,
            color: Colors.black,
          ),
          actions: const [
            Text(
              'Admin',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
              )
            ),
            SizedBox(
              width: 15,
            )
            
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _page = value;
          });
        },
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0 
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined
              ),
            ),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1 
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth
                  ),
                ),
              ),
              child: const Icon(
                Icons.analytics_outlined
              ),
            ),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2 
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth
                  ),
                ),
              ),
              child: Icon(
                Icons.all_inbox_outlined
              ),
            ),
            label: '',
          ),
        ],
      ),
      body: adminPages[_page],
    );
  }
}