import 'dart:developer';

import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with WidgetsBindingObserver {
  //variable string
  String _appLifeCycle = 'App is in the foreground';

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
    super.didChangeAppLifecycleState(state);

    setState(() {
      switch (state) {
        case AppLifecycleState.paused:
          _appLifeCycle = 'App is paused';
          log('app is paused: $_appLifeCycle');
          break;

        case AppLifecycleState.hidden:
          _appLifeCycle = 'App is hidden';
          log('app is hidden: $_appLifeCycle');
          break;

        case AppLifecycleState.detached:
          _appLifeCycle = 'App is detached';
          log('app is detached: $_appLifeCycle');
          break;

        case AppLifecycleState.resumed:
          _appLifeCycle = 'App is resumed';
          log('app is resumed: $_appLifeCycle');
          break;

        case AppLifecycleState.inactive:
          _appLifeCycle = 'App is inactive';
          log('app is inactive: $_appLifeCycle');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello Screen'),
      ),
    );
  }
}
