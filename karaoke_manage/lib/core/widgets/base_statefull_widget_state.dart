import 'dart:async';
import 'package:flutter/material.dart';

abstract class BaseStatefulWidgetState<T extends StatefulWidget>
    extends State<T> with WidgetsBindingObserver {
  bool _isLoading = false;
  Timer? _debounceTimer;
  bool _mounted = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    debugPrint("[${T.toString()}] initState");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint("[${T.toString()}] initData()");
      initData();
    });
  }

  Widget verticalSpace(double height) {
    return SizedBox(height: height);
  }


  Widget horizontalSpace(double width) {
    return SizedBox(width: width);
  }

  /// Override để chạy logic sau khi build
  void initData() {}

  @override
  void dispose() {
    debugPrint("[${T.toString()}] dispose");
    _mounted = false;
    WidgetsBinding.instance.removeObserver(this);
    _debounceTimer?.cancel();
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("[${T.toString()}] onResume");
        onResume();
        break;
      case AppLifecycleState.paused:
        debugPrint("[${T.toString()}] onPause");
        onPause();
        break;
      case AppLifecycleState.inactive:
        debugPrint("[${T.toString()}] onInactive");
        onInactive();
        break;
      case AppLifecycleState.detached:
        debugPrint("[${T.toString()}] onDetach");
        onDetach();
        break;
      case AppLifecycleState.hidden:
        debugPrint("[${T.toString()}] onHidden");
        onHidden();
        break;
    }
  }


  void onResume() {}
  void onPause() {}
  void onInactive() {}
  void onDetach() {}
  void onHidden() {}


  void safeSetState(VoidCallback fn) {
    if (_mounted) {
      setState(fn);
    }
  }


  void debounce(VoidCallback action,
      {Duration delay = const Duration(milliseconds: 350)}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, action);
  }


  void showLoading() => safeSetState(() => _isLoading = true);
  void hideLoading() => safeSetState(() => _isLoading = false);


  void showSnack(String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  Future<void> showAlertDialog({
    required String title,
    required String content,
    String confirmButtonText = 'OK',
    VoidCallback? onConfirm,
  }) async {
    return showDialog<void>(
      context: context, barrierDismissible: false, // User must tap button!
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(confirmButtonText),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onConfirm?.call();
              },
            ),
          ],
        );
      },
    );
  }


  bool get isKeyboardVisible =>
      MediaQuery.of(context).viewInsets.bottom > 0;


  void postFrame(VoidCallback fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) => fn());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildPage(context),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
          )
      ],
    );
  }


  Widget buildPage(BuildContext context);
}
