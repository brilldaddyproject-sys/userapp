import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_asset_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/enums/from_page.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/widgets/social_login_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/domain/models/config_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

import '../../more/screens/html_screen_view.dart';
import '../../splash/domain/models/business_pages_model.dart';

class OtpLoginScreen extends StatefulWidget {
  final bool fromLogout;
  const OtpLoginScreen({super.key, this.fromLogout = false});

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {

  String? countryCode;
  TextEditingController? _phoneNumberController;
  bool _agreed = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
   /* final ConfigModel configModel = Provider.of<SplashController>(context, listen: false).configModel!;
    countryCode ??= CountryCode.fromCountryCode(configModel.countryCode!).dialCode;*/
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

  void _onTermsTap(SplashController provider) {

    Navigator.push(context, MaterialPageRoute(builder: (_) =>
        HtmlViewScreen(
            page: getPageBySlug('terms-and-conditions', provider.defaultBusinessPages))));
    // Open Terms & Conditions screen or dialog
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text('Terms and Conditions'),
    //     content: Text(''),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.pop(context),
    //         child: Text('Close'),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authProvider = Provider.of<AuthController>(context, listen: false);
    final double width = MediaQuery.of(context).size.width;
    final Size size = MediaQuery.of(context).size;
    final ConfigModel configModel = Provider.of<SplashController>(context, listen: false).configModel!;
    final SocialMediaLoginOptions? socialStatus = configModel.customerLogin?.socialMediaLoginOptions;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        Future.delayed(Duration.zero, () {
          if(context.mounted){
            if (Provider.of<AuthController>(context, listen: false).selectedIndex != 0) {
              Provider.of<AuthController>(context, listen: false).updateSelectedIndex(0);
            } else {
              if(Navigator.canPop(context)) {
                Navigator.of(context).pop();
              } else {
                if (widget.fromLogout) {
                  if (!Provider.of<AuthController>(context, listen: false).isLoading) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
                  }
                }
              }
            }
          }
        });

        if(didPop) return;

        Navigator.pop(context);
      },

      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/lg-background.png"),
            fit: BoxFit.fill, // Cover the entire screen
          ),
        ),
        //color: Colors.black26,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                /*Positioned(
                  top: Dimensions.paddingSizeThirtyFive,
                  left:  Provider.of<LocalizationController>(context, listen: false).isLtr ? Dimensions.paddingSizeLarge : null,
                  right: Provider.of<LocalizationController>(context, listen: false).isLtr ? null : Dimensions.paddingSizeLarge,
                  child:InkWell(
                      onTap: (){
                        print(widget.fromLogout);
                        if(widget.fromLogout) {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Icon(Icons.arrow_back_ios, size: 20, color: Theme.of(context).primaryColor))
                ),*/

                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 100,),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white, // Background color
                                borderRadius: BorderRadius.circular(12), // Box radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1), // Optional shadow
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(16), // Inner padding (optional)
                              child: Center(
                                child: Center(
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    SizedBox(height: 10,),
                                    Text("Login",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black87,fontSize: 32),),
                                    SizedBox(height: 0,),
                                    const Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: CustomAssetImageWidget(
                                        Images.logoWithNameImage, width: 150, height: 140, fit: BoxFit.scaleDown,
                                      ),
                                    ),

                                   // SizedBox(height: size.height * 0.1),

                                    Column(children: [

                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: CustomTextFieldWidget(
                                          focusNode: _focusNode,
                                          hintText:"Phone / Email",
                                          isShowBorder: true,
                                          controller: _phoneNumberController,
                                          inputType: TextInputType.emailAddress,
                                          labelText: "Enter Phone / Email",
                                          labelTextStyle:TextStyle(fontSize: 16)
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.03),

                                      Row(
                                        children: [
                                          Checkbox(
                                            value: _agreed,
                                            onChanged: (value) {
                                              setState(() {
                                                _agreed = value!;
                                              });
                                            },
                                          ),
                                          Consumer<SplashController>(
                                            builder: (context, provider, child) {
                                              return Expanded(
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: 'I agree to the ',
                                                    style: const TextStyle(color: Colors.black),
                                                    children: [
                                                      TextSpan(
                                                        text: 'Terms and Conditions',
                                                        style: const TextStyle(
                                                          color: Colors.blue,
                                                          decoration: TextDecoration.underline,
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {
                                                            _onTermsTap(provider); // Make sure this method exists
                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )

                                        ],
                                      ),
                                      SizedBox(height: size.height * 0.03),

                                      Consumer<AuthController>(builder: (context, authProvider, child) {
                                        return !authProvider.isPhoneNumberVerificationButtonLoading? CustomButton(
                                          buttonText : getTranslated('get_otp', context),
                                          onTap: () async {

                                            final input = _phoneNumberController!.text.trim();

                                            if (input.isEmpty) {
                                              showCustomSnackBar(
                                                getTranslated('enter_phone_or_email', context),
                                                context,
                                              );
                                            } else if (!isValidMobileOrEmail(input)) {
                                              showCustomSnackBar(
                                                getTranslated('Enter valid email or phone number', context),
                                                context,
                                              );
                                            } else {
                                              // ✅ Valid input
                                              // Proceed with login / OTP
                                              String phoneWithCountryCode = _phoneNumberController!.text.trim();


                                              if(configModel.customerVerification?.firebase == 1) {
                                                await authProvider.firebaseVerifyPhoneNumber(phoneWithCountryCode, FromPage.otpLogin );
                                              } else {
                                                if(_agreed){
                                                  await authProvider.checkPhoneForOtp(phoneWithCountryCode, FromPage.otpLogin);
                                                }else{
                                                  showCustomSnackBar("Confirm to read terms and condition", context);
                                                }
                                              }
                                            }
                                          }) : Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                          ));
                                      }
                                      ),
                                      const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                                    ]),


                                    if(_isShowSocialLoginButton(configModel, socialStatus))...[
                                      Center(child: Text(
                                        getTranslated('or', context)!,
                                        style: titilliumRegular.copyWith(
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      ),
                                      const SizedBox(height: Dimensions.paddingSizeDefault),

                                      const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge) ,child: SocialLoginWidget()),
                                      const SizedBox(height: Dimensions.paddingSizeLarge),
                                    ],


                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          if (!authProvider.isLoading) {
                                            authProvider.removeGoogleLogIn();
                                            authProvider.getGuestIdUrl();
                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
                                          }
                                        },
                                        child: RichText(text: TextSpan(children: [
                                          TextSpan(text: '${getTranslated('continue_as', context)} ',
                                            style: titilliumRegular.copyWith(
                                              fontSize: Dimensions.fontSizeDefault,
                                              color: Theme.of(context).hintColor,
                                            ),
                                          ),
                                          TextSpan(text: getTranslated('guest', context),
                                            style: titilliumRegular.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: Dimensions.fontSizeDefault,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        ])),
                                      ),
                                    ),

                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidMobileOrEmail(String value) {
    value = value.trim();

    if (value.isEmpty) return false;

    // 📱 Mobile number (10 digits)
    final mobileRegex = RegExp(r'^[6-9]\d{9}$');

    // 📧 Email validation
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    return mobileRegex.hasMatch(value) || emailRegex.hasMatch(value);
  }

}


bool _isShowSocialLoginButton (ConfigModel configModel, SocialMediaLoginOptions? socialStatus){
  return (configModel.customerLogin?.loginOption?.socialMediaLogin == 1)
      && (configModel.customerLogin?.loginOption?.manualLogin != 1)
      && ( (socialStatus?.apple == 1 && defaultTargetPlatform == TargetPlatform.iOS)
          || socialStatus?.google == 1
          || socialStatus?.facebook == 1
      );
}