

import 'package:flutter/material.dart';

import '../../../../common/basewidget/custom_app_bar_widget.dart';

class VoucherRulesPunjabi extends StatelessWidget {
  const VoucherRulesPunjabi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "ਪੰਜਾਬੀ",
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
              "ਮੁਫ਼ਤ ਸੋਨੇ ਦੇ ਸਿੱਕੇ ਜਿੱਤੋ!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "ਅਸੀਂ ਆਪਣੇ ਪਿਆਰੇ ਗਾਹਕਾਂ ਨੂੰ ਇੱਕ ਮੁਫ਼ਤ ਸੋਨੇ ਦਾ ਸਿੱਕਾ ਜਿੱਤਣ ਦਾ ਮੌਕਾ ਦੇ ਰਹੇ ਹਾਂ!\n"
                  "ਕਿਸੇ ਵੀ ਐਂਟਰੀ ਫੀ ਜਾਂ ਭੁਗਤਾਨ ਦੀ ਲੋੜ ਨਹੀਂ।",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),

            /// How it works
            Text(
              "ਇਹ ਕਿਵੇਂ ਕੰਮ ਕਰਦਾ ਹੈ:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextPunjabi(
                "ਸਾਡੀ ਵੈਬਸਾਈਟ ਜਾਂ ਮੋਬਾਈਲ ਐਪ 'ਤੇ ਜਾ ਕੇ ਆਪਣਾ ਮੁਫ਼ਤ ਵਾਊਚਰ ਪ੍ਰਾਪਤ ਕਰੋ।"),
            BulletTextPunjabi(
                "ਆਪਣਾ ਮੋਬਾਈਲ ਨੰਬਰ ਜਾਂ ਈਮੇਲ ਐਡਰੈੱਸ ਨਾਲ ਰਜਿਸਟਰ ਕਰੋ।"),
            BulletTextPunjabi(
                "ਮੁਫ਼ਤ ਸੋਨੇ ਦਾ ਸਿੱਕਾ ਪ੍ਰਾਪਤ ਕਰਨ ਲਈ ‘Claim Now’ ਬਟਨ 'ਤੇ ਕਲਿੱਕ ਕਰੋ।"),
            BulletTextPunjabi(
                "ਆਪਣੀ ਪਸੰਦ ਦੀ ਕੋਈ ਵੀ ਐਂਟਰੀ ਚੁਣੋ (ਜਿਵੇਂ 5, 28, ਜਾਂ 72)।"),
            BulletTextPunjabi(
                "ਮੁਫ਼ਤ ਵਾਊਚਰਾਂ ਨਾਲ ਤੁਸੀਂ ਸਿਰਫ਼ ਇੱਕ ਵਾਰੀ ਹੀ ਦਰਜ ਹੋ ਸਕਦੇ ਹੋ।"),
            BulletTextPunjabi(
                "ਭੁਗਤਾਨ ਕੀਤੇ ਵਾਊਚਰਾਂ ਨਾਲ ਤੁਸੀਂ ਆਪਣੀ ਪਸੰਦ ਦੀਆਂ ਐਂਟਰੀਆਂ ਨਾਲ ਕਈ ਵਾਰ ਦਰਜ ਹੋ ਸਕਦੇ ਹੋ।"),
            BulletTextPunjabi(
                "ਜੇ ਤੁਹਾਡੀ ਚੁਣੀ ਹੋਈ ਐਂਟਰੀ ਸਭ ਤੋਂ ਘੱਟ ਵਿਲੱਖਣ ਹੈ (ਜਿਸਨੂੰ ਹੋਰ ਕਿਸੇ ਨੇ ਨਹੀਂ ਚੁਣਿਆ), ਤਾਂ ਤੁਸੀਂ ਸਾਡੇ ਲੱਕੀ ਸੋਨੇ ਦੇ ਸਿੱਕੇ ਦੇ ਜਿੱਤੂ ਬਣ ਜਾਵੋਗੇ।"),
            BulletTextPunjabi(
                "ਦੁਹਰਾਈ ਗਈ ਸੰਖਿਆਵਾਂ ਨੂੰ ਅਯੋਗ ਘੋਸ਼ਿਤ ਕੀਤਾ ਜਾਵੇਗਾ।"),

            SizedBox(height: 16),

            /// Winner announcement
            Text(
              "ਜੇਤੂ ਦਾ ਐਲਾਨ:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextPunjabi(
                "ਜੇਤੂ ਦਾ ਐਲਾਨ ਸਾਡੀ ਵੈਬਸਾਈਟ, ਮੋਬਾਈਲ ਐਪ ਅਤੇ ਹੋਰ ਸੋਸ਼ਲ ਮੀਡੀਆ ਪਲੇਟਫਾਰਮਾਂ 'ਤੇ ਕੀਤਾ ਜਾਵੇਗਾ।"),
            BulletTextPunjabi(
                "ਨਿਰਧਾਰਿਤ ਨਤੀਜੇ ਦੀ ਤਾਰੀਖ 'ਤੇ ਤੁਹਾਨੂੰ ਨੋਟੀਫਿਕੇਸ਼ਨ ਵੀ ਮਿਲੇਗਾ।"),
            BulletTextPunjabi(
                "ਜੇਤੂ ਦਾ ਐਲਾਨ ਹੋਣ ਤੋਂ ਬਾਅਦ, ਅਸੀਂ ਤੁਹਾਡੇ ਨਾਲ ਸਿੱਧਾ ਸੰਪਰਕ ਕਰਾਂਗੇ ਤਾਂ ਜੋ ਤੁਹਾਡਾ ਪਤਾ ਅਤੇ ਵੇਰਵੇ ਇਕੱਠੇ ਕੀਤੇ ਜਾ ਸਕਣ।"),
            BulletTextPunjabi(
                "ਇੱਕ ਸੋਨੇ ਦਾ ਸਿੱਕਾ ਬਿਲਕੁਲ ਮੁਫ਼ਤ ਸਿੱਧਾ ਤੁਹਾਡੇ ਦਰਵਾਜੇ 'ਤੇ ਡਿਲੀਵਰ ਕੀਤਾ ਜਾਵੇਗਾ।"),

            SizedBox(height: 16),

            /// Extra benefits
            Text(
              "ਵਾਧੂ ਫਾਇਦੇ:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextPunjabi("ਤੁਸੀਂ ਭੁਗਤਾਨਸ਼ੁਦਾ ਵਾਊਚਰ ਵੀ ਖਰੀਦ ਸਕਦੇ ਹੋ।"),
            BulletTextPunjabi("ਉਤਪਾਦ ਇੱਕਦਮ ਮੁਫ਼ਤ ਪ੍ਰਾਪਤ ਕਰੋ।"),
            BulletTextPunjabi(
                "ਵਾਊਚਰ ਦੀ ਰਕਮ ਸਾਡੇ ਬ੍ਰਾਂਡ ਉਤਪਾਦਾਂ 'ਤੇ ਵਰਤੀ ਜਾ ਸਕਦੀ ਹੈ।"),
            BulletTextPunjabi("ਸਾਡੇ ਰੋਜ਼ਾਨਾ ਸਮਾਗਮਾਂ ਵਿੱਚ ਸ਼ਾਮਿਲ ਹੋਵੋ।"),

            SizedBox(height: 20),

            Center(
              child: Text(
                "ਚਮਕਦਾਰ ਤਰੀਕੇ ਨਾਲ ਚਮਕੋ 😍",
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

class BulletTextPunjabi extends StatelessWidget {
  final String text;

  const BulletTextPunjabi(this.text, {super.key});

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
