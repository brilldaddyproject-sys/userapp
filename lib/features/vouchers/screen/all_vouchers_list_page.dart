

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/screen/voucher_details_page.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_app_bar_widget.dart';
import '../../../common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import '../../../helper/price_converter.dart';
import '../../../main.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../category/controllers/category_controller.dart';
import '../widgets/voucher_time_card.dart';

class AllVouchersListPage extends StatefulWidget {
  const AllVouchersListPage({super.key});

  @override
  State<AllVouchersListPage> createState() => _AllVouchersListPageState();
}

class _AllVouchersListPageState extends State<AllVouchersListPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final categoryController = Provider.of<CategoryController>(Get.context!, listen: false);
    categoryController.getVouchers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Exclusive vouchers",
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Consumer<CategoryController>(builder: (context,categoryProvider,child){
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categoryProvider.voucherList!.length,
                itemBuilder: (context, index) {
                  var voucherBean = categoryProvider.voucherList![index];
                  return InkWell(
                    onTap: (){
                      if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){
                        Navigator.push(context, MaterialPageRoute(builder: (_) =>
                            VoucherDetailsPage(voucherBean,"details")));
                      }else{
                        showModalBottomSheet(backgroundColor: Colors.transparent,context:context, builder: (_)=> const NotLoggedInBottomSheetWidget());
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 120,
                                height: 144,
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.00),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.center,
                                    colors: [
                                      Theme.of(context).primaryColor, // Bottom strong color
                                      Colors.white, // Fade to transparent
                                    ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // IMAGE + GRADIENT
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(16),
                                              child: AspectRatio(
                                                aspectRatio: 1, // ✅ square image (no stretch)
                                                child: CustomImageWidget(
                                                  image: voucherBean.image!,
                                                  fit: BoxFit.cover, // ✅ maintain aspect ratio
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),                              // CLAIM NOW BUTTON
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          voucherBean.value! == "0.00" ? "Free" : PriceConverter.convertPrice(context, double.parse(voucherBean.value!)),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    // PRODUCT TITLE
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        voucherBean.title!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    // BRAND
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      child: Text(
                                        voucherBean.description!,
                                        style: TextStyle(fontSize: 13, color: Colors.grey),
                                      ),
                                    ),

                                    // VALID TILL + CLOCK ICON
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      child: Row(
                                        children: [
                                          Icon(Icons.access_time, size: 16, color: Colors.black54),
                                          SizedBox(width: 4),
                                          Text(
                                            'Valid until ${voucherBean.endDate!.toString()}',
                                            style: TextStyle(fontSize: 12,color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    // TIMER BADGE
                                    Center(
                                      child: VoucherTimerCard(
                                        endDateString: voucherBean.endDate!, // Pass your string here
                                      ),
                                    ),

                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () {
                              if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                    VoucherDetailsPage(voucherBean,"details")));
                              }else{
                                showModalBottomSheet(backgroundColor: Colors.transparent,context:context, builder: (_)=> const NotLoggedInBottomSheetWidget());
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Claim Now",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
