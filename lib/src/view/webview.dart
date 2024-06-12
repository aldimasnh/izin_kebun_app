import 'package:flutter/material.dart';
import 'package:izin_kebun_app/helpers/navigator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewApp> {
  final NavigationService _navigationService = NavigationService.instance;
  late final WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..addJavaScriptChannel("SnackBar", onMessageReceived: (message) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message.message)));
      })
      ..loadRequest(
        Uri.parse('https://izin-kebun.srs-ssms.com'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        _navigationService.showLoader();
        Future.delayed(const Duration(milliseconds: 500), () {
          _navigationService.hideLoader();
          _navigationService.navigate('/login');
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'WebView - Izin Kebun App',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF047857),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              color: Colors.white,
              onPressed: () {
                _navigationService.showLoader();
                Future.delayed(const Duration(milliseconds: 500), () {
                  _navigationService.hideLoader();
                  _navigationService.navigate('/login');
                });
              },
            ),
            actions: [
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      if (await controller.canGoBack()) {
                        await controller.goBack();
                      } else {
                        messenger.showSnackBar(
                          const SnackBar(
                              duration: Duration(milliseconds: 200),
                              content: Text(
                                'Can\'t go back',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        );
                        return;
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      if (await controller.canGoForward()) {
                        await controller.goForward();
                      } else {
                        messenger.showSnackBar(
                          const SnackBar(
                              duration: Duration(milliseconds: 200),
                              content: Text(
                                'No forward history item',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        );
                        return;
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.replay),
                    color: Colors.white,
                    onPressed: () {
                      controller.reload();
                    },
                  ),
                ],
              )
            ]),
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            loadingPercentage < 100
                ? LinearProgressIndicator(
                    color: const Color(0xFF10b981),
                    value: loadingPercentage / 100.0,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
