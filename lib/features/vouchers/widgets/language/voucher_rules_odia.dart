


import 'package:flutter/material.dart';

class VoucherRulesOdia extends StatelessWidget {
  const VoucherRulesOdia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ଓଡିଆ"),
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
              "ମାଗଣା ସ୍ୱର୍ଣ୍ଣ ମୁଦ୍ରା ଜିତନ୍ତୁ!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "ଆମେ ଆମର ପ୍ରିୟ ଗ୍ରାହକମାନଙ୍କୁ ଏକ ମାଗଣା ସୁନା ମୁଦ୍ରା ଜିତିବାର ସୁଯୋଗ ଦେଉଛୁ!\n"
                  "କୌଣସି ପ୍ରବେଶ ଶୁଳ୍କ କିମ୍ବା କୌଣସି ଦେୟ ଆବଶ୍ୟକ ନାହିଁ।",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),

            /// How it works
            Text(
              "ଏହା କିପରି କାମ କରେ:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextOriya(
                "ଆମର ୱେବସାଇଟ୍ କିମ୍ବା ମୋବାଇଲ୍ ଆପ୍ ପରିଦର୍ଶନ କରିବା ପରେ ଆପଣଙ୍କର ମାଗଣା ଭାଉଚର୍ ପାଆନ୍ତୁ।"),
            BulletTextOriya(
                "ଆପଣଙ୍କର ମୋବାଇଲ୍ ନମ୍ବର କିମ୍ବା ଇମେଲ୍ ଠିକଣା ସହିତ ପଞ୍ଜିକରଣ କରନ୍ତୁ।"),
            BulletTextOriya(
                "ମାଗଣା ସୁନା ମୁଦ୍ରା ପାଇଁ ‘Claim Now’ ବଟନ୍ କ୍ଲିକ୍ କରନ୍ତୁ।"),
            BulletTextOriya(
                "ଆପଣଙ୍କ ପସନ୍ଦର ଯେକୌଣସି ଏଣ୍ଟ୍ରି ବାଛନ୍ତୁ (ଯେପରିକି 5, 28, କିମ୍ବା 72)।"),
            BulletTextOriya(
                "ମାଗଣା ଭାଉଚର୍ ସହିତ ଆପଣ କେବଳ ଗୋଟିଏ ଥର ପ୍ରବେଶ କରିପାରିବେ।"),
            BulletTextOriya(
                "ଦେୟ ଭାଉଚର୍ ସହିତ ଆପଣ ଆପଣଙ୍କର ପସନ୍ଦିତା ଏଣ୍ଟ୍ରି ସହିତ ଏକାଧିକ ଥର ପ୍ରବେଶ କରିପାରିବେ।"),
            BulletTextOriya(
                "ଯଦି ଆପଣଙ୍କର ମନୋନୀତ ଏଣ୍ଟ୍ରି ସର୍ବନିମ୍ନ ଅନନ୍ୟ ଅଟେ (ଅର୍ଥାତ୍ ଅନ୍ୟ କେହି ଏହାକୁ ବାଛିନାହାଁନ୍ତି), ତେବେ ଆପଣ ଆମର ଲକି ଗୋଲ୍ଡ କଏନ୍ ବିଜେତା ହେବେ।"),
            BulletTextOriya(
                "ପୁନରାବୃତ୍ତି ନମ୍ବରଗୁଡ଼ିକ ଅଯୋଗ୍ୟ ହେବ।"),

            SizedBox(height: 16),

            /// Winner announcement
            Text(
              "ବିଜେତା ଘୋଷଣା:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextOriya(
                "ବିଜେତାଙ୍କ ଘୋଷଣା ଆମର ୱେବସାଇଟ୍, ମୋବାଇଲ୍ ଆପ୍ ଏବଂ ଅନ୍ୟାନ୍ୟ ସୋସିଆଲ୍ ମିଡିଆ ପ୍ଲାଟଫର୍ମରେ କରାଯିବ।"),
            BulletTextOriya(
                "ନିର୍ଦ୍ଦିଷ୍ଟ ଫଳାଫଳ ତାରିଖରେ ଆପଣ ଏକ ବିଜ୍ଞପ୍ତି ମଧ୍ୟ ପାଇବେ।"),
            BulletTextOriya(
                "ବିଜେତା ଘୋଷିତ ହେବା ପରେ, ଆମେ ଆପଣଙ୍କୁ ସିଧାସଳଖ ସଂପର୍କ କରି ଆପଣଙ୍କର ଠିକଣା ଏବଂ ବିବରଣୀ ସଂଗ୍ରହ କରିବୁ।"),
            BulletTextOriya(
                "ଏକ ସ୍ୱର୍ଣ୍ଣ ମୁଦ୍ରା ସମ୍ପୂର୍ଣ୍ଣ ମାଗଣା ଭାବେ ଆପଣଙ୍କ ଘରଦୁଆରେ ପହଞ୍ଚାଇ ଦିଆଯିବ।"),

            SizedBox(height: 16),

            /// Extra benefits
            Text(
              "ଅତିରିକ୍ତ ଲାଭ:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            BulletTextOriya("ଆପଣ ଦେୟ ଭାଉଚର୍ ମଧ୍ୟ କ୍ରୟ କରିପାରିବେ।"),
            BulletTextOriya("ଉତ୍ପାଦଗୁଡ଼ିକ ସମ୍ପୂର୍ଣ୍ଣ ମାଗଣାରେ ପାଆନ୍ତୁ।"),
            BulletTextOriya(
                "ଭାଉଚର୍ ରାଶିଗୁଡ଼ିକୁ ଆମ ବ୍ରାଣ୍ଡ ଉତ୍ପାଦଗୁଡ଼ିକରେ ବ୍ୟବହାର କରାଯାଇପାରିବ।"),
            BulletTextOriya("ଆମର ଦୈନିକ ଘଟଣାରେ ଅଂଶ ନିଅନ୍ତୁ।"),

            SizedBox(height: 20),

            Center(
              child: Text(
                "ଚମକିବାରେ ପ୍ରକାଶିତ ହୁଅନ୍ତୁ 😍",
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

class BulletTextOriya extends StatelessWidget {
  final String text;

  const BulletTextOriya(this.text, {super.key});

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
