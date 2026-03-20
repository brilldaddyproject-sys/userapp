

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoucherRulesTelgu extends StatelessWidget {
  const VoucherRulesTelgu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("తెలుగు"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
              "ఫ్రీ గోల్డ్ కాయిన్స్ గెలవండి!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "మేము మా ప్రియమైన కస్టమర్లకు ఒక ఫ్రీ గోల్డ్ కాయిన్ గెలిచే అవకాశం ఇస్తున్నాము!\n"
                  "ఎటువంటి రిజిస్ట్రేషన్ ఫీజు లేదా చెల్లింపు అవసరం లేదు.",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),

            /// How it works
            Text(
              "ఎలా పని చేస్తుంది:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextTelugu(
                "మా వెబ్‌సైట్ లేదా మొబైల్ యాప్ సందర్శించిన తర్వాత మీ ఫ్రీ వౌచర్ పొందండి."),
            BulletTextTelugu(
                "మీ మొబైల్ నంబర్ లేదా ఇమెయిల్ అడ్రస్‌తో రిజిస్టర్ అవ్వండి."),
            BulletTextTelugu(
                "ఫ్రీ గోల్డ్ కాయిన్ కోసం ‘Claim Now’ బటన్‌పై క్లిక్ చేయండి."),
            BulletTextTelugu(
                "మీ ఇష్టమైన ఎంట్రీని ఎంచుకోండి (ఉదాహరణకు 5, 28, లేదా 72)."),
            BulletTextTelugu(
                "ఫ్రీ వౌచర్లతో మీరు ఒక్కసారి మాత్రమే ప్రవేశించవచ్చు."),
            BulletTextTelugu(
                "చెల్లించిన వౌచర్లతో మీ ఇష్టమైన ఎంట్రీ అమౌంట్లతో బహుళసార్లు ప్రవేశించవచ్చు."),
            BulletTextTelugu(
                "మీరు ఎంచుకున్న ఎంట్రీ సింగిల్ లోయెస్ట్ యూనిక్ (ఇతరులు ఎవరూ ఎంచుకోకపోతే) అయితే, మీరు మా లక్కీ గోల్డ్ కాయిన్ విజేత అవుతారు."),
            BulletTextTelugu(
                "పునరావృతమైన సంఖ్యలు అర్హత రహితం అవుతాయి."),

            SizedBox(height: 16),

            /// Winner announcement
            Text(
              "విజేత ప్రకటన:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextTelugu(
                "విజేత ప్రకటన మా వెబ్‌సైట్, మొబైల్ యాప్ మరియు ఇతర సోషల్ మీడియా ప్లాట్‌ఫారమ్స్‌లో జరుగుతుంది."),
            BulletTextTelugu(
                "నిర్ణీత ఫలిత తేదీకి మీరు నోటిఫికేషన్ కూడా పొందుతారు."),
            BulletTextTelugu(
                "విజేతను ప్రకటించిన వెంటనే, మీ చిరునామా మరియు వివరాలను సేకరించడానికి మిమ్మల్ని నేరుగా సంప్రదిస్తాము."),
            BulletTextTelugu(
                "ఒక గోల్డ్ కాయిన్ పూర్తిగా ఉచితంగా మీ దరికి నేరుగా డెలివరీ చేయబడుతుంది."),

            SizedBox(height: 16),

            /// Extra benefits
            Text(
              "అదనపు ప్రయోజనాలు:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextTelugu("మీరు చెల్లించబడిన వౌచర్లను కూడా కొనుగోలు చేయవచ్చు."),
            BulletTextTelugu("ఉత్పత్తులను పూర్తిగా ఉచితంగా పొందండి."),
            BulletTextTelugu(
                "వౌచర్ మొత్తం మా బ్రాండ్ ఉత్పత్తులపై రీడీమ్ చేయవచ్చు."),
            BulletTextTelugu("మా దినచర్య ఈవెంట్లలో పాల్గొనండి."),

            SizedBox(height: 20),

            Center(
              child: Text(
                "ప్రకాశించండి జ్ఞానవంతంగా 😍",
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

class BulletTextTelugu extends StatelessWidget {
  final String text;

  const BulletTextTelugu(this.text, {super.key});

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
