import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/index/widgets/home.dart';
import 'package:one_chatgpt_flutter/ui/index/widgets/person.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});
  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
  }

  int currentPageIndex = 0;
  void updatePageIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
    pageController.jumpToPage(index);
  }

  final bodyList = [const Home(), const Person()];
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: bodyList,
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            updatePageIndex(index);
          },
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.ballot),
              icon: Icon(Icons.ballot_outlined),
              label: '对话',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outlined),
              label: '我的',
            ),
          ],
        ));
  }
}
