

import 'package:flutter/material.dart';

class VoucherRulesMalayalam extends StatelessWidget {
  const VoucherRulesMalayalam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('മലയാളം'),
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
              "സ്വർണ്ണ നാണയങ്ങൾ നേടൂ!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "നമുക്കൊപ്പം ഉള്ള പ്രിയപ്പെട്ട ഉപഭോക്താക്കൾക്ക് ഒരു സൗജന്യ സ്വർണ്ണ നാണയം നേടാനുള്ള അവസരം നൽകുന്നു!\n"
                  "പ്രവേശന ഫീസ് ഇല്ല, പണമിടപാട് ആവശ്യമില്ല!",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),

            /// How it works
            Text(
              "ഈ പ്രക്രിയ എങ്ങനെ പ്രവർത്തിക്കുന്നു:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextMalayalam(
                "ഞങ്ങളുടെ വെബ്സൈറ്റ് അല്ലെങ്കിൽ മൊബൈൽ ആപ്പിൽ സന്ദർശിച്ച ശേഷം സൗജന്യ വൗച്ചർ നേടുക."),
            BulletTextMalayalam(
                "നിങ്ങളുടെ മൊബൈൽ നമ്പർ അല്ലെങ്കിൽ ഇമെയിൽ വിലാസം ഉപയോഗിച്ച് രജിസ്റ്റർ ചെയ്യുക."),
            BulletTextMalayalam(
                "സൗജന്യ സ്വർണ്ണ നാണയം ലഭിക്കാൻ ‘Claim Now’ ബട്ടൺ ക്ലിക്കുചെയ്യുക."),
            BulletTextMalayalam(
                "നിങ്ങളുടെ ഇഷ്ടപ്പെട്ട എൻട്രി നമ്പർ തിരഞ്ഞെടുക്കുക (ഉദാഹരണത്തിന് 5, 28, അല്ലെങ്കിൽ 72)."),
            BulletTextMalayalam(
                "സൗജന്യ വൗച്ചറുകളോടെ നിങ്ങൾക്ക് ഒരിക്കൽ മാത്രം എൻട്രി ചെയ്യാം."),
            BulletTextMalayalam(
                "പെയ്ഡ് വൗച്ചറുകളോടെ നിങ്ങൾക്ക് ഇഷ്ടമുള്ളത്ര തവണ എൻട്രി ചെയ്യാം."),
            BulletTextMalayalam(
                "നിങ്ങൾ തിരഞ്ഞെടുക്കുന്ന എൻട്രി ഏകാന്തമായ ഏറ്റവും കുറഞ്ഞ നമ്പറായാൽ (മറ്റാരും അത് തിരഞ്ഞെടുത്തിട്ടില്ലെങ്കിൽ), നിങ്ങൾ ഞങ്ങളുടെ ഭാഗ്യശാലി സ്വർണ്ണ നാണയ വിജയിയാകും."),
            BulletTextMalayalam(
                "ആവർത്തിക്കുന്ന നമ്പറുകൾ അയോഗ്യമായിരിക്കും."),

            SizedBox(height: 16),

            /// Winner announcement
            Text(
              "വിജയിയുടെ പ്രഖ്യാപനം:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextMalayalam(
                "വിജയിയുടെ പ്രഖ്യാപനം ഞങ്ങളുടെ വെബ്സൈറ്റ്, മൊബൈൽ ആപ്പ്, മറ്റ് സോഷ്യൽ മീഡിയ പ്ലാറ്റ്ഫോമുകൾ എന്നിവയിൽ ഉണ്ടാകും."),
            BulletTextMalayalam(
                "നിർണ്ണയിച്ച ഫലം തീയതിയിൽ നിങ്ങൾക്ക് നോട്ടിഫിക്കേഷൻ ലഭിക്കും."),
            BulletTextMalayalam(
                "വിജയിയെ പ്രഖ്യാപിച്ചതിന് ശേഷം, നിങ്ങളുടെ വിലാസവും വിശദാംശങ്ങളും ശേഖരിക്കുന്നതിന് ഞങ്ങൾ നിങ്ങളെ നേരിട്ട് ബന്ധപ്പെടും."),
            BulletTextMalayalam(
                "ഒരു സ്വർണ്ണ നാണയം നിങ്ങളുടെ വീട്ടുപടിക്കൽ പൂർണ്ണമായും സൗജന്യമായി എത്തിക്കും."),

            SizedBox(height: 16),

            /// Extra benefits
            Text(
              "അധിക ആനുകൂല്യങ്ങൾ:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextMalayalam("നിങ്ങൾക്ക് പെയ്ഡ് വൗച്ചറുകളും വാങ്ങാം."),
            BulletTextMalayalam("തികച്ചും സൗജന്യമായി ഉൽപ്പന്നങ്ങൾ നേടാം."),
            BulletTextMalayalam(
                "വൗച്ചർ തുക ഞങ്ങളുടെ ബ്രാൻഡ് ഉൽപ്പന്നങ്ങളിൽ റിഡീം ചെയ്യാം."),
            BulletTextMalayalam("ഞങ്ങളുടെ ദൈനംദിന പരിപാടികളിൽ പങ്കെടുക്കുക."),

            SizedBox(height: 20),

            Center(
              child: Text(
                "ഉജ്ജ്വലമായി തിളങ്ങുക 😍",
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

class BulletTextMalayalam extends StatelessWidget {
  final String text;

  const BulletTextMalayalam(this.text, {super.key});

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
