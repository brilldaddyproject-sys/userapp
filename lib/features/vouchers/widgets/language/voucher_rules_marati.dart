

import 'package:flutter/material.dart';

class VoucherRulesMarati extends StatelessWidget {
  const VoucherRulesMarati({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('मोफत सोन्याचे नाणी जिंका!'),
        backgroundColor: Colors.amber.shade700,
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
              "मोफत सोन्याचे नाणी जिंकून घ्या!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "आम्ही आमच्या प्रिय ग्राहकांना मोफत सोन्याचे नाणे जिंकण्याची संधी देत आहोत!\n"
                  "कोणतेही प्रवेश शुल्क नाही किंवा कोणतेही पेमेंट आवश्यक नाही.",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),

            /// How it works
            Text(
              "हे कसे कार्य करते:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextMarathi(
                "आमच्या वेबसाइट किंवा मोबाइल अॅपला भेट दिल्यानंतर आपला मोफत वाउचर मिळवा."),
            BulletTextMarathi(
                "आपला मोबाइल नंबर किंवा ईमेल पत्त्याने नोंदणी करा."),
            BulletTextMarathi(
                "मोफत सोन्याचे नाणे मिळवण्यासाठी ‘Claim Now’ बटणावर क्लिक करा."),
            BulletTextMarathi(
                "आपल्या पसंतीचा एंट्री क्रम निवडा (जसे 5, 28 किंवा 72)."),
            BulletTextMarathi(
                "मोफत वाउचरसह आपण फक्त एकदाच प्रवेश करू शकता."),
            BulletTextMarathi(
                "पैसे भरलेल्या वाउचरसह आपण आपल्या आवडत्या एंट्री प्रमाणानुसार अनेक वेळा प्रवेश करू शकता."),
            BulletTextMarathi(
                "जर आपली निवडलेली एंट्री ही एकटाच सर्वात कमी अनन्य संख्या असेल (म्हणजे इतर कोणालाही ती निवडलेली नसेल), तर आपण आमचे लकी सोन्याचे नाणे विजेते बनता."),
            BulletTextMarathi(
                "पुनरावृत्त संख्या अयोग्य ठरतील."),

            SizedBox(height: 16),

            /// Winner announcement
            Text(
              "विजेत्याची घोषणा:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextMarathi(
                "विजेत्याची घोषणा आमच्या वेबसाइट, मोबाइल अॅप आणि इतर सोशल मीडिया प्लॅटफॉर्म्सवर केली जाईल."),
            BulletTextMarathi(
                "निर्दिष्ट निकालाच्या दिवशी तुम्हाला सूचना (नोटिफिकेशन) मिळेल."),
            BulletTextMarathi(
                "विजेता जाहीर झाल्यानंतर, तुमचा पत्ता व माहिती गोळा करण्यासाठी आम्ही थेट तुमच्याशी संपर्क साधू."),
            BulletTextMarathi(
                "एक सोन्याचे नाणे पूर्णपणे मोफत तुमच्या दारात पोहोचवले जाईल."),

            SizedBox(height: 16),

            /// Extra benefits
            Text(
              "अतिरिक्त फायदे:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextMarathi("तुम्ही पैसे दिलेले वाउचर देखील खरेदी करू शकता."),
            BulletTextMarathi("उत्पादने पूर्णपणे मोफत मिळवा."),
            BulletTextMarathi(
                "वाउचरची रक्कम आमच्या ब्रँडच्या उत्पादनांवर वापरता येईल."),
            BulletTextMarathi("आमच्या दैनिक कार्यक्रमांमध्ये सहभागी व्हा."),

            SizedBox(height: 20),

            Center(
              child: Text(
                "प्रकाशमान व्हा 😍",
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

class BulletTextMarathi extends StatelessWidget {
  final String text;

  const BulletTextMarathi(this.text, {super.key});

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
