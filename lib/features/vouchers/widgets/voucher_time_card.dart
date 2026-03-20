

import 'dart:async';
import 'package:flutter/material.dart';

class VoucherTimerCard extends StatefulWidget {
  final String endDateString;

  const VoucherTimerCard({super.key, required this.endDateString});

  @override
  State<VoucherTimerCard> createState() => _VoucherTimerCardState();
}

class _VoucherTimerCardState extends State<VoucherTimerCard> {
  late Timer _timer;
  String remainingTime = "";

  @override
  void initState() {
    super.initState();
    _updateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateRemainingTime();
    });
  }

  void _updateRemainingTime() {
    final result = getTimeRemaining(widget.endDateString);
    setState(() {
      remainingTime = result;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String getTimeRemaining(String dateStr) {
    try {
      final endDate = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = endDate.difference(now);

      if (difference.isNegative) {
        return "Expired";
      }

      final days = difference.inDays;
      final hours = difference.inHours % 24;
      final minutes = difference.inMinutes % 60;
      final seconds = difference.inSeconds % 60;

      return "${days}d ${hours}h ${minutes}m ${seconds}s Remaining";
    } catch (e) {
      return "Invalid Date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      remainingTime,
      style: const TextStyle(
        color: Colors.green,
        fontSize: 10,
      ),
    );
  }
}
