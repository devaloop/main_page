library devaloop_main_page;

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.appName,
    required this.userInfo,
    this.appIcon,
    required this.appIconOnTap,
    required this.mainMenus,
  });

  final String appName;
  final String userInfo;
  final Function() appIconOnTap;
  final Widget? appIcon;
  final List<MainMenu> mainMenus;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController _tabControllerMainMenu;
  late bool _isLabelMainMenuDisplayed;
  late MainMenu _selectedMainMenu;

  TabController? _tabControllerSubMenu;
  late bool _isLabelSubMenuDisplayed;
  SubMenu? _selectedSubMenu;

  @override
  void initState() {
    super.initState();

    _isLabelMainMenuDisplayed = false;
    _tabControllerMainMenu = TabController(
      initialIndex: 0,
      vsync: this,
      length: widget.mainMenus.length,
      animationDuration: Duration.zero,
    );
    _selectedMainMenu = widget.mainMenus[0];

    _isLabelSubMenuDisplayed = false;
    _tabControllerSubMenu = TabController(
      vsync: this,
      length: 0,
      animationDuration: Duration.zero,
    );
  }

  @override
  void dispose() {
    _tabControllerMainMenu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mainMenu = RotatedBox(
      quarterTurns: 1,
      child: TabBar(
        onTap: (index) {
          setState(() {
            _selectedMainMenu = widget.mainMenus[index];
            if (_selectedMainMenu.subMenus != null) {
              _tabControllerSubMenu = TabController(
                initialIndex: 0,
                vsync: this,
                length: _selectedMainMenu.subMenus!.length,
                animationDuration: Duration.zero,
              );
              _selectedSubMenu = _selectedMainMenu.subMenus![0];
            }
          });
        },
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        labelPadding: const EdgeInsets.all(15),
        controller: _tabControllerMainMenu,
        dividerColor: Colors.transparent,
        tabs: widget.mainMenus
            .map((e) => RotatedBox(
                  quarterTurns: 4,
                  child: Tab(
                    height: 24,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (e.icon != null)
                          RotatedBox(
                            quarterTurns: 3,
                            child: e.icon,
                          ),
                        if (e.icon != null) const SizedBox(width: 7.5),
                        _isLabelMainMenuDisplayed ||
                                e.icon == null ||
                                e == _selectedMainMenu
                            ? Text(e.text)
                            : const Text(''),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );

    var subMenu = _selectedMainMenu.subMenus == null
        ? const Text('')
        : TabBar(
            onTap: (index) {
              setState(() {
                _selectedSubMenu = _selectedMainMenu.subMenus![index];
              });
            },
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            labelPadding: const EdgeInsets.all(15),
            controller: _tabControllerSubMenu,
            dividerColor: Colors.transparent,
            tabs: _selectedMainMenu.subMenus!
                .map(
                  (e) => Tab(
                    height: 24,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (e.icon != null) e.icon!,
                        if (e.icon != null) const SizedBox(width: 7.5),
                        _isLabelSubMenuDisplayed ||
                                e.icon == null ||
                                e == _selectedSubMenu
                            ? Text(e.text)
                            : const Text(''),
                      ],
                    ),
                  ),
                )
                .toList(),
          );
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Row(
          children: [
            Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => widget.appIconOnTap.call(),
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          height: 24,
                          width: 24,
                          child: widget.appIcon ?? const Icon(Icons.apps_sharp),
                        ),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: Text(widget.appName),
                    ),
                    const SizedBox(
                      height: 7.5,
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  width: 30,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: mainMenu,
                ),
                Container(
                  height: 1,
                  width: 30,
                  color: Colors.grey.shade300,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_isLabelMainMenuDisplayed) {
                        _isLabelMainMenuDisplayed = false;
                      } else {
                        _isLabelMainMenuDisplayed = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      _isLabelMainMenuDisplayed
                          ? Icons.unfold_less
                          : Icons.unfold_more,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 15 + 15 + 24,
                    child: Row(
                      children: [
                        Text(
                          widget.userInfo,
                        ),
                        const SizedBox(
                          width: 7.5,
                        ),
                        if (_selectedMainMenu.subMenus != null)
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        if (_selectedMainMenu.subMenus != null)
                          Expanded(
                            child: subMenu,
                          ),
                        if (_selectedMainMenu.subMenus != null)
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        if (_selectedMainMenu.subMenus != null)
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_isLabelSubMenuDisplayed) {
                                  _isLabelSubMenuDisplayed = false;
                                } else {
                                  _isLabelSubMenuDisplayed = true;
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  _isLabelSubMenuDisplayed
                                      ? Icons.unfold_less
                                      : Icons.unfold_more,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _selectedMainMenu.subMenus == null
                          ? _tabControllerMainMenu
                          : _tabControllerSubMenu,
                      children: _selectedMainMenu.subMenus == null
                          ? widget.mainMenus.map(
                              (e) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 0,
                                        margin: const EdgeInsets.all(0),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: e.content ?? const Text(''),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList()
                          : _selectedMainMenu.subMenus!.map(
                              (e) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 0,
                                        margin: const EdgeInsets.all(0),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: e.content ?? const Text(''),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainMenu {
  const MainMenu({
    this.icon,
    required this.text,
    this.content,
    this.subMenus,
  });

  final Widget? icon;
  final String text;
  final Widget? content;
  final List<SubMenu>? subMenus;
}

class SubMenu {
  const SubMenu({
    this.icon,
    required this.text,
    this.content,
  });

  final Widget? icon;
  final String text;
  final Widget? content;
}
