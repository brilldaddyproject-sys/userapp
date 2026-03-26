import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/screens/cart_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_claim_page.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/cart_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

class BottomCartWidget extends StatefulWidget {
  final ProductDetailsModel? product;
  const BottomCartWidget({super.key, required this.product});

  @override
  State<BottomCartWidget> createState() => _BottomCartWidgetState();
}

class _BottomCartWidgetState extends State<BottomCartWidget> {
  bool vacationIsOn = false;
  bool temporaryClose = false;

  @override
  void initState() {
    super.initState();

    final today = DateTime.now();

    if (widget.product!.addedBy == 'admin') {
      DateTime vacationDate = Provider.of<SplashController>(context, listen: false).configModel?.inhouseVacationAdd?.vacationEndDate != null
          ? DateTime.parse(Provider.of<SplashController>(context, listen: false).configModel!.inhouseVacationAdd!.vacationEndDate!)
          : DateTime.now();

      DateTime vacationStartDate = Provider.of<SplashController>(context, listen: false).configModel?.inhouseVacationAdd?.vacationStartDate != null
          ? DateTime.parse(Provider.of<SplashController>(context, listen: false).configModel!.inhouseVacationAdd!.vacationStartDate!)
          : DateTime.now();

      final difference = vacationDate.difference(today).inDays;
      final startDate = vacationStartDate.difference(today).inDays;

      if (difference >= 0 && (Provider.of<SplashController>(context, listen: false).configModel?.inhouseVacationAdd?.status == 1) && startDate <= 0) {
        vacationIsOn = true;
      } else {
        vacationIsOn = false;
      }
    } else if (widget.product != null && widget.product!.seller != null && widget.product!.seller!.shop!.vacationEndDate != null) {
      DateTime vacationDate = DateTime.parse(widget.product!.seller!.shop!.vacationEndDate!);
      DateTime vacationStartDate = DateTime.parse(widget.product!.seller!.shop!.vacationStartDate!);
      final difference = vacationDate.difference(today).inDays;
      final startDate = vacationStartDate.difference(today).inDays;

      if (difference >= 0 && widget.product!.seller!.shop!.vacationStatus! && startDate <= 0) {
        vacationIsOn = true;
      } else {
        vacationIsOn = false;
      }
    }

    if (widget.product!.addedBy == 'admin') {
      if (widget.product != null && (Provider.of<SplashController>(context, listen: false).configModel?.inhouseTemporaryClose?.status == 1)) {
        temporaryClose = true;
      } else {
        temporaryClose = false;
      }
    } else {
      if (widget.product != null && widget.product!.seller != null && widget.product!.seller!.shop!.temporaryClose!) {
        temporaryClose = true;
      } else {
        temporaryClose = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showClaimButton = widget.product?.isClaim == 1;
    final ProductDetailsModel? product = widget.product;
    final int totalSlots = product?.totalSlots ?? 0;
    final int filledSlots = product?.filledSlots ?? 0;
    final int remainingSlots = product?.remainingSlots ?? 0;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        Dimensions.paddingSizeDefault,
        Dimensions.paddingSizeDefault,
        Dimensions.paddingSizeDefault,
        Dimensions.paddingSizeDefault,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (showClaimButton) ...<Widget>[
              _ClaimSlotsSummary(
                totalSlots: totalSlots,
                filledSlots: filledSlots,
                remainingSlots: remainingSlots,
              ),
              const SizedBox(height: 10),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _CartShortcutButton(),
                const SizedBox(width: Dimensions.paddingSizeDefaultAddress),
                if (showClaimButton) ...<Widget>[
                  Flexible(
                    flex: 10,
                    child: _ClaimNowButton(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductClaimPage(product: widget.product!),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  flex: showClaimButton ? 15 : 1,
                  child: _BottomActionButton(
                    text: getTranslated('add_to_cart', context) ?? 'Add to cart',
                    backgroundColor: Theme.of(context).primaryColor,
                    textColor: Provider.of<ThemeController>(context, listen: false).darkTheme
                        ? Theme.of(context).hintColor
                        : Theme.of(context).highlightColor,
                    borderRadius: 18,
                    onTap: () {
                      if (vacationIsOn || temporaryClose) {
                        showCustomSnackBar(getTranslated('this_shop_is_close_now', context), context, isToaster: true);
                      } else {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0),
                          builder: (con) => CartBottomSheetWidget(
                            product: widget.product,
                            callback: () {
                              showCustomSnackBar(getTranslated('added_to_cart', context), context, isError: false);
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CartShortcutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE7EBF3)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartScreen())),
                child: Center(
                  child: Image.asset(
                    Images.cartArrowDownImage,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -2,
            top: -2,
            child: Consumer<CartController>(
              builder: (context, cart, child) {
                return Container(
                  height: ResponsiveHelper.isTab(context) ? 26 : 22,
                  width: ResponsiveHelper.isTab(context) ? 26 : 22,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFFFF6B6B), Color(0xFFE03131)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Text(
                    cart.cartList.length.toString(),
                    style: textRegular.copyWith(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ClaimSlotsSummary extends StatelessWidget {
  final int totalSlots;
  final int filledSlots;
  final int remainingSlots;

  const _ClaimSlotsSummary({
    required this.totalSlots,
    required this.filledSlots,
    required this.remainingSlots,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFFFBFCFF), Color(0xFFF3F7FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFDCE6FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.local_offer_rounded, color: Color(0xFF2456D3), size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Claim slots overview',
                      style: titilliumSemiBold.copyWith(
                        fontSize: 17,
                        color: const Color(0xFF1D2A57),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Track total, filled, and remaining slots before you claim.',
                      style: textRegular.copyWith(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(child: _SlotMetric(label: 'Total slots', value: '$totalSlots', accent: const Color(0xFF2456D3))),
              const SizedBox(width: 6),
              Expanded(child: _SlotMetric(label: 'Filled', value: '$filledSlots', accent: const Color(0xFF14B87A))),
              const SizedBox(width: 6),
              Expanded(child: _SlotMetric(label: 'Remaining', value: '$remainingSlots', accent: const Color(0xFFFF9F1A))),
            ],
          ),
        ],
      ),
    );
  }
}

class _SlotMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color accent;

  const _SlotMetric({
    required this.label,
    required this.value,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: titilliumSemiBold.copyWith(
              fontSize: 15,
              color: accent,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: textRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _ClaimNowButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ClaimNowButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: <Color>[Color(0xFFFFD66B), Color(0xFFFFA726)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x33FFB020),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.bolt_rounded, color: Color(0xFF5A3600), size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Claim now',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: titilliumSemiBold.copyWith(
                    fontSize: 13,
                    color: const Color(0xFF5A3600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double borderRadius;

  const _BottomActionButton({
    required this.text,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          boxShadow: backgroundColor == Theme.of(context).primaryColor
              ? <BoxShadow>[
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.24),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Text(
          text,
          style: titilliumSemiBold.copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
