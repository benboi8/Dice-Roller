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
}
