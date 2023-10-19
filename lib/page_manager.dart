import 'package:flutter/material.dart';

class PageManager {
  static int settingsPage = 0;
  static int rollerPage = 1;
  static int setupPage = 2;
  static int pageIndex = rollerPage;

  static final List<int> _pageHistory = [];

  static void pushPageIndex(int pageIndex) {
    _pageHistory.add(pageIndex);
  }

  static void popPageIndex() {
    if (_pageHistory.isNotEmpty) {
      pageIndex = _pageHistory.removeLast();
    }
  }

  static void routeToMainPage(BuildContext context, page, bool isLeft) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 650),
      reverseTransitionDuration: const Duration(milliseconds: 650),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin = Offset(isLeft ? -1 : 1, 0.0);
        Offset end = Offset.zero;
        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeOutExpo));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ));
  }

  static void routeToPage(BuildContext context, page) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (context) => page));
  }
}
