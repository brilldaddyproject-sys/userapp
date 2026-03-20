

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_app_bar_widget.dart';
import '../../../main.dart';
import '../../banner/widgets/banner_shimmer.dart';
import '../../category/controllers/category_controller.dart';

class VoucherWinnersPage extends StatefulWidget {

  const VoucherWinnersPage({super.key});

  @override
  State<VoucherWinnersPage> createState() => _VoucherWinnersPageState();
}

class _VoucherWinnersPageState extends State<VoucherWinnersPage> {

  CategoryController? categoryController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryController = Provider.of<CategoryController>(Get.context!, listen: false);
    if(categoryController!.myVoucherList!.isNotEmpty) {
      categoryController!.myVoucherList!.clear();
    }
    categoryController!.getWinnerList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Winners",
          onBackPressed: () {
            Navigator.of(context).pop();
          },
        ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://brilldaddy.com/storage/app/public/vouchers/winnerlist.jpeg",
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Consumer<CategoryController>(
                    builder: (context, provider, child) {
                      return provider.winnerGalleryList!.isNotEmpty
                          ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                          childAspectRatio: 0.9, // Adjust to control item height
                        ),
                        itemCount: provider.winnerGalleryList!.length,
                        itemBuilder: (context, index) {
                          var voucher = provider.winnerGalleryList![index];
                          return InkWell(
                            onTap: () {
                              // Handle tap
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      voucher.image!,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                          : BannerShimmer();
                    },
                  )
                ],
              ),
            ),
    );
  }
}
