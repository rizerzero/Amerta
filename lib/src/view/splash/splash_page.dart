import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../utils/utils.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool _isLoading = false;
  bool _isError = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _initApplication();
    });
  }

  Future<void> _initApplication() async {
    try {
      setState(() => _isLoading = true);

      /// Give delayed to show splah screen
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      setState(() {
        _message = e.toString();
        _isError = true;
      });
    } finally {
      setState(() => _isLoading = false);

      if (!_isError) {
        log("good, can be navigate to main screen");
        context.goNamed(appRouteNamed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Builder(builder: (ctx) {
        if (_isError) {
          return Center(
            child: Text("Error $_message"),
          );
        }
        if (_isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        return const SizedBox();
      }),
    );
  }
}
