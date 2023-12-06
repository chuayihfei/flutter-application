import 'package:flutter/widgets.dart';

class LifeCycleWatcher extends StatefulWidget {
  @override
  State<LifeCycleWatcher> createState() => LifeCycleWatcherState();
}

class LifeCycleWatcherState extends State<LifeCycleWatcher>
    with WidgetsBindingObserver {
  late AppLifecycleState lastLifeCycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      lastLifeCycleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (lastLifeCycleState == null) {
      return const Text('This widget has not observed any lifecycle changes.',
          textDirection: TextDirection.ltr);
    }
    return Text(
        'The most recent lifecycle state this widget observed was: $lastLifeCycleState.',
        textDirection: TextDirection.ltr);
  }
}
