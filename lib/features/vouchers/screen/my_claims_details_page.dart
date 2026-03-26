import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/widgets/banner_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/model/my_claim_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../model/my_claim_details_model.dart';

class MyClaimsDetailsPage extends StatefulWidget {
  final MyClaimModel claim;
  const MyClaimsDetailsPage(this.claim, {super.key});

  @override
  State<MyClaimsDetailsPage> createState() => _MyClaimsDetailsPageState();
}

class _MyClaimsDetailsPageState extends State<MyClaimsDetailsPage> {
  CategoryController? categoryController;

  final List<Color> cardColors = <Color>[
    Colors.purple.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.pink.shade100,
    Colors.teal.shade100,
    Colors.amber.shade100,
    Colors.red.shade100,
  ];

  @override
  void initState() {
    super.initState();
    categoryController = Provider.of<CategoryController>(Get.context!, listen: false);
    categoryController!.clearMyClaimDetails();
    categoryController!.getMyClaimsDetails(widget.claim.id!.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Claim Details',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: Consumer<CategoryController>(
        builder: (context, provider, child) {
          if (provider.isMyClaimDetailsLoading) {
            return const SingleChildScrollView(child: BannerShimmer());
          }

          final MyClaimDetailsModel? details = provider.myClaimDetails;
          if (details == null || details.product == null) {
            return const NoInternetOrDataScreenWidget(
              isNoInternet: false,
              message: 'no_data_found',
              icon: Images.noData,
            );
          }

          final ClaimProduct product = details.product!;
          final ClaimDetailSlots? slots = details.slots;
          final ClaimWinner? winner = details.winner;
          final List<ClaimParticipant> participants = details.participants ?? <ClaimParticipant>[];

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            product.image ?? '',
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 90,
                              height: 90,
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
                                product.title ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product.description ?? '',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: <Widget>[
                                  _pill(
                                    product.voucherAmount == '0.00' ? 'Free' : 'Voucher ₹${product.voucherAmount ?? '0'}',
                                    Theme.of(context).primaryColor,
                                  ),
                                  _pill('Entry fee ₹${product.entryFee ?? '0'}', const Color(0xFF3A7AFE)),
                                  _pill(slots?.display ?? '--', const Color(0xFF14B87A)),
                                  _pill(
                                    (product.isWinnerAnnounced ?? false) ? 'Result announced' : 'Result pending',
                                    (product.isWinnerAnnounced ?? false) ? const Color(0xFF1F8F4A) : const Color(0xFFB26A00),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (slots != null || winner != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Claim Overview',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 12),
                          if (slots != null) ...<Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _overviewItem('Filled slots', '${slots.filled ?? 0}'),
                                _overviewItem('Remaining', '${slots.remaining ?? 0}'),
                                _overviewItem('Total slots', '${slots.total ?? 0}'),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                minHeight: 10,
                                value: (slots.progress ?? 0).clamp(0.0, 1.0),
                                backgroundColor: const Color(0xFFE9EEF7),
                                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2456D3)),
                              ),
                            ),
                          ],
                          if (winner != null) ...<Widget>[
                            const SizedBox(height: 14),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FBFF),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFD7E6FF)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEAF2FF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.emoji_events_rounded, color: Color(0xFF2456D3)),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'Winner',
                                          style: TextStyle(fontSize: 12, color: Colors.black54),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          winner.userName ?? '--',
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '₹${winner.amount ?? '0'}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF2456D3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(
                    'Participants',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 6),
                if (participants.isEmpty)
                  const NoInternetOrDataScreenWidget(
                    isNoInternet: false,
                    message: 'no_data_found',
                    icon: Images.noData,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    iconSize: 60,
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: participants.length,
                    itemBuilder: (context, index) {
                      final ClaimParticipant participant = participants[index];
                      final Color color = cardColors[index % cardColors.length];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Amount: ₹${participant.amount ?? '0'}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: <Widget>[
                                  if (participant.isMyBid ?? false)
                                    _pill('My bid', color),
                                  if (participant.isWinner ?? false)
                                    _pill('Winner', const Color(0xFF14B87A)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Created On ${_formatDate(participant.createdAt)}',
                                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                              ),
                              const SizedBox(height: 12),
                              const Divider(height: 1),
                              const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey.shade400),
                                ),
                                child: Center(
                                  child: Text(
                                    participant.gameId ?? '--',
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
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
        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _overviewItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) {
      return '--';
    }

    try {
      return DateConverter.dateTimeStringToDateAndTime(date);
    } catch (_) {
      return date;
    }
  }
}
