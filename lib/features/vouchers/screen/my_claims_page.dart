import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/widgets/banner_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/model/my_claim_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/screen/my_claims_details_page.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class MyClaimsPage extends StatefulWidget {
  const MyClaimsPage({super.key});

  @override
  State<MyClaimsPage> createState() => _MyClaimsPageState();
}

class _MyClaimsPageState extends State<MyClaimsPage> {
  CategoryController? categoryController;

  final List<Color> cardColors = <Color>[
    Colors.orange.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.purple.shade100,
    Colors.teal.shade100,
    Colors.pink.shade100,
  ];

  @override
  void initState() {
    super.initState();
    categoryController = Provider.of<CategoryController>(Get.context!, listen: false);
    if (categoryController!.myClaimList!.isNotEmpty) {
      categoryController!.myClaimList!.clear();
    }
    categoryController!.getMyClaims();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Claims',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: Consumer<CategoryController>(
        builder: (context, provider, child) {
          if (provider.isMyClaimsLoading) {
            return const SingleChildScrollView(child: BannerShimmer());
          }

          if (provider.myClaimList == null || provider.myClaimList!.isEmpty) {
            return const NoInternetOrDataScreenWidget(
              isNoInternet: false,
              message: 'no_data_found',
              icon: Images.noData,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
            itemCount: provider.myClaimList!.length,
            itemBuilder: (context, index) {
              final MyClaimModel claim = provider.myClaimList![index];
              final Color accentColor = cardColors[index % cardColors.length];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MyClaimsDetailsPage(claim)),
                  );
                },
                child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        claim.image ?? '',
                        width: 92,
                        height: 92,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 92,
                          height: 92,
                          color: const Color(0xFFF1F3F8),
                          child: const Icon(Icons.image_not_supported_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            claim.title ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            claim.description ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              _pill('Value ₹${claim.value ?? '0'}', accentColor),
                              _pill('Bids ${claim.totalBids ?? 0}', Theme.of(context).primaryColor),
                              _pill(claim.slots?.display ?? '--', const Color(0xFF3A7AFE)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  claim.latestBidAt?.isNotEmpty == true
                                      ? 'Last bid: ${claim.latestBidAt}'
                                      : 'Last bid: --',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: (claim.isWinner ?? false)
                                      ? const Color(0xFFE7F8EE)
                                      : (claim.resultAnnounced ?? false)
                                          ? const Color(0xFFFFF1F1)
                                          : const Color(0xFFFFF7E8),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  (claim.isWinner ?? false)
                                      ? 'Winner'
                                      : (claim.resultAnnounced ?? false)
                                          ? 'Result announced'
                                          : 'Result pending',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: (claim.isWinner ?? false)
                                        ? const Color(0xFF1F8F4A)
                                        : (claim.resultAnnounced ?? false)
                                            ? const Color(0xFFC83A3A)
                                            : const Color(0xFFB26A00),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
