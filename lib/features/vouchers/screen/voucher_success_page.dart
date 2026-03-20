

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/screen/all_vouchers_list_page.dart';

import 'my_vouchers_list_page.dart';

class VoucherSuccessPage extends StatefulWidget {
  String? value;
   VoucherSuccessPage(this.value, {super.key});

  @override
  State<VoucherSuccessPage> createState() => _VoucherSuccessPageState();
}

class _VoucherSuccessPageState extends State<VoucherSuccessPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ Green check icon
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade100,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 60,
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ Success message
                Text(
                  "Voucher Placed Successfully",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // ✅ Sub message
                const Text(
                  "Your voucher placed has been recorded. You can track your voucher history from your dashboard.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                if(widget.value != "0.00")...[
                const SizedBox(height: 10),
                const Text(
                  "👍 Try with your other entry amount..",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                ],
                const SizedBox(height: 30),

                // ✅ "View Orders" button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      // Navigate to orders page
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyVouchersListPage()));

                    },
                    child: const Text(
                      "View my vouchers",
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ✅ "Continue Shopping" button (outlined)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      // Continue shopping action
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AllVouchersListPage()));

                    },
                    child: Text(
                      "Back to vouchers",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
