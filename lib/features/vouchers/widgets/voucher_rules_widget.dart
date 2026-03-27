

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/widgets/language/voucher_rules_bangala.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/widgets/language/voucher_rules_hindi.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/widgets/language/voucher_rules_odia.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/widgets/language/voucher_rules_punjabi.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/widgets/language/voucher_rules_tamil.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/widgets/language/voucher_rules_telgu.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/widgets/voucher_rules_details.dart';

import 'language/voucher_rules_gujarti.dart';
import 'language/voucher_rules_kannada.dart';
import 'language/voucher_rules_malayalam.dart';
import 'language/voucher_rules_marati.dart';

class VoucherRulesWidget extends StatelessWidget {
  const VoucherRulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showLanguageBottomSheet(context);
      },
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4CAF50), // Light Green
              Color(0xFF1B8E3F), // Dark Green
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background Wavy Shapes (custom or png)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.25,
                child: Image.asset(
                  'assets/images/wave-bg.png', // Put a curved wave PNG here
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Sparkle icons
            Positioned(top: 15, left: 80, child: _sparkle()),
            Positioned(top: 35, right: 110, child: _sparkle(size: 8)),
            Positioned(bottom: 20, right: 40, child: _sparkle(size: 10)),

            // Main content
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Left Section
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.card_giftcard,
                            color: Colors.green,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Vouchers",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Right Section
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        showLanguageBottomSheet(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "How it works",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(width: 8),

                          Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
          ],
        ),
      ),
    );
  }

  Widget _sparkle({double size = 12}) {
    return Icon(
      Icons.star,
      size: size,
      color: Colors.white.withOpacity(0.4),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Choose Language",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Language Buttons Grid
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3.2,
                children: [
                  _languageButton(context, "English"),
                  _languageButton(context, "தமிழ்"),
                  _languageButton(context, "हिन्दी"),
                  _languageButton(context, "বাংলা"),
                  _languageButton(context, "ਪੰਜਾਬੀ"),
                  _languageButton(context, "ગુજરાતી"),
                  _languageButton(context, "ଓଡ଼ିଆ"),
                  _languageButton(context, "తెలుగు"),
                  _languageButton(context, "मराठी"),
                  _languageButton(context, "മലയാളം"),
                  _languageButton(context, "ಕನ್ನಡ"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Custom Language Button Widget
  Widget _languageButton(BuildContext context, String label) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pop(context);
        if(label == "English") {
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              VoucherRulesDetails(label)));
        }else if(label == "हिन्दी"){
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              VoucherRulesHindi()));
        }else if(label == "தமிழ்"){
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              VoucherRulesTamil()));
        }else if(label == "বাংলা"){
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              VoucherRulesBangala()));
        }else if(label == "ਪੰਜਾਬੀ"){
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              VoucherRulesPunjabi()));
        }else if(label == "ગુજરાતી"){
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              VoucherRulesGujarti()));
        }else if(label == "ଓଡ଼ିଆ"){
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              VoucherRulesOdia()));
        }else if(label == "తెలుగు"){
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              VoucherRulesTelgu()));
        }else if(label == "मराठी"){
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              VoucherRulesMarati()));
        }else if(label == "മലയാളം"){
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              VoucherRulesMalayalam()));
        }else if(label == "ಕನ್ನಡ"){
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              VoucherRulesKannada()));
        }
      },
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
