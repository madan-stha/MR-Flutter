import 'package:url_launcher/url_launcher.dart';

Future<void> launchInBrowser(String url, [String? optionalUrl]) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(
        url,
      ),
      // mode: LaunchMode.platformDefault,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
        enableDomStorage: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      ),
    );
  } else {
    await launchUrl(
      Uri.parse(
        optionalUrl ?? url,
      ),
      // mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      ),
    );
  }
}

Future<void> launchUniversalLink(String url) async {
  if (await canLaunchUrl(
    Uri.parse(
      url,
    ),
  )) {
    await launchUrl(
      Uri.parse(url),
    );
  } else {}
}
