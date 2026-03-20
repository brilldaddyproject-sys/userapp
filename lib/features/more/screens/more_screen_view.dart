import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/login_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/blog/screens/blog_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/screens/disclaimer_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/screens/guest_track_order_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/screens/profile_screen1.dart';
import 'package:flutter_sixvalley_ecommerce/features/restock/screens/restock_list_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/domain/models/business_pages_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/screens/support_ticket_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/screen/my_vouchers_list_page.dart';
import 'package:flutter_sixvalley_ecommerce/features/vouchers/screen/voucher_winners_page.dart';
import 'package:flutter_sixvalley_ecommerce/features/wallet/controllers/wallet_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/logout_confirm_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/inbox_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/screens/category_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/compare/screens/compare_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/contact_us/screens/contact_us_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/coupon/screens/coupon_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/screens/html_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/profile_info_section_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/more_horizontal_section_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/screens/notification_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/screens/address_list_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/refer_and_earn/screens/refer_and_earn_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/setting/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import 'faq_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/title_button_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late bool isGuestMode;
  String? version;
  bool singleVendor = false;


  @override
  void initState() {
    isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    if(Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
      version = Provider.of<SplashController>(context,listen: false).configModel!.softwareVersion ?? 'version';
      Provider.of<ProfileController>(context, listen: false).getUserInfo(context);

    }
    singleVendor = Provider.of<SplashController>(context, listen: false).configModel!.businessMode == "single";
    if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){
      Provider.of<WishListController>(context, listen: false).getWishList();
      Provider.of<WalletController>(context, listen: false).getTransactionList(1,isUpdate:false);
    }
    Provider.of<SplashController>(context,listen: false).getBusinessPagesList("default");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var authController = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
            floating: true,
            elevation: 0,
            expandedHeight: 160,
            pinned: true,
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).highlightColor,
          collapsedHeight: 160,
          flexibleSpace: const ProfileInfoSectionWidget()),

          SliverToBoxAdapter(child: Container(decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [


              const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Center(child: MoreHorizontalSection())),




              Padding(padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeDefault,  Dimensions.paddingSizeDefault,0),
                child: Text(getTranslated('general', context)??'',
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                      color: Colors.black87), ),),

              Consumer<SplashController>(
                builder: (context, splashController, _) {
                  return Padding(padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Container(padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),
                              boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withValues(alpha:.05),
                                  blurRadius: 1, spreadRadius: 1, offset: const Offset(0,1))],
                              color: Provider.of<ThemeController>(context).darkTheme ?
                              Colors.white.withValues(alpha:.05) : Theme.of(context).cardColor),
                          child: Column(children: [
                            Provider.of<AuthController>(context, listen: false).isLoggedIn() ?
                            MenuButtonWidget(image: Images.loyaltyPoint, title: "My Vouchers",
                              navigateTo: const MyVouchersListPage(),
                            ):Container(),
                            MenuButtonWidget(image: Images.previewEyeIcon, title: "Voucher Winners",
                              navigateTo: const VoucherWinnersPage(),
                            ),
                            MenuButtonWidget(image: Images.trackOrderIcon, title: getTranslated('TRACK_ORDER', context),
                                navigateTo: const GuestTrackOrderScreen(),
                            ),

                            if(Provider.of<AuthController>(context, listen: false).isLoggedIn())
                              MenuButtonWidget(image: Images.user, title: getTranslated('profile', context),
                                  navigateTo: const ProfileScreen1(),
                              ),

                            MenuButtonWidget(image: Images.address, title: "Address",
                                navigateTo: const AddressListScreen(),
                            ),

                            MenuButtonWidget(image: Images.coupon, title: getTranslated('coupons', context),
                                navigateTo: const CouponList(),
                            ),

                            /*if(!isGuestMode)
                              if(splashController.configModel?.refEarningStatus == "1")
                              MenuButtonWidget(image: Images.refIcon, title: getTranslated('refer_and_earn', context),
                                  isProfile: false,
                                  navigateTo: const ReferAndEarnScreen(),
                              ),*/


                            // MenuButtonWidget(image: Images.category, title: getTranslated('CATEGORY', context),
                            //     navigateTo: const CategoryScreen(),
                            // ),

                            if(Provider.of<AuthController>(context, listen: false).isLoggedIn())
                              MenuButtonWidget(image: Images.restockIcon, title: getTranslated('restock_requests', context),
                                  navigateTo: const RestockListScreen(),
                              ),

                            if(splashController.configModel!.activeTheme != "default" && authController.isLoggedIn())
                              MenuButtonWidget(image: Images.compare, title: getTranslated('compare_products', context),
                                  navigateTo: const CompareProductScreen(),
                              ),

                            MenuButtonWidget(image: Images.notification, title: getTranslated('notification', context,),
                                isNotification: false,
                                navigateTo: const NotificationScreen(),
                            ),

                            MenuButtonWidget(image: Images.settings, title: getTranslated('settings', context),
                                navigateTo: const SettingsScreen(),
                            ),

                            if(splashController.configModel?.blogUrl?.isNotEmpty ?? false) MenuButtonWidget(
                              image: Images.blogIcon,
                              title: getTranslated('blog', context),
                              navigateTo: BlogScreen(url: splashController.configModel?.blogUrl ?? '',),
                            ),
                          ]),
                      ),
                  );
                }
              ),


              Padding(padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeDefault,  Dimensions.paddingSizeDefault,0),
                  child: Text(getTranslated('help_and_support', context)??'',
                      style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                          color: Colors.black87))),


              Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),
                          boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withValues(alpha:.05),
                              blurRadius: 1, spreadRadius: 1,offset: const Offset(0,1))],
                          color: Provider.of<ThemeController>(context).darkTheme ?
                          Colors.white.withValues(alpha:.05) : Theme.of(context).cardColor),
                      child: Consumer<SplashController>(
                        builder: (context, splashController, _){
                          return Column(children: [

                            singleVendor?const SizedBox():
                            MenuButtonWidget(image: Images.chats, title: getTranslated('inbox', context),
                                navigateTo: const InboxScreen()),

                            MenuButtonWidget(image: Images.callIcon, title: getTranslated('contact_us', context),
                                navigateTo: const ContactUsScreen()),


                            MenuButtonWidget(image: Images.preference, title: getTranslated('support_ticket', context),
                                navigateTo: const SupportTicketScreen()),

                            MenuButtonWidget(image: Images.aboutUs, title: "Disclaimer",
                                navigateTo: DisclaimerScreenView("https://brilldaddy.com/resources/themes/theme_aster/public/assets/img/media/Copyright_Form.pdf")),

                            MenuButtonWidget(image: Images.attachment, title: "Copyright",
                                navigateTo: DisclaimerScreenView("https://brilldaddy.com/resources/themes/theme_aster/public/assets/img/media/Copyright_Cert.pdf")),

                           // if(splashController.defaultBusinessPages != null && splashController.defaultBusinessPages!.isNotEmpty)...[


                           //   if(getPageBySlug('terms-and-conditions', splashController.defaultBusinessPages) != null)
                              MenuButtonWidget(image: Images.termCondition, title: getTranslated('terms_condition', context),
                                navigateTo: HtmlViewScreen(
                                  page: getPageBySlug('terms-and-conditions', splashController.defaultBusinessPages))),


                             // if(getPageBySlug('privacy-policy', splashController.defaultBusinessPages) != null)
                              MenuButtonWidget(image: Images.privacyPolicy, title: getTranslated('privacy_policy', context),
                                navigateTo: HtmlViewScreen(page: getPageBySlug('privacy-policy', splashController.defaultBusinessPages))),


                             // if(getPageBySlug('refund-policy', splashController.defaultBusinessPages) != null)
                                MenuButtonWidget(image: Images.termCondition, title: "Refund & Cancellation Policy",
                                navigateTo: HtmlViewScreen(page: getPageBySlug('refund-policy', splashController.defaultBusinessPages))),

                             // if(getPageBySlug('return-policy', splashController.defaultBusinessPages) != null)
                                MenuButtonWidget(image: Images.termCondition, title: getTranslated('return_policy', context),
                                  navigateTo: HtmlViewScreen(page: getPageBySlug('return-policy', splashController.defaultBusinessPages))),

                             // if(getPageBySlug('cancellation-policy', splashController.defaultBusinessPages) != null)
                                MenuButtonWidget(image: Images.termCondition, title: "Grievance Redressal Policy",
                                  navigateTo: HtmlViewScreen(page : getPageBySlug('cancellation-policy', splashController.defaultBusinessPages))),

                             // if(getPageBySlug('shipping-policy', splashController.defaultBusinessPages) != null)
                                MenuButtonWidget(image: Images.termCondition, title: getTranslated('shipping_policy', context),
                                  navigateTo: HtmlViewScreen(page: getPageBySlug('shipping-policy', splashController.defaultBusinessPages))),
                           // ],


                            MenuButtonWidget(image: Images.faq, title: getTranslated('faq', context),
                                navigateTo: FaqScreen(title: getTranslated('faq', context),)),

                            if(getPageBySlug('about-us', splashController.defaultBusinessPages) != null)
                            MenuButtonWidget(image: Images.user, title: getTranslated('about_us', context),
                              navigateTo: HtmlViewScreen(
                                page : getPageBySlug('about-us', splashController.defaultBusinessPages))),

                            Container(
                              color: Theme.of(context).primaryColor, // Background color similar to image
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      child: const Icon(FontAwesomeIcons.xTwitter, color: Colors.white),
                                  onTap: (){
                                        _launchURL("https://x.com/brilldaddyindia?t=SstK4-I-Wb5g7oLapgdY9A&s=09");
                                  },),
                                  const SizedBox(width: 20),
                                  InkWell(child: Icon(FontAwesomeIcons.linkedinIn, color: Colors.white),
                                  onTap: (){
                                    _launchURL("https://in.linkedin.com/");
                                  },),
                                  const SizedBox(width: 20),
                                  InkWell(child: Icon(FontAwesomeIcons.instagram, color: Colors.white),
                                  onTap: (){
                                    _launchURL("https://www.instagram.com/brilldaddyindia/?igsh=ZXJycWNtejQ5empi#");
                                  },),
                                  const SizedBox(width: 20),
                                  InkWell(child: Icon(FontAwesomeIcons.facebookF, color: Colors.white),
                                  onTap: (){
                                    _launchURL("http://facebook.com/people/Brilldaddy-India/pfbid02dH6L1BFLTuFsP5foBCVb3or3LZzyhvuNHHxM7At513J5");
                                  },),
                                  const SizedBox(width: 20),
                                  InkWell(child: Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
                                  onTap: (){
                                    _launchURL("https://www.whatsapp.com/channel/0029Vb0utaiHQbRv48FXbh2w");
                                  },),
                                ],
                              ),
                            ),
                            if(splashController.businessPages != null && splashController.businessPages!.isNotEmpty)
                            ListView.builder(
                              itemCount: splashController.businessPages?.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return MenuButtonWidget(image: Images.termCondition, title: splashController.businessPages?[index].title,
                                    navigateTo: HtmlViewScreen(page: splashController.businessPages?[index]));
                              }
                            )


                          ]);
                        }
                      ))),


              ListTile(
                  leading: SizedBox(width: 30, child: Image.asset(Images.logOut, color: Theme.of(context).primaryColor,)),
                  title: Text(isGuestMode? getTranslated('sign_in', context)! : getTranslated('sign_out', context)!,
                      style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                  onTap: (){
                    if(isGuestMode){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    } else {
                      showModalBottomSheet(backgroundColor: Colors.transparent,
                          context: context, builder: (_)=>  const LogoutCustomBottomSheetWidget());
                    }
                  },
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                      '${getTranslated('version', context)} ${AppConstants.appVersion}',
                      style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).hintColor),
                  ),
                ]),
              ),
            ]),
          ))
        ],
      ),
    );
  }


  BusinessPageModel? getPageBySlug(String slug, List<BusinessPageModel>? pagesList) {
    BusinessPageModel? pageModel;
    if(pagesList != null && pagesList.isNotEmpty){
      for (var page in pagesList) {
        if(page.slug == slug) {
          pageModel = page;
        }
      }
    }
    return pageModel;
  }

  Future<void> _launchURL(String rUrl) async {
    final Uri url = Uri.parse(rUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

}




