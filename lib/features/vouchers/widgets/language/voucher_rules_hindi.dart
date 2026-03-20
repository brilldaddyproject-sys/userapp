

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/basewidget/custom_app_bar_widget.dart';

class VoucherRulesHindi extends StatelessWidget {

  const VoucherRulesHindi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "हिन्दी",
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
              "मुफ़्त गोल्ड कॉइन्स जीतें!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "हम अपने प्यारे ग्राहकों को एक मुफ़्त गोल्ड कॉइन जीतने का मौका दे रहे हैं!\n"
                  "इसके लिए कोई प्रवेश शुल्क या भुगतान आवश्यक नहीं है।",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),

            /// How it works
            Text(
              "यह कैसे काम करता है:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextHindi("हमारी वेबसाइट या मोबाइल ऐप पर विज़िट करने के बाद अपना मुफ़्त वाउचर प्राप्त करें।"),
            BulletTextHindi("अपने मोबाइल नंबर या ईमेल एड्रेस के साथ रजिस्टर करें।"),
            BulletTextHindi("मुफ़्त गोल्ड कॉइन के लिए 'क्लेम नाउ' बटन पर क्लिक करें।"),
            BulletTextHindi("अपनी पसंद की किसी भी प्रविष्टि का चयन करें (जैसे 5, 28, या 72)।"),
            BulletTextHindi("मुफ़्त वाउचर के साथ आप केवल एक बार प्रवेश कर सकते हैं।"),
            BulletTextHindi("पेड वाउचर के साथ आप अपनी पसंदीदा प्रविष्टियों के साथ कई बार प्रवेश कर सकते हैं।"),
            BulletTextHindi(
                "यदि आपकी चुनी हुई प्रविष्टि सबसे कम अद्वितीय है (जिसे किसी और ने नहीं चुना है), तो आप हमारे लकी गोल्ड कॉइन विजेता बन जाते हैं।"),
            BulletTextHindi("दोहराई गई संख्याओं को अयोग्य घोषित कर दिया जाएगा।"),

            SizedBox(height: 16),

            /// Winner info
            Text(
              "विजेता की घोषणा:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextHindi(
                "विजेता की घोषणा हमारी वेबसाइट, मोबाइल ऐप और अन्य सोशल मीडिया प्लेटफार्मों पर की जाएगी।"),
            BulletTextHindi(
                "निर्दिष्ट परिणाम तिथि पर आपको नोटिफिकेशन भी प्राप्त होगा।"),
            BulletTextHindi(
                "विजेता घोषित होने के बाद, हम सीधे आपसे संपर्क करेंगे और आपका पता व विवरण लेंगे।"),
            BulletTextHindi(
                "गोल्ड कॉइन बिल्कुल मुफ़्त में सीधे आपके दरवाजे तक पहुंचाई जाएगी।"),

            SizedBox(height: 16),

            /// Extra benefits
            Text(
              "अतिरिक्त लाभ:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextHindi("आप पेड वाउचर भी खरीद सकते हैं।"),
            BulletTextHindi("उत्पाद बिल्कुल मुफ़्त में प्राप्त करें।"),
            BulletTextHindi(
                "वाउचर की राशि हमारे ब्रांड उत्पादों पर रिडीम की जा सकती है।"),
            BulletTextHindi("हमारे दैनिक आयोजनों में भाग लें।"),

            SizedBox(height: 20),

            Center(
              child: Text(
                "शाइन ब्रिलियंटली 😍",
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

class BulletTextHindi extends StatelessWidget {
  final String text;

  const BulletTextHindi(this.text, {super.key});

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