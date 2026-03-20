import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/faq_expansion_tile_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';
class FaqScreen extends StatefulWidget {
  final String? title;
  const FaqScreen({super.key, required this.title});

  @override
  FaqScreenState createState() => FaqScreenState();
}

class FaqScreenState extends State<FaqScreen> {

  final List<Map<String, dynamic>> faqs = [
    {
      "category": "Ordering & Payments",
      "items": [
        {
          "q": "How do I place an order?",
          "a": "Browse products, select items, add to cart, and proceed to checkout."
        },
        {
          "q": "What payment methods do you accept?",
          "a": "We accept credit/debit cards, net banking, UPI and Wallet."
        },
        {
          "q": "Is my payment secure?",
          "a": "Yes, we use secure payment gateways for encrypted transactions."
        },
      ]
    },
    {
      "category": "Order & Delivery",
      "items": [
        {
          "q": "How long does delivery take?",
          "a":
          "Delivery times vary based on location and shipping option chosen. You can check our shipping policy."
        },
        {
          "q": "Can I track my order?",
          "a": "Yes, you'll receive a tracking link post-shipment."
        },
        {
          "q": "What if I'm not available for delivery?",
          "a": "Courier may attempt redelivery or leave at doorstep per policy."
        },
        {
          "q": "Do you deliver outside India?",
          "a": "Check our shipping policy for international delivery options."
        },
      ]
    },
    {
      "category": "Returns & Refunds",
      "items": [
        {
          "q": "Can I return a product?",
          "a": "Yes, returns are allowed per our return policy within 7 days."
        },
        {
          "q": "How do I initiate a return?",
          "a":
          "Contact customer support with order details. You can also upload an unboxing video and details in our system."
        },
        {
          "q": "When will I get a refund?",
          "a":
          "Refunds are typically processed within 15 business days post return approval."
        },
      ]
    },
    {
      "category": "Product Information",
      "items": [
        {"q": "Are products authentic?", "a": "We ensure genuine and quality products."},
        {"q": "Do you have product warranties?", "a": "Check product details."},
        {"q": "Can I cancel my order?", "a": "Cancellation possible pre-shipment; check policy."},
      ]
    },
    {
      "category": "Account & Security",
      "items": [
        {"q": "How do I reset my password?", "a": "Use 'Forgot Password' on login page."},
        {"q": "Is my personal data safe?", "a": "We follow privacy policies to protect data."},
        {"q": "Can I update my address?", "a": "Yes, update in account settings or contact support."},
      ]
    },
    {
      "category": "Customer Support",
      "items": [
        {"q": "How do I contact customer support?", "a": "Email/Phone/Chat options available on our system."},
        {"q": "What are your support hours?", "a": "24/7"},
      ]
    },
    {
      "category": "India-Specific",
      "items": [
        {"q": "Do you offer COD?", "a": "No."},
        {"q": "Are there GST implications?", "a": "Transactions subject to GST regulations."},
      ]
    },
  ];
 
  @override
  Widget build(BuildContext context) {
    var splashController = Provider.of<SplashController>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [

          CustomAppBar(title: widget.title),
          const SizedBox(height: Dimensions.paddingSizeDefault,),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              var category = faqs[index];
              return _buildCategory(category["category"], category["items"]);
            },
          )
         /* splashController.configModel!.faq != null && splashController.configModel!.faq!.isNotEmpty? Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: Provider.of<SplashController>(context, listen: false).configModel!.faq!.length,
                itemBuilder: (ctx, index){
                  return  Consumer<SplashController>(
                    builder: (ctx, faq, child){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
                        child: Card(
                          elevation: Dimensions.paddingSizeExtraSmall,
                          shadowColor: Theme.of(context).highlightColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                          color: Theme.of(context).cardColor,
                          child: FaqExpansionTileWidget(index: index, faq: faq),

                        )
                      );
                    },
                  );
                }),
          ): const NoInternetOrDataScreenWidget(isNoInternet: false)*/

        ],),
      ),
    );
  }
  Widget _buildCategory(String title, List items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 8),
              ...items.map((faq) => _buildFAQItem(faq)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, String> faq) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 8),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(
        faq["q"]!,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      iconColor: Colors.green,
      collapsedIconColor: Colors.black54,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            faq["a"]!,
            style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
        ),
      ],
    );
  }
}
