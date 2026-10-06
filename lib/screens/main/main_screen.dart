import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/responsive.dart';

import 'components/side_menu.dart';
import 'components/top_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(6, (index) => GlobalKey());
  int _activeSectionIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    const int lastNavIndex = 4; // Contact is the last nav item

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      if (_activeSectionIndex != lastNavIndex) {
        setState(() {
          _activeSectionIndex = lastNavIndex;
        });
      }
      return;
    }

    int newIndex = 0;
    double closestOffset = double.infinity;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final keyContext = _sectionKeys[i].currentContext;
      if (keyContext == null) continue;

      final renderBox = keyContext.findRenderObject() as RenderBox?;
      if (renderBox == null) continue;

      final scrollViewContext =
          _scrollController.position.context.storageContext;
      final scrollRenderBox =
          scrollViewContext.findRenderObject() as RenderBox?;
      if (scrollRenderBox == null) continue;

      final sectionOffset =
          renderBox.localToGlobal(Offset.zero, ancestor: scrollRenderBox);

      final distanceFromTop = sectionOffset.dy.abs();
      if (sectionOffset.dy <= 120 && distanceFromTop < closestOffset) {
        closestOffset = distanceFromTop;
        newIndex = i;
      }
    }

    if (newIndex != _activeSectionIndex) {
      setState(() {
        _activeSectionIndex = newIndex;
      });
    }
  }

  void scrollToSection(int index) {
    final keyContext = _sectionKeys[index].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalMargin = Responsive.isMobile(context) ? 12 : 24;
    final double verticalMargin = Responsive.isMobile(context) ? 12 : 24;
    final sectionIndexMapping = [0, 1, 2, 3, 4];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: Responsive.isDesktop(context)
          ? null
          : AppBar(
              backgroundColor: secondaryColor,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: Colors.white),
                ),
              ),
            ),
      drawer: const SideMenu(),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin,
            vertical: verticalMargin,
          ),
          constraints: const BoxConstraints(maxWidth: maxWidth),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                const Expanded(
                  flex: 2,
                  child: SideMenu(),
                ),
              if (Responsive.isDesktop(context))
                const SizedBox(width: defaultPadding),
              Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: borderColor, width: 1),
                  ),
                  child: Column(
                    children: [
                      if (Responsive.isDesktop(context))
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            defaultPadding * 1.5,
                            defaultPadding * 1.5,
                            defaultPadding * 1.5,
                            0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TopNavigationBar(
                                activeSectionIndex: _activeSectionIndex,
                                onSelectSection: (index) {
                                  setState(() {
                                    _activeSectionIndex = index;
                                  });
                                  scrollToSection(sectionIndexMapping[index]);
                                },
                              ),
                            ],
                          ),
                        ),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(defaultPadding * 1.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                widget.children.length,
                                (index) => Container(
                                  key: _sectionKeys[index],
                                  child: widget.children[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
