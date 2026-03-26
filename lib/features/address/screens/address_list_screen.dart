import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/controllers/address_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/domain/models/address_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/widgets/address_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/widgets/remove_address_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/screens/add_new_address_screen.dart';
import 'package:provider/provider.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});
  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {

  @override
  void initState() {
    Provider.of<AddressController>(context, listen: false).getAddressList(all: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('addresses', context)),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddNewAddressScreen(isBilling: false))),
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.add_rounded, color: Theme.of(context).highlightColor),
        label: Text(
          'Add address',
          style: textBold.copyWith(color: Theme.of(context).highlightColor),
        ),
      ),


      body: Consumer<AddressController>(
        builder: (context, locationProvider, child) {
          return  locationProvider.addressList != null? locationProvider.addressList!.isNotEmpty ?
          RefreshIndicator(onRefresh: () async => await locationProvider.getAddressList(),
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            child: ListView.builder(padding: const EdgeInsets.all(0),
              itemCount: locationProvider.addressList?.length,
              itemBuilder: (context, index){
              final AddressModel address = locationProvider.addressList![index];
              final bool isDefault = address.id == locationProvider.defaultAddressId;
              final bool isDefaultLoading = address.id == locationProvider.defaultAddressLoadingId;
              final String addressType = (address.addressType?.isNotEmpty ?? false) ? address.addressType! : 'Address';

              return Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeDefault,
                  0,
                ),
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  decoration: BoxDecoration(
                    gradient: isDefault
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context).primaryColor.withValues(alpha: .12),
                              Theme.of(context).cardColor,
                            ],
                          )
                        : null,
                    color: isDefault ? null : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isDefault
                          ? Theme.of(context).primaryColor.withValues(alpha: .35)
                          : Theme.of(context).dividerColor.withValues(alpha: .15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .05),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withValues(alpha: .10),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.location_on_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        address.contactPersonName?.isNotEmpty == true
                                            ? address.contactPersonName!
                                            : addressType,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textBold.copyWith(
                                          fontSize: Dimensions.fontSizeLarge,
                                          color: Theme.of(context).textTheme.bodyLarge?.color,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: isDefault
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).primaryColor.withValues(alpha: .08),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        isDefault ? 'Default' : addressType,
                                        style: textBold.copyWith(
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: isDefault
                                              ? Theme.of(context).highlightColor
                                              : Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  address.address ?? '',
                                  style: textRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context).textTheme.bodyMedium?.color,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _InfoChip(
                                      icon: Icons.location_city_rounded,
                                      label: address.city?.isNotEmpty == true ? address.city! : '--',
                                    ),
                                    _InfoChip(
                                      icon: Icons.markunread_mailbox_rounded,
                                      label: address.zip?.isNotEmpty == true ? address.zip! : '--',
                                    ),
                                    if (address.phone?.isNotEmpty == true)
                                      _InfoChip(
                                        icon: Icons.call_rounded,
                                        label: address.phone!,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            children: [
                              _ActionIconButton(
                                iconAsset: Images.edit,
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => AddNewAddressScreen(
                                      isBilling: address.isBilling,
                                      address: address,
                                      isEnableUpdate: true,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              _CircleIconButton(
                                icon: Icons.delete_forever_rounded,
                                color: Colors.red,
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (_) => RemoveFromAddressBottomSheet(
                                      addressId: address.id!,
                                      index: index,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: (isDefault || isDefaultLoading) ? null : () => locationProvider.setDefaultAddress(address.id),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            color: isDefault
                                ? Theme.of(context).primaryColor.withValues(alpha: .14)
                                : Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDefault
                                  ? Theme.of(context).primaryColor.withValues(alpha: .35)
                                  : Theme.of(context).dividerColor.withValues(alpha: .25),
                            ),
                          ),
                          child: Row(
                            children: [
                              if (isDefaultLoading)
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.4,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              else
                                Icon(
                                  isDefault ? Icons.verified_rounded : Icons.radio_button_unchecked_rounded,
                                  color: isDefault
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).hintColor,
                                  size: 20,
                                ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  isDefaultLoading
                                      ? 'Setting default address...'
                                      : isDefault
                                          ? 'Default address selected'
                                          : 'Set default address',
                                  style: textBold.copyWith(
                                    color: (isDefault || isDefaultLoading)
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).textTheme.bodyLarge?.color,
                                  ),
                                ),
                              ),
                              if (isDefault && !isDefaultLoading)
                                Text(
                                  'Active',
                                  style: textBold.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              },
            ),
          ) : const NoInternetOrDataScreenWidget(isNoInternet: false,
            message: 'no_address_found',
            icon: Images.noAddress,): const AddressShimmerWidget();
        },
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: .06),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: Theme.of(context).primaryColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: textRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  final String iconAsset;
  final VoidCallback onTap;

  const _ActionIconButton({required this.iconAsset, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: .08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Image.asset(iconAsset),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: .10),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }
}
