import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;
  bool isLoading = false;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  navigate(String routeName /* , {Map<String, dynamic>? arguments} */) {
    return navigationKey.currentState!
        .pushNamed(routeName /* , arguments: arguments */);
  }

  goBack() {
    return navigationKey.currentState!.pop();
  }

  showLoader() {
    isLoading = true;
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: navigationKey.currentContext!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: const Color(0xFF34d399),
                size: 50,
              ),
            );
          },
        );
      },
    );
  }

  hideLoader() {
    if (isLoading) {
      isLoading = false;
      if (navigationKey.currentState!.canPop()) {
        navigationKey.currentState!.pop();
      }
    }
  }
}
