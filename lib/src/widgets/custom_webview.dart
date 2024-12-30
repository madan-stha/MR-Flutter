import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../src.dart';

class CustomWebView extends StatefulWidget {
  final String title;
  final String url;
  final bool isLogout;

  const CustomWebView({
    super.key,
    required this.title,
    required this.url,
    this.isLogout = false,
  });

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  WebViewController controller = WebViewController();

  final SharedPreferencesService sharedPref = SharedPreferencesService();

  var data;
  bool logged = false;
  String title = '';

  @override
  void initState() {
    super.initState();
    fetchRole();
    initializedWebView();
  }

  fetchRole() async {
    data = await sharedPref.getStringPref('userData');
    logged = await sharedPref.getBoolPref('logged');
  }

  initializedWebView() async {
    var token;
    token = await sharedPref.getStringPref('userData');
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..getTitle().then((value) {
        title = value ?? '';
        print('title is hehe $title');
        setState(() {});
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              progress = progress;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url)) {
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          "${widget.url}&token=${token != null ? token['accessToken'] : ''}&expiresAt=${token != null ? token['expiresAt'] : ''}",
        ),
        headers: {
          'Authorization':
              'Bearer  ${token != null ? token['accessToken'] : ''}',
        },
      );
    print(
        'lolllllll  token is ${widget.url}&token=${token != null ? token['accessToken'] : ''}&expiresAt=${token != null ? token['expiresAt'] : ''}');
  }

  @override
  Widget build(BuildContext context) {
    print('title is $title');
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        isBackButtonExist: false,
        radius: false,
        actions: [
          if (data != null && logged)
            IconButton(
              onPressed: () {
                Utility.logout();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: AppColors.white,
              ),
            ),
        ],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
