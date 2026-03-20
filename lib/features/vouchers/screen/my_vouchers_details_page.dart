


import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/widgets/banner_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/model/voucher_bid_model.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_app_bar_widget.dart';
import '../../../helper/date_converter.dart';
import '../../../main.dart';
import '../../category/controllers/category_controller.dart';

class MyVouchersDetailsPage extends StatefulWidget {
  VoucherBidModel voucher;
  MyVouchersDetailsPage(this.voucher, {super.key});

  @override
  State<MyVouchersDetailsPage> createState() => _MyVouchersDetailsPageState();
}

class _MyVouchersDetailsPageState extends State<MyVouchersDetailsPage> {

  var amountController = TextEditingController();
  CategoryController? categoryController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    categoryController = Provider.of<CategoryController>(Get.context!, listen: false);
    if(categoryController!.myVoucherDetailsList!=null) {
      categoryController!.myVoucherDetailsList!.clear();
    }
    categoryController!.getMyVouchersDetails(widget.voucher.id!.toString());
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
        title: "",
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
                        widget.voucher.image!,
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
                            widget.voucher.title!,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            widget.voucher.description!,
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
                                  const Text("Voucher price",
                                      style: TextStyle(fontSize: 12,color: Colors.black87)),
                                  _pill(widget.voucher.value == "0.00" ? "Free" : "₹${widget.voucher.value}", Theme.of(context).primaryColor),
                                ],
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Your Attempts",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black87),),
            ),
            SizedBox(height: 5,),
            Consumer<CategoryController>(builder: (context,provider,child){
              return provider.myVoucherDetailsList!.isNotEmpty ?  ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: provider.myVoucherDetailsList!.length,
                  itemBuilder: (context,index){
                    var voucher = provider.myVoucherDetailsList![index];
                    final color = cardColors[index % cardColors.length];
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row: Title + Amount
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    voucher.title!,
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Amount: ₹ ${voucher.amount}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              // Brand + Date
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    voucher.description!,
                                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                                  ),
                                  Text(
                                    "Created On ${DateConverter.dateTimeStringToDateAndTime(voucher.createdAt!)}",
                                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              // Divider
                              const Divider(height: 1),

                              const SizedBox(height: 14),

                              // Dotted Code Box
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                    style: BorderStyle.solid,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${voucher.gameid!}",
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
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
