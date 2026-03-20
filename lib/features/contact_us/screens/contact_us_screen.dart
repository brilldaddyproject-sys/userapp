import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/contact_us/controllers/contact_us_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/contact_us/domain/models/contact_us_body.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/screens/support_ticket_screen.dart';
import 'package:flutter_sixvalley_ecommerce/helper/velidate_check.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:provider/provider.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    Provider.of<AuthController>(context, listen: false).setCountryCode(CountryCode.fromCountryCode(Provider.of<SplashController>(context, listen: false).configModel!.countryCode!).dialCode!, notify: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(centerTitle: true,title: '${getTranslated('contact_us', context)}'),
      body: Consumer<AuthController>(
        builder: (context, authProvider, _) {
          return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
            child: SingleChildScrollView(child: Form(
              key: contactFormKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(children: [

                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        'Get InTouch',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _InfoTile(
                            icon: Icons.phone_android,
                            title: 'Call us',
                            subtitle: '+91 9995124365',
                          ),
                          _InfoTile(
                            icon: Icons.email,
                            title: 'Mail us',
                            subtitle: 'contact@brilldaddy.com',
                          ),
                          _InfoTile(
                            icon: Icons.location_on,
                            title: 'Address',
                            subtitle:
                            'Brilldaddy ECommerce Pvt. Ltd.\nC1, 4th Floor, HQ PLUS, Above Dominos\nNear: Nexus Mall, Koramangala\nBangalore, Karnataka, INDIA - 560029',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width/2,child: Image.asset(Images.contactUsBg)),
                CustomTextFieldWidget(
                  prefixIcon: Images.user,
                  controller: fullNameController,
                  required: true,
                  labelText: getTranslated('full_name', context),
                  hintText: getTranslated('enter_full_name', context),
                  validator: (value)=> ValidateCheck.validateEmptyText(value, 'name_is_required'),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                CustomTextFieldWidget(
                  hintText: getTranslated('email', context),
                    prefixIcon: Images.email,
                    required: true,
                    labelText: getTranslated('email', context),
                    controller: emailController,
                  validator: (value) =>ValidateCheck.validateEmail(value),

                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),


                CustomTextFieldWidget(
                    hintText: getTranslated('enter_mobile_number', context),
                    labelText: getTranslated('enter_mobile_number', context),
                    controller: phoneController,
                    required: true,
                    showCodePicker: true,
                    countryDialCode: authProvider.countryDialCode,
                    onCountryChanged: (CountryCode countryCode) {
                      authProvider.countryDialCode = countryCode.dialCode!;
                      authProvider.setCountryCode(countryCode.dialCode!);
                    },
                    isAmount: true,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.phone,
                  validator: (value)=> ValidateCheck.validateEmptyText(value, 'phone_is_required'),

                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),


                CustomTextFieldWidget(
                  required: true,
                  labelText: getTranslated('subject', context),
                  hintText: getTranslated('subject', context),
                  controller: subjectController,
                  validator: (value)=> ValidateCheck.validateEmptyText(value, 'subject_is_required'),

                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),


                CustomTextFieldWidget(maxLines: 5,
                    required: true,
                    controller: messageController,
                    labelText: getTranslated('message', context),
                    hintText: getTranslated('message', context),
                  validator: (value)=> ValidateCheck.validateEmptyText(value, 'message_is_required'),

                ),
              ],),
            )),
          );
        }
      ),
      bottomNavigationBar: Consumer<ContactUsController>(
        builder: (context, profileProvider, _) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CustomButton(
              isLoading: profileProvider.isLoading,
              buttonText: getTranslated('send_request', context),
              onTap: (){
                if(contactFormKey.currentState?.validate() ?? false) {

                  String name = fullNameController.text.trim();
                  String email = emailController.text.trim();
                  String phone = phoneController.text.trim();
                  String subject = subjectController.text.trim();
                  String message = messageController.text.trim();

                  ContactUsBody contactUsBody = ContactUsBody(name: name, email: email, phone: phone, subject: subject, message: message);

                   profileProvider.contactUs(contactUsBody).then((isSuccess){
                     if(isSuccess && context.mounted) {
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SupportTicketScreen()));

                     }


                  });
                }


              },
            ),
          );
        }
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.purple,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}