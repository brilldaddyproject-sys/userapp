import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  Future<void> _retry(BuildContext context) async {
    final result = await Connectivity().checkConnectivity();

    if (result != ConnectivityResult.none) {
      Navigator.of(context).pop(); // Back to app
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Still no internet connection"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Close app on back press
  Future<bool> _onWillPop() async {
    if (Platform.isAndroid) {
      SystemNavigator.pop(); // Closes the app
    } else if (Platform.isIOS) {
      exit(0); // Apple discourages this, but works if required
    }
    return false; // Prevent navigation
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off_rounded,
                    size: 100,
                    color: Colors.grey.shade400,
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "No Internet Connection",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Please check your network settings and try again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () => _retry(context),
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      label: const Text(
                        "Retry",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
