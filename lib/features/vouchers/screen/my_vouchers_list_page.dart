

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/widgets/banner_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/screen/my_vouchers_details_page.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_app_bar_widget.dart';
import '../../../main.dart';
import '../../category/controllers/category_controller.dart';
import '../widgets/voucher_time_card.dart';

class MyVouchersListPage extends StatefulWidget {

  const MyVouchersListPage({super.key});

  @override
  State<MyVouchersListPage> createState() => _MyVouchersListPageState();
}

class _MyVouchersListPageState extends State<MyVouchersListPage> {

  var amountController = TextEditingController();
  CategoryController? categoryController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryController = Provider.of<CategoryController>(Get.context!, listen: false);
    if(categoryController!.myVoucherList!.isNotEmpty) {
      categoryController!.myVoucherList!.clear();
    }
    categoryController!.getMyVouchers();
  }

  final List<Color> cardColors = [
    Colors.purple.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.pink.shade100,
    Colors.teal.shade100,
    Colors.amber.shade100,
    Colors.red.shade100,
    Colors.cyan.shade100,
    Colors.indigo.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Vouchers",
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<CategoryController>(builder: (context,provider,child){
              return provider.myVoucherList!.isNotEmpty ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.myVoucherList!.length,
                  itemBuilder: (context,index){
                  var voucher = provider.myVoucherList![index];
                  final color = cardColors[index % cardColors.length];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>
                          MyVouchersDetailsPage(voucher)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                voucher.image!,
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Content Section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    voucher.title!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    voucher.description!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Total Amount",
                                              style: TextStyle(fontSize: 12,color: Colors.black87)),
                                          _pill(voucher.value == "0.00" ? "Free" : "₹${voucher.value}", Theme.of(context).primaryColor),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Total Attempts",
                                              style: TextStyle(fontSize: 12,color: Colors.black87)),
                                          _pill(voucher.totalBids.toString(), Theme.of(context).primaryColor),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Center(
                                    child: VoucherTimerCard(
                                      endDateString: voucher.resultDate!, // Pass your string here
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
              }):BannerShimmer();
            })
          ],
        ),
      ),
    );
  }

  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}
