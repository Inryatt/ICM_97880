import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

bool librarySortBool = false;
bool libraryDisplayBool = false;

const Color tachiColor = Color.fromARGB(255, 32, 31, 34);
const Color tachiColorLighter = Color.fromARGB(255, 40, 39, 49);
const Color tachiColorLighterest = Color.fromARGB(255, 40, 39, 49);
const Color tachiLabel = Color.fromARGB(255, 138, 195, 209);
const Color tachUnselectedLabel = Color.fromARGB(255, 212, 212, 212);
const TextStyle tachiTextRegular =
    TextStyle(color: Color.fromARGB(255, 235, 235, 235));
const TextStyle tachiTextHighlighted = TextStyle(
    color: Color.fromARGB(255, 179, 214, 255), fontWeight: FontWeight.bold);

enum librarySortDisplayModeEnum { compact, comf, list }
librarySortDisplayModeEnum? _librarySortDisplay =
    librarySortDisplayModeEnum.comf;

Map<String, Widget> comic_status = {
  'Ongoing': Row(children: const [
    Icon(
      Icons.schedule,
      color: Color.fromARGB(255, 202, 202, 202),
    ),
    Text(' Ongoing')
  ]),
  'Completed':
      Row(children: [const Icon(Icons.check_sharp), const Text('Completed')])
};

List<Map<String, dynamic>> comics = [
  {
    'title': "Solo Leveling",
    'cover':
        'https://static.wikia.nocookie.net/allthetropes/images/0/07/Solo_Leveling_Webtoon_cover.png/revision/latest?cb=20190707213443',
    'chapters': 94,
    'author': "none",
    'status': comic_status['Ongoing'],
    'source': 'none'
  },
  {
    'title': "Stand Still, Stay Silent",
    'cover':
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1540245864l/23519146._SX318_.jpg',
    'chapters': 94,
    'author': "none",
    'status': comic_status['Ongoing'],
    'source': 'HiveWorks'
  },
  {
    'title': "Overgeared",
    'cover':
        'https://external-preview.redd.it/5H2yIyB9JM2iIS1SzFkL7jeykqLZeS9_tkPzc780bSA.jpg?auto=webp&s=a399f80caa1087b14c28a3848fdc68fd2ca2853f',
    'chapters': 94,
    'author': "Wei Zhiba",
    'status': comic_status['Ongoing'],
    'source': 'ReadM',
  },
  {
    'title': "Buffy The Vampire Slayer",
    'cover':
        'https://static.wikia.nocookie.net/buffy/images/2/22/Buffy-25-00a.jpg/revision/latest?cb=20210401015035',
    'chapters': 94,
    'author': "BOOM",
    'status': comic_status['Ongoing'],
    'source': 'notMangadex'
  }
];

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

void _onTopBarItemPressed() {}

List<TabBar> tabBar = <TabBar>[
  const TabBar(
    unselectedLabelColor: tachUnselectedLabel,
    labelColor: tachiLabel,
    indicatorColor: tachiLabel,
    labelStyle: tachiTextHighlighted,
    unselectedLabelStyle: tachiTextRegular,
    indicatorSize: TabBarIndicatorSize.label,
    tabs: <Widget>[
      Tab(
        text: 'All',
      ),
      Tab(
        text: 'Favourites',
      ),
      Tab(
        text: 'Action',
      ),
    ],
  ),
  const TabBar(
    tabs: <Widget>[],
  ),
  const TabBar(
    tabs: <Widget>[],
  ),
  const TabBar(
    tabs: <Widget>[
      Tab(
        icon: Icon(Icons.cloud_outlined),
      ),
      Tab(
        icon: Icon(Icons.beach_access_sharp),
      ),
      Tab(
        icon: Icon(Icons.brightness_5_sharp),
      ),
    ],
  ),
  const TabBar(
    tabs: <Widget>[],
  ),
];

TextStyle libraryTextStyle = TextStyle(
    color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 16);

Widget libraryComic(context, idx) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OpenComic(idx: idx)),
      );
    },
    child: Stack(
      children: <Widget>[
        SizedBox(
          height: 400,
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(comics[idx]["cover"]),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: 184,
            height: 100,
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  const Color.fromARGB(96, 0, 0, 0),
                  const Color.fromARGB(146, 0, 0, 0)
                ],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 5, left: 5),
              alignment: Alignment.bottomLeft,
              child: Text(
                comics[idx]["title"],
                style: libraryTextStyle,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget librarySection(BuildContext context) {
  return GridView.count(
      childAspectRatio: 0.5,
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(8),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: List<Widget>.generate(
          comics.length, (index) => libraryComic(context, index)));
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  String _selectedTitle = 'Library';
  bool isChecked = false;
  static int _selectedIndexLibrarySort = 0;

  static Widget librarySortFilterWidget = ListView(
    shrinkWrap: true,
    children: [
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: librarySortBool,
              onChanged: (bool? newValue) {
                setState(() {
                  librarySortBool = newValue!;
                });
              },
            ),
            const Text(
              'Downloaded',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        );
      }),
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: librarySortBool,
              onChanged: (bool? newValue) {
                setState(() {
                  librarySortBool = newValue!;
                });
              },
            ),
            const Text(
              'Unread',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        );
      }),
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: librarySortBool,
              onChanged: (bool? newValue) {
                setState(() {
                  librarySortBool = newValue!;
                });
              },
            ),
            const Text(
              'Completed',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        );
      }),
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: librarySortBool,
              onChanged: (bool? newValue) {
                setState(() {
                  librarySortBool = newValue!;
                });
              },
            ),
            const Text(
              'Tracked',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        );
      }),
    ],
  );

  static Widget librarySortSortWidget = ListView(
    shrinkWrap: true,
    children: [
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Container(
          child: Material(
            child: ListView(
              shrinkWrap: true,
              children: const [
                ListTile(
                  title: Text(
                    'Alphabetically',
                    style: tachiTextRegular,
                  ),
                  tileColor: tachiColorLighter,
                  leading: SizedBox(
                    height: 24,
                    width: 24,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Last read',
                    style: tachiTextRegular,
                  ),
                  tileColor: tachiColorLighter,
                  leading: SizedBox(
                    height: 24,
                    width: 24,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Last checked',
                    style: tachiTextRegular,
                  ),
                  tileColor: tachiColorLighter,
                  leading: Icon(
                    Icons.arrow_upward_outlined,
                    color: tachiLabel,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Unread',
                    style: tachiTextRegular,
                  ),
                  tileColor: tachiColorLighter,
                  leading: SizedBox(
                    height: 24,
                    width: 24,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Total chapters',
                    style: tachiTextRegular,
                  ),
                  tileColor: tachiColorLighter,
                  leading: SizedBox(
                    height: 24,
                    width: 24,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Latest chapter',
                    style: tachiTextRegular,
                  ),
                  tileColor: tachiColorLighter,
                  leading: SizedBox(
                    height: 24,
                    width: 24,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Date fetched',
                    style: tachiTextRegular,
                  ),
                  tileColor: tachiColorLighter,
                  leading: SizedBox(
                    height: 24,
                    width: 24,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Date added',
                    style: tachiTextRegular,
                  ),
                  tileColor: tachiColorLighter,
                  leading: SizedBox(
                    height: 24,
                    width: 24,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    ],
  );

  static Widget librarySortDisplayWidget =
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return ListView(
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      children: [
        const Text(
          'Display mode',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: tachUnselectedLabel, fontWeight: FontWeight.bold),
        ),
        RadioListTile<librarySortDisplayModeEnum>(
          title: const Text(
            "Compact Grid",
            style: tachiTextRegular,
          ),
          value: librarySortDisplayModeEnum.compact,
          groupValue: _librarySortDisplay,
          onChanged: (librarySortDisplayModeEnum? value) {
            setState(() {
              _librarySortDisplay = value;
            });
          },
        ),
        RadioListTile<librarySortDisplayModeEnum>(
          title: const Text(
            "Comfortable grid",
            style: tachiTextRegular,
          ),
          value: librarySortDisplayModeEnum.comf,
          groupValue: _librarySortDisplay,
          onChanged: (librarySortDisplayModeEnum? value) {
            setState(() {
              _librarySortDisplay = value;
            });
          },
        ),
        RadioListTile<librarySortDisplayModeEnum>(
          title: const Text(
            "List",
            style: tachiTextRegular,
          ),
          value: librarySortDisplayModeEnum.list,
          groupValue: _librarySortDisplay,
          onChanged: (librarySortDisplayModeEnum? value) {
            setState(() {
              _librarySortDisplay = value;
            });
          },
        ),
        const Text(
          'Badges',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Row(children: [
            Checkbox(
              value: libraryDisplayBool,
              onChanged: (bool? newValue) {
                setState(() {
                  libraryDisplayBool = newValue!;
                });
              },
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Text("Downloaded chapters", style: tachiTextRegular),
            )
          ]);
        }),
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Row(children: [
            Checkbox(
              value: libraryDisplayBool,
              onChanged: (bool? newValue) {
                setState(() {
                  libraryDisplayBool = newValue!;
                });
              },
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Text("Unread chapters", style: tachiTextRegular),
            )
          ]);
        }),
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Row(children: [
            Checkbox(
              value: libraryDisplayBool,
              onChanged: (bool? newValue) {
                setState(() {
                  libraryDisplayBool = newValue!;
                });
              },
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Text("Local manga", style: tachiTextRegular),
            )
          ]);
        }),
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Row(children: [
            Checkbox(
              value: libraryDisplayBool,
              onChanged: (bool? newValue) {
                setState(() {
                  libraryDisplayBool = newValue!;
                });
              },
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Text("Language", style: tachiTextRegular),
            )
          ]);
        }),
        const Text(
          'Tabs',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Row(children: [
            Checkbox(
              value: libraryDisplayBool,
              onChanged: (bool? newValue) {
                setState(() {
                  libraryDisplayBool = newValue!;
                });
              },
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Text("Show category tabs", style: tachiTextRegular),
            )
          ]);
        }),
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Row(children: [
            Checkbox(
              value: libraryDisplayBool,
              onChanged: (bool? newValue) {
                setState(() {
                  libraryDisplayBool = newValue!;
                });
              },
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child:
                  const Text("Show number of items", style: tachiTextRegular),
            )
          ]);
        }),
      ],
    );
  });

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions(context) {
    return <Widget>[
      ListView(
        children: [librarySection(context)],
      ),
      const Text(
        'Index 1: Updates',
        style: optionStyle,
      ),
      const Text(
        'Index 2: History',
        style: optionStyle,
      ),
      const Text(
        'Index 3: Browse',
        style: optionStyle,
      ),
      const Text(
        'Index 4: More',
        style: optionStyle,
      )
    ];
  }

  static final List<Widget> _librarySortwidgetOptions = <Widget>[
    Container(
      color: tachiColorLighter,
      child: librarySortFilterWidget,
    ),
    Container(
      color: tachiColorLighter,
      child: librarySortSortWidget,
    ),
    Container(
      color: tachiColorLighter,
      child: librarySortDisplayWidget,
    )
  ];
  static final List<BottomNavigationBarItem> _botBarItems =
      <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.collections_bookmark_outlined),
      activeIcon: Icon(Icons.collections_bookmark),
      label: 'Library',
      backgroundColor: Colors.blue,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.new_releases_outlined),
      activeIcon: Icon(Icons.new_releases),
      label: 'Updates',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.history),
      activeIcon: Icon(Icons.history),
      label: 'History',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
      label: 'Browse',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.more_horiz),
      label: 'More',
    ),
  ];

  void _onLibrarySortTap(int index) {
    setState(() {
      _selectedIndexLibrarySort = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _selectedTitle = _botBarItems[_selectedIndex].label.toString();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _libraryScrollTabWidgetOptions = <Widget>[
      const Text(
        'Index 1: Updates',
        style: optionStyle,
      ),
      const Text(
        'Index 2: History',
        style: optionStyle,
      ),
      const Text(
        'Index 3: Browse',
        style: optionStyle,
      )
    ];
    final List<List<Widget>> _topBarItems = <List<Widget>>[
      [
        const IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Search',
          onPressed: _onTopBarItemPressed,
        ),
        IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Sort',
            onPressed: () {
              showModalBottomSheet<void>(
                backgroundColor: tachiColorLighter,
                isDismissible: true,
                isScrollControlled: true,
                enableDrag: true,
                context: context,
                builder: (BuildContext context) {
                  return DraggableScrollableSheet(
                      initialChildSize: 0.5, // half screen on load
                      maxChildSize: 1, // full screen on scroll
                      minChildSize: 0.25,
                      snapSizes: const [0.5],
                      expand: false,
                      snap: true,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return ListView(
                          controller: scrollController,
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: 1000,
                              color: tachiColorLighter,
                              alignment: Alignment.topCenter,
                              child: DefaultTabController(
                                initialIndex: 0,
                                length: 3,
                                child: Scaffold(
                                  //color: tachiColorLighter,
                                  appBar: AppBar(
                                    toolbarHeight: 0,
                                    automaticallyImplyLeading: false,
                                    backgroundColor: tachiColorLighter,
                                    bottom: const TabBar(
                                      labelStyle: tachiTextHighlighted,
                                      unselectedLabelStyle: tachiTextRegular,
                                      unselectedLabelColor: tachUnselectedLabel,
                                      labelColor: tachiLabel,
                                      indicatorColor: tachiLabel,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      tabs: [
                                        Tab(
                                          text: 'Filter',
                                        ),
                                        Tab(
                                          text: 'Sort',
                                        ),
                                        Tab(
                                          text: 'Display',
                                        ),
                                      ],
                                    ),
                                  ),
                                  body: TabBarView(
                                    children: _librarySortwidgetOptions,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
              );
            }),
        const IconButton(
          icon: Icon(Icons.replay_outlined),
          tooltip: 'Reload',
          onPressed: _onTopBarItemPressed,
        ),
      ],
      [
        const IconButton(
          icon: Icon(Icons.add_alert),
          tooltip: 'Search',
          onPressed: _onTopBarItemPressed,
        ),
      ],
      [
        const IconButton(
          icon: Icon(Icons.add_alert),
          tooltip: 'Search',
          onPressed: _onTopBarItemPressed,
        ),
        const IconButton(
          icon: Icon(Icons.add_alert),
          tooltip: 'Search',
          onPressed: _onTopBarItemPressed,
        ),
      ],
      [
        const IconButton(
          icon: Icon(Icons.add_alert),
          tooltip: 'Search',
          onPressed: _onTopBarItemPressed,
        ),
        const IconButton(
          icon: Icon(Icons.add_alert),
          tooltip: 'Search',
          onPressed: _onTopBarItemPressed,
        ),
      ],
      []
    ];
    return DefaultTabController(
      length: tabBar[_selectedIndex].tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: tachiColor,
        appBar: AppBar(
            primary: true,
            backgroundColor: tachiColor,
            title: Text(_selectedTitle),
            actions: _topBarItems[_selectedIndex],
            bottom: tabBar[_selectedIndex].tabs.length > 0
                ? tabBar[_selectedIndex]
                : null),
        body: Center(
          child: _widgetOptions(context).elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _botBarItems,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          backgroundColor: tachiColorLighter,
          selectedItemColor: Colors.grey[100],
          unselectedItemColor: Colors.grey[500],
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class OpenComic extends StatelessWidget {
  const OpenComic({Key? key, required this.idx}) : super(key: key);

  final int idx;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tachiColor,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.download)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        body: ListView(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 30, left: 30, right: 0, bottom: 30),
                  child: SizedBox(
                    height: 200,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(comics[idx]["cover"]),
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comics[idx]['title'],
                          style: const TextStyle(
                              color: tachUnselectedLabel,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          comics[idx]['author'],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 190, 190, 190),
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            DefaultTextStyle.merge(
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 190, 190, 190),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                              child: comics[idx]['status'],
                            ),
                            const Text(" - "),
                            Text(
                              comics[idx]['source'],
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 190, 190, 190),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    )),
              ],
            ),
            DefaultTextStyle.merge(
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultTextStyle(
                      style:
                          TextStyle(color: Color.fromARGB(255, 148, 190, 230)),
                      child: Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          child: Column(children: [
                            Icon(
                              Icons.heart_broken,
                              color: Color.fromARGB(255, 148, 190, 230),
                            ),
                            Text('In library')
                          ]),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        child: Column(children: [
                          Icon(Icons.replay_outlined, color: Colors.grey),
                          Text('Tracking')
                        ]),
                      ),
                    ),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          child: Column(children: [
                            Icon(Icons.play_for_work_outlined,
                                color: Colors.grey),
                            Text('WebView')
                          ]),
                        )),
                  ],
                )),
          ],
        ));
  }
}
