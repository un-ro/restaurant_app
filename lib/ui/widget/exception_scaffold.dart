import 'package:flutter/material.dart';
import 'package:restaurant_app/data/provider/repository_provider.dart';
import 'package:restaurant_app/ui/widget/component.dart';

import 'exception_card.dart';

class ExceptionScaffold extends StatelessWidget {
  final APIState state;
  final String? message;
  const ExceptionScaffold({
    Key? key,
    required this.state,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state == APIState.LOADING) {
      return Scaffold(
        appBar: defaultAppBar,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state == APIState.ERROR) {
      return Scaffold(
        appBar: defaultAppBar,
        body: Center(
          child: ExceptionCard(
            assetPath: 'assets/lottie/error-cone.json',
            message: message ?? '',
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: defaultAppBar,
        body: Container(),
      );
    }
  }
}
