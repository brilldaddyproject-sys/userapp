

import 'package:flutter/material.dart';

import '../../../../common/basewidget/custom_app_bar_widget.dart';

class VoucherRulesBangala extends StatelessWidget {
  const VoucherRulesBangala({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
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
              "ফ্রি গোল্ড কয়েন জেতার সুযোগ!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "আমরা আমাদের প্রিয় গ্রাহকদের জন্য একটি সুযোগ দিচ্ছি একটি বিনামূল্যে গোল্ড কয়েন জয়ের!\n"
                  "কোনো এন্ট্রি ফি বা পেমেন্টের প্রয়োজন নেই।",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),

            /// How it works
            Text(
              "কিভাবে কাজ করে:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextBengali(
                "আমাদের ওয়েবসাইট বা মোবাইল অ্যাপ পরিদর্শন করার পর আপনার ফ্রি ভাউচার সংগ্রহ করুন।"),
            BulletTextBengali(
                "আপনার মোবাইল নম্বর বা ইমেইল ঠিকানা দিয়ে রেজিস্টার করুন।"),
            BulletTextBengali(
                "একটি বিনামূল্যের গোল্ড কয়েনের জন্য ‘Claim Now’ বাটনে ক্লিক করুন।"),
            BulletTextBengali(
                "আপনার পছন্দের যেকোনো একটি সংখ্যা নির্বাচন করুন (যেমন 5, 28, বা 72)।"),
            BulletTextBengali(
                "ফ্রি ভাউচারের মাধ্যমে আপনি শুধুমাত্র একবারই এন্ট্রি দিতে পারবেন।"),
            BulletTextBengali(
                "পেইড ভাউচারের মাধ্যমে আপনি আপনার পছন্দের সংখ্যাগুলো দিয়ে একাধিকবার এন্ট্রি দিতে পারবেন।"),
            BulletTextBengali(
                "যদি আপনার নির্বাচিত সংখ্যা একক সর্বনিম্ন ইউনিক হয় (অর্থাৎ আর কেউ সেই সংখ্যা নির্বাচন করেনি), তাহলে আপনি আমাদের লাকি গোল্ড কয়েন বিজয়ী হবেন।"),
            BulletTextBengali(
                "পুনরাবৃত্ত সংখ্যাগুলোকে অযোগ্য ঘোষণা করা হবে।"),

            SizedBox(height: 16),

            /// Winner announcement
            Text(
              "বিজয়ী ঘোষণা:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextBengali(
                "বিজয়ীর ঘোষণা আমাদের ওয়েবসাইট, মোবাইল অ্যাপ এবং অন্যান্য সোশ্যাল মিডিয়া প্ল্যাটফর্মে করা হবে।"),
            BulletTextBengali(
                "নির্ধারিত ফলাফলের দিনে আপনাকে নোটিফিকেশন পাঠানো হবে।"),
            BulletTextBengali(
                "বিজয়ী ঘোষণা হওয়ার পর, আপনার ঠিকানা ও বিবরণ সংগ্রহ করতে আমরা সরাসরি আপনার সঙ্গে যোগাযোগ করব।"),
            BulletTextBengali(
                "একটি গোল্ড কয়েন সম্পূর্ণ বিনামূল্যে সরাসরি আপনার ঠিকানায় পৌঁছে দেওয়া হবে।"),

            SizedBox(height: 16),

            /// Extra benefits
            Text(
              "অতিরিক্ত সুবিধা:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextBengali("আপনি পেইড ভাউচারও কিনতে পারেন।"),
            BulletTextBengali("পণ্যগুলো সম্পূর্ণ বিনামূল্যে পান।"),
            BulletTextBengali(
                "ভাউচার মান আমাদের ব্র্যান্ডের পণ্যগুলোর জন্য ব্যবহার করা যাবে।"),
            BulletTextBengali("আমাদের দৈনিক ইভেন্টে অংশ নিন।"),

            SizedBox(height: 20),

            Center(
              child: Text(
                "চমকপ্রদভাবে ঝলমল করুন 😍",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletTextBengali extends StatelessWidget {
  final String text;

  const BulletTextBengali(this.text, {super.key});

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
