import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });

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
