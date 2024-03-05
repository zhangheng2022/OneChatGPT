import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/index/components/home.dart';
import 'package:one_chatgpt_flutter/ui/index/components/person.dart';

class Index extends StatefulWidget {
  const Index({super.key});
  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          tooltip: '新增对话',
          child: const Icon(Icons.add),
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
