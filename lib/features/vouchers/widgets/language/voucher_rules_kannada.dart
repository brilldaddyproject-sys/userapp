

import 'package:flutter/material.dart';

class VoucherRulesKannada extends StatelessWidget {
  const VoucherRulesKannada({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ಉಚಿತ ಚಿನ್ನದ ನಾಣ್ಯಗಳು'),
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
              "ಉಚಿತ ಚಿನ್ನದ ನಾಣ್ಯಗಳನ್ನು ಗೆಲ್ಲಿರಿ!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "ನಾವು ನಮ್ಮ ಪ್ರಿಯ ಗ್ರಾಹಕರಿಗೆ ಉಚಿತ ಚಿನ್ನದ ನಾಣ್ಯವನ್ನು ಗೆಲ್ಲುವ ಅವಕಾಶವನ್ನು ನೀಡುತ್ತಿದ್ದೇವೆ!\n"
                  "ಯಾವುದೇ ಪ್ರವೇಶ ಶುಲ್ಕ ಅಥವಾ ಪಾವತಿ ಅಗತ್ಯವಿಲ್ಲ!",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),

            /// How it works
            Text(
              "ಇದು ಹೇಗೆ ಕಾರ್ಯನಿರ್ವಹಿಸುತ್ತದೆ:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextKannada(
                "ನಮ್ಮ ವೆಬ್‌ಸೈಟ್ ಅಥವಾ ಮೊಬೈಲ್ ಆ್ಯಪ್‌ಗೆ ಭೇಟಿ ನೀಡಿದ ನಂತರ ನಿಮ್ಮ ಉಚಿತ ವೌಚರ್ ಅನ್ನು ಪಡೆಯಿರಿ."),
            BulletTextKannada(
                "ನಿಮ್ಮ ಮೊಬೈಲ್ ಸಂಖ್ಯೆ ಅಥವಾ ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ಬಳಸಿಕೊಂಡು ನೋಂದಾಯಿಸಿ."),
            BulletTextKannada(
                "ಉಚಿತ ಚಿನ್ನದ ನಾಣ್ಯಕ್ಕಾಗಿ ‘Claim Now’ ಬಟನ್ ಅನ್ನು ಕ್ಲಿಕ್ ಮಾಡಿ."),
            BulletTextKannada(
                "ನಿಮ್ಮ ಆಯ್ಕೆಯ ಯಾವುದೇ ಎಂಟ್ರಿಯನ್ನು ಆಯ್ಕೆ ಮಾಡಿ (ಉದಾಹರಣೆಗೆ 5, 28, ಅಥವಾ 72)."),
            BulletTextKannada(
                "ಉಚಿತ ವೌಚರ್‌ಗಳೊಂದಿಗೆ ನೀವು ಒಂದೇ ಬಾರಿ ಪ್ರವೇಶಿಸಬಹುದು."),
            BulletTextKannada(
                "ಪಾವತಿಸಿದ ವೌಚರ್‌ಗಳೊಂದಿಗೆ ನಿಮ್ಮ ಇಷ್ಟದ ಎಂಟ್ರಿ ಸಂಖ್ಯೆಗಳೊಂದಿಗೆ ಹಲವು ಬಾರಿ ಪ್ರವೇಶಿಸಬಹುದು."),
            BulletTextKannada(
                "ನಿಮ್ಮ ಆಯ್ಕೆ ಮಾಡಿದ ಎಂಟ್ರಿ ಏಕೈಕ ಮತ್ತು ಅತ್ಯಂತ ಕಡಿಮೆ ಸಂಖ್ಯೆಯಾಗಿದ್ದರೆ (ಅರ್ಥಾತ್ ಇನ್ನಾರೂ ಅದನ್ನು ಆಯ್ಕೆ ಮಾಡಿರದಿದ್ದರೆ), ನೀವು ನಮ್ಮ ಲಕ್ಕಿ ಗೋಲ್ಡ್ ಕಾಯಿನ್ ವಿಜೇತರಾಗುತ್ತೀರಿ!"),
            BulletTextKannada(
                "ಪುನರಾವರ್ತಿತ ಸಂಖ್ಯೆಗಳು ಅಮಾನ್ಯವಾಗಿರುತ್ತವೆ."),

            SizedBox(height: 16),

            /// Winner announcement
            Text(
              "ವಿಜೇತರ ಘೋಷಣೆ:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextKannada(
                "ವಿಜೇತರ ಘೋಷಣೆ ನಮ್ಮ ವೆಬ್‌ಸೈಟ್, ಮೊಬೈಲ್ ಆ್ಯಪ್ ಮತ್ತು ಇತರ ಸಾಮಾಜಿಕ ಮಾಧ್ಯಮ ವೇದಿಕೆಗಳಲ್ಲಿ ಪ್ರಕಟಿಸಲಾಗುತ್ತದೆ."),
            BulletTextKannada(
                "ನಿರ್ದಿಷ್ಟ ಫಲಿತಾಂಶ ದಿನಾಂಕದಲ್ಲಿ ನಿಮಗೆ ನೋಟಿಫಿಕೇಶನ್ ದೊರೆಯುತ್ತದೆ."),
            BulletTextKannada(
                "ವಿಜೇತರನ್ನು ಘೋಷಿಸಿದ ನಂತರ, ನಿಮ್ಮ ವಿಳಾಸ ಮತ್ತು ವಿವರಗಳನ್ನು ಸಂಗ್ರಹಿಸಲು ನಾವು ನಿಮ್ಮನ್ನು ನೇರವಾಗಿ ಸಂಪರ್ಕಿಸುತ್ತೇವೆ."),
            BulletTextKannada(
                "ಚಿನ್ನದ ನಾಣ್ಯವನ್ನು ಸಂಪೂರ್ಣವಾಗಿ ಉಚಿತವಾಗಿ ನಿಮ್ಮ ಮನೆ ಬಾಗಿಲಿಗೆ ತಲುಪಿಸಲಾಗುತ್ತದೆ."),

            SizedBox(height: 16),

            /// Extra benefits
            Text(
              "ಹೆಚ್ಚುವರಿ ಪ್ರಯೋಜನಗಳು:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextKannada("ನೀವು ಪಾವತಿಸಿದ ವೌಚರ್‌ಗಳನ್ನು ಕೂಡ ಖರೀದಿಸಬಹುದು."),
            BulletTextKannada("ಉತ್ಪನ್ನಗಳನ್ನು ಸಂಪೂರ್ಣವಾಗಿ ಉಚಿತವಾಗಿ ಪಡೆಯಿರಿ."),
            BulletTextKannada(
                "ವೌಚರ್ ಮೊತ್ತವನ್ನು ನಮ್ಮ ಬ್ರಾಂಡ್ ಉತ್ಪನ್ನಗಳಲ್ಲಿ ರಿಡೀಮ್ ಮಾಡಬಹುದು."),
            BulletTextKannada("ನಮ್ಮ ದೈನಂದಿನ ಕಾರ್ಯಕ್ರಮಗಳಿಗೆ ಹಾಜರಾಗಿ."),

            SizedBox(height: 20),

            Center(
              child: Text(
                "ಅದ್ಭುತವಾಗಿ ಹೊಳೆಯಿರಿ 😍",
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

class BulletTextKannada extends StatelessWidget {
  final String text;

  const BulletTextKannada(this.text, {super.key});

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
