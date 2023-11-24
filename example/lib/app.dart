import 'package:flutter/cupertino.dart';
import 'package:flutter_desktop_cupertino/dsk_widgets.dart';
import 'layout.dart';

// Main application widget
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

// Main application state
class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const DSKCupertinoApp(
      defaultAppearance: "system", // light, dark, system
      child: Layout(),
    );
  }
}
