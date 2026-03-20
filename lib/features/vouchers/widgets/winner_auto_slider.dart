

import 'dart:async';
import 'package:flutter/material.dart';

import '../../../helper/price_converter.dart';
import '../model/voucher_winner_model.dart';

class WinnerAutoSlider extends StatefulWidget {
  final List<VoucherWinnerModel>? voucherWinnerList;

  WinnerAutoSlider({super.key, required this.voucherWinnerList});

  @override
  _WinnerAutoSliderState createState() => _WinnerAutoSliderState();
}

class _WinnerAutoSliderState extends State<WinnerAutoSlider> {
  final ScrollController _scrollController = ScrollController();
  double _position = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_scrollController.hasClients) {
        _position += 70; // 70 = container height
        if (_position >= _scrollController.position.maxScrollExtent) {
          _position = 0;
        }
        _scrollController.animateTo(
          _position,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.voucherWinnerList!.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final winner = widget.voucherWinnerList![index];
          return winner.user!=null ? Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Icon(Icons.emoji_events, color: Colors.orange, size: 20),
                const SizedBox(width: 8),

                // ✅ Text expands properly inside container
                Expanded(
                  child: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      children: [
                        TextSpan(text: " ${winner.user!.name ?? ""} won "),
                        TextSpan(
                          text: "${winner.voucher!.title} ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: "with "),
                        TextSpan(
                          text: "${PriceConverter.convertPrice(context, double.parse(winner.amount!))}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ):Container();
        },
      ),
    );
  }
}
