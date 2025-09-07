import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import './app_theme.dart';
import './components/game_settings.dart';
import './components/global_settings.dart';
import './components/connected_devices.dart';
import './components/media_controls.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tailwind_ui/flutter_tailwind_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LEDswarm',
      theme: AppThemes.lightTheme, // Default light theme
      darkTheme: AppThemes.oledDarkTheme,
      themeMode: ThemeMode.system, // Follow system theme
      home: const MyHomePage(title: 'LEDswarm'),
      debugShowCheckedModeBanner: false, // Disable debug mode flag
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 20,
      height: 100,
      child: Column(children: [Container(height: 32.0, child: SingleChoice())]),
    );
  }
}

enum Calendar { day, week, month, year }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
          value: Calendar.day,
          label: Text('Play'),
          icon: Icon(Icons.play_arrow),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.week,
          label: Text('Pause'),
          icon: Icon(Icons.pause),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.month,
          label: Text('Stop'),
          icon: Icon(Icons.stop),
        ),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (Set<Calendar> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          calendarView = newSelection.first;
        });
      },
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedTab = 0;

  // Create a PageController to manage the PageView
  final PageController _pageController = PageController();

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  void _incrementCounter() async {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });

    // Vibrate shortly to provide user feedback
    if (await Vibration.hasCustomVibrationsSupport()) {
      // Different lengths (intensities) should correspond to their actions:
      //
      // - 10ms: ultra-short burst (for granular value changes) (below this value, intensities will differ due to alignment
      //         issues relating to the phase of the vibrator, and it __will__ feel inconsistent)
      // - 20ms: short burst (button press feedback, for example game control play/pause/stop)
      // - 40ms: burst (warning indication)
      // - 40ms, then 120ms silence, then 40ms: double burst (error indication)
      Vibration.vibrate(duration: 13);
      /*await Future.delayed(Duration(milliseconds: 120));
      Vibration.vibrate(duration: 40);*/
    } else {
      Vibration.vibrate();
    }
  }

  void _startGame() async {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });

    // Vibrate shortly to provide user feedback
    if (await Vibration.hasCustomVibrationsSupport()) {
      // Different lengths (intensities) should correspond to their actions:
      //
      // - 10ms: ultra-short burst (for granular value changes) (below this value, intensities will differ due to alignment
      //         issues relating to the phase of the vibrator, and it __will__ feel inconsistent)
      // - 20ms: short burst (button press feedback, for example game control play/pause/stop)
      // - 40ms: burst (warning indication)
      // - 40ms, then 120ms silence, then 40ms: double burst (error indication)
      Vibration.vibrate(duration: 13);
      /*await Future.delayed(Duration(milliseconds: 120));
      Vibration.vibrate(duration: 40);*/
    } else {
      Vibration.vibrate();
    }
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    const TextStyle optionStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );
    const List<Widget> _widgetOptions = <Widget>[
      Text('Index 0: Game', style: optionStyle),
      Text('Index 1: Controllers', style: optionStyle),
      Text('Index 2: Presets', style: optionStyle),
      Text('Index 3: Settings', style: optionStyle),
    ];

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        ),*/
      /*bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: 'Game'),
          BottomNavigationBarItem(
            icon: Icon(Icons.cell_tower),
            label: 'Devices',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.monitor), label: 'Monitor'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        showUnselectedLabels: true,
        currentIndex: _selectedTab,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        iconSize: 24,
        onTap: _onBottomNavItemTapped,
        ),*/
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
*/
            /*SpinKitPulse(
              color: Colors.white,
              size: 50.0,
            ),*/
            Container(
              width: screenWidth,
              height: screenHeight,
              child: ListView(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 64.0,
                  right: 8.0,
                  bottom: 8.0,
                ),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: 20.0,
                      top: 0.0,
                      right: 20.0,
                      bottom: 10.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Global settings',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: const GlobalSettings(),
                    margin: EdgeInsets.all(12.0),
                  ),

                  Container(
                    margin: EdgeInsets.only(
                      left: 20.0,
                      top: 32.0,
                      right: 20.0,
                      bottom: 10.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Game settings',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: const GameSettings(),
                    margin: EdgeInsets.all(12.0),
                  ),

                  /*Card(child: _SampleCard(cardName: 'Elevated Card')),

                  AnimatedMediaControl(),*/
                  Container(
                    margin: EdgeInsets.only(
                      left: 20.0,
                      top: 32.0,
                      right: 20.0,
                      bottom: 10.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Connected devices',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: const ConnectedDevices(),
                    margin: EdgeInsets.all(12.0),
                  ),

                  /*Text("Upgrading hyperluminal drive ..."),*/
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
