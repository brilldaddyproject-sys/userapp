

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/basewidget/custom_app_bar_widget.dart';

class VoucherRulesTamil extends StatelessWidget {
  const VoucherRulesTamil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "தமிழ்",
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
              "இலவச தங்க நாணயங்களை வெல்லுங்கள்!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "எங்கள் அன்பான வாடிக்கையாளர்களுக்கு இலவச தங்க நாணயம் வெல்ல ஒரு வாய்ப்பு தருகிறோம்!\n"
                  "எந்த நுழைவு கட்டணமும், எந்த பணம் செலுத்துவதும் தேவையில்லை.",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),

            /// How it works
            Text(
              "இது எப்படி வேலை செய்கிறது:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextTamil(
                "எங்கள் வலைத்தளம் அல்லது மொபைல் செயலியைப் பார்வையிட்டு இலவச வவுச்சரைப் பெறுங்கள்."),
            BulletTextTamil(
                "உங்கள் மொபைல் எண் அல்லது மின்னஞ்சல் முகவரியுடன் பதிவு செய்யவும்."),
            BulletTextTamil(
                "இலவச தங்க நாணயத்தைப் பெற ‘Claim Now’ பொத்தானை அழுத்தவும்."),
            BulletTextTamil(
                "உங்கள் விருப்பமான எந்த ஒரு எண்ணையும் தேர்ந்தெடுக்கவும் (எ.கா 5, 28, அல்லது 72)."),
            BulletTextTamil(
                "இலவச வவுச்சர்களுடன் ஒருமுறை மட்டுமே நுழையலாம்."),
            BulletTextTamil(
                "கட்டண வவுச்சர்களுடன் விருப்பமான எண்ணிக்கையுடன் பலமுறை நுழையலாம்."),
            BulletTextTamil(
                "நீங்கள் தேர்ந்தெடுத்த எண் தனித்துவமாக குறைந்த எண் (மற்றோர் யாரும் தேர்ந்தெடுக்கவில்லை) என்றால், நீங்கள் அதிர்ஷ்டம் வாய்ந்த தங்க நாணய வெற்றியாளர் ஆவீர்கள்."),
            BulletTextTamil(
                "மீண்டும் வரும் எண்கள் தகுதியற்றதாகும்."),

            SizedBox(height: 16),

            /// Winner announcement
            Text(
              "வெற்றியாளர் அறிவிப்பு:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextTamil(
                "வெற்றியாளர் எங்கள் வலைத்தளம், மொபைல் செயலி மற்றும் பிற சமூக ஊடக தளங்களில் அறிவிக்கப்படுவார்."),
            BulletTextTamil(
                "குறிப்பிட்ட முடிவுத் தேதியில் உங்களுக்கு அறிவிப்பு வழங்கப்படும்."),
            BulletTextTamil(
                "வெற்றியாளர் அறிவிக்கப்பட்டதும், முகவரி மற்றும் விவரங்களைப் பெற நேரடியாக உங்களை தொடர்பு கொள்வோம்."),
            BulletTextTamil(
                "ஒரு தங்க நாணயம் உங்கள் கதவிற்கு நேரடியாக இலவசமாக வழங்கப்படும்."),

            SizedBox(height: 16),

            /// Extra benefits
            Text(
              "கூடுதல் நன்மைகள்:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextTamil("நீங்கள் கட்டணம் செலுத்தி வவுச்சர்களை வாங்கலாம்."),
            BulletTextTamil("தயாரிப்புகளை முற்றிலும் இலவசமாகப் பெறலாம்."),
            BulletTextTamil(
                "வவுச்சர் தொகைகள் எங்கள் பிராண்ட் தயாரிப்புகளில் பயன்படுத்தலாம்."),
            BulletTextTamil("எங்கள் தினசரி நிகழ்ச்சிகளில் பங்கேற்கவும்."),

            SizedBox(height: 20),

            Center(
              child: Text(
                "பிரகாசமாக ஒளிருங்கள் 😍",
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

class BulletTextTamil extends StatelessWidget {
  final String text;

  const BulletTextTamil(this.text, {super.key});

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

