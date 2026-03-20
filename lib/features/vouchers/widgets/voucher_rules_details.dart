import 'package:flutter/material.dart';

import '../../../common/basewidget/custom_app_bar_widget.dart';

class VoucherRulesDetails extends StatelessWidget {
  String label;

  VoucherRulesDetails(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: label,
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Image.network("https://brilldaddy.com/storage/app/public/vouchers/voucherwinnertoday.jpeg"),
            SizedBox(height: 20,),
            /// Title
            Text(
              "Win Free Gold Coins!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "We’re giving our lovely customers a chance to win a FREE GOLD COIN!\n"
                  "No entry fee • No payment required",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),

            /// How it works
            Text(
              "How it works:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletText("Visit our Website or Mobile App"),
            BulletText("Get your free voucher"),
            BulletText("Register with your mobile number or email address"),
            BulletText("Click the Claim Now button for a free gold coin"),
            BulletText("Pick any entry of your choice (example: 5, 28, 72)"),
            BulletText("Free voucher allows only one entry per user"),
            BulletText(
                "With paid vouchers, you can enter multiple times using your favourite entry numbers"),
            BulletText(
                "If your chosen entry is the single lowest unique number, you become the lucky winner"),
            BulletText("Repeated numbers will be disqualified"),

            SizedBox(height: 16),

            /// Winner section
            Text(
              "Winner Announcement:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletText(
                "Winner will be announced on our Website, Mobile App, and social media platforms"),
            BulletText(
                "You will also receive a notification on the specified result date"),
            BulletText(
                "Once announced, we will contact the winner to collect address and delivery details"),
            BulletText(
                "The Gold Coin will be delivered FREE to the winner’s doorstep"),

            SizedBox(height: 16),

            /// Extra info
            Text(
              "Additional Benefits:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletText("Paid vouchers can also be purchased"),
            BulletText(
                "Voucher amounts can be redeemed on our brand products"),
            BulletText("Get products absolutely free"),
            BulletText("Participate in our daily events"),

            SizedBox(height: 20),

            Center(
              child: Text(
                "SHINE BRILLIANTLY 😍",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      )
    ,
    );
  }


}

class BulletText extends StatelessWidget {
  final String text;

  const BulletText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• "),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
