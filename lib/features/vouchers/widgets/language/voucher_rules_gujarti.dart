

import 'package:flutter/material.dart';

class VoucherRulesGujarti extends StatelessWidget {
  const VoucherRulesGujarti({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ગુજરાતી"),
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
              "મફત સોનાના સિક્કાઓ જીતી લો!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "અમે અમારા પ્રેમાળ ગ્રાહકોને મફત સોનાનો સિક્કો જીતવાનો મોકો આપી રહ્યા છીએ!\n"
                  "કોઈ એન્ટ્રી ફી અથવા કોઈ ચૂકવણીની જરૂર નથી.",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),

            /// How it works
            Text(
              "કેમ કામ કરે છે:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextGujarati(
                "અમારી વેબસાઇટ અથવા મોબાઇલ એપ પર જઈને તમારો મફત વાઉચર મેળવો."),
            BulletTextGujarati(
                "તમારા મોબાઇલ નંબર અથવા ઇમેલ સરનામાથી રજીસ્ટ્રેશન કરો."),
            BulletTextGujarati(
                "મફત સોનાના સિક્કા માટે ‘Claim Now’ બટન પર ક્લિક કરો."),
            BulletTextGujarati(
                "તમારી પસંદગીની કોઈપણ એન્ટ્રી પસંદ કરો (જેમ કે 5, 28, અથવા 72)."),
            BulletTextGujarati(
                "મફત વાઉચર સાથે તમે માત્ર એક જ વખત એન્ટ્રી આપી શકો છો."),
            BulletTextGujarati(
                "ચૂકવણી કરેલા વાઉચરો સાથે તમે તમારી પસંદગીની એન્ટ્રીઓ સાથે અનેક વખત એન્ટ્રી આપી શકો છો."),
            BulletTextGujarati(
                "જો તમારી પસંદગીની એન્ટ્રી એકલિની સૌથી નીચી અને અનોખી છે (અર્થાત કોઈએ તે પસંદ ન કરી હોય), તો તમે અમારા લકી ગોલ્ડ કૉઇન વિજેતા બનશો."),
            BulletTextGujarati(
                "પુનરાવર્તિત સંખ્યાઓ અયોગ્ય ગણાશે."),

            SizedBox(height: 16),

            /// Winner announcement
            Text(
              "વિજેતાની જાહેરાત:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextGujarati(
                "વિજેતાની જાહેરાત અમારી વેબસાઇટ, મોબાઇલ એપ અને અન્ય સોશિયલ મીડિયા પ્લેટફોર્મ્સ પર કરવામાં આવશે."),
            BulletTextGujarati(
                "નિર્ધારિત પરિણામની તારીખે તમને નોટિફિકેશન પણ મળશે."),
            BulletTextGujarati(
                "વિજેતા જાહેર થયા બાદ, તમારું સરનામું અને વિગતો એકત્રિત કરવા માટે અમે સીધો તમારો સંપર્ક કરીશું."),
            BulletTextGujarati(
                "એક ગોલ્ડ કૉઇન સંપૂર્ણપણે મફત તમારા ઘરના દરવાજે પહોંચાડવામાં આવશે."),

            SizedBox(height: 16),

            /// Extra benefits
            Text(
              "વધારાના લાભો:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextGujarati("તમે પેઇડ વાઉચર્સ પણ ખરીદી શકો છો."),
            BulletTextGujarati("ઉત્પાદનો સંપૂર્ણપણે મફતમાં મેળવો."),
            BulletTextGujarati(
                "વાઉચર રકમ અમારા બ્રાન્ડના ઉત્પાદનો પર રીડિમ કરી શકાય છે."),
            BulletTextGujarati("અમારા રોજિંદા ઇવેન્ટ્સમાં ભાગ લો."),

            SizedBox(height: 20),

            Center(
              child: Text(
                "શાઇન બ્રિલિયન્ટલી 😍",
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

class BulletTextGujarati extends StatelessWidget {
  final String text;

  const BulletTextGujarati(this.text, {super.key});

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
