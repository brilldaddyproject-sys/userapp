

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/basewidget/custom_app_bar_widget.dart';

class DisclaimerScreenView extends StatefulWidget {

  String pdfUrl = "";

  DisclaimerScreenView(this.pdfUrl, {super.key});

  @override
  State<DisclaimerScreenView> createState() => _DisclaimerScreenViewState();
}

class _DisclaimerScreenViewState extends State<DisclaimerScreenView> {

  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    String urlToLoad;

    // Use Google Docs viewer for better cross-platform PDF support
    if (widget.pdfUrl.endsWith(".pdf")) {
      urlToLoad = "https://docs.google.com/gview?embedded=true&url=${widget.pdfUrl}";
    } else {
      urlToLoad = widget.pdfUrl;
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => setState(() => _isLoading = true),
          onPageFinished: (url) => setState(() => _isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(urlToLoad));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: "Disclaimer"),
          SizedBox(height: 10,),
          Expanded(child: WebViewWidget(controller: _controller)),
        ],
      ),
    );
  }
}
