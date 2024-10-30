import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';

import '../themes/colors.dart';

class Loading {
  static OverlayEntry? _overlay;
  static __LoadingState? _loading;

  static void show() {
    if (_overlay != null) {
      return;
    }
    _loading = __LoadingState();
    _overlay = OverlayEntry(builder: (BuildContext context) => _loading!);
    Navigator.of(NavigationService.context).overlay!.insert(_overlay!);
  }

  static void hide([void Function()? completion]) {
    try {
      _overlay?.remove();
      _overlay = null;
      _loading = null;
      if (completion != null) {
        completion();
      }
    } catch (error) {
      debugPrint('$error');
    }
  }
}

class __LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withAlpha(5),
      child: const Center(
        child: SpinKitPumpingHeart(
          color: AppColors.red,
        ),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState>? _currentState;

  static set currentState(GlobalKey<NavigatorState> state) {
    _currentState = state;
  }

  static NavigatorState get _navState =>
      GetIt.instance.get<GlobalKey<NavigatorState>>().currentState!;

  static BuildContext get context => _navState.context;
}
