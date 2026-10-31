import 'package:dokkan/core/res/color_manager.dart';
import 'package:dokkan/core/res/fonts_manager.dart';
import 'package:dokkan/core/res/sizes_manager.dart';
import 'package:dokkan/features/categories/Widget/collectionCard.dart';
import 'package:dokkan/features/contact_us/widgets/contactInfoCard.dart';
import 'package:dokkan/features/contact_us/widgets/directAtelierInquiryWidget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreen();
}

class _ContactUsScreen extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorM.backgroundLight,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: ColorM.backgroundLight,
              shape: CircleBorder(),
            ),
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
          ),
        ),
        title: Text("Contact Us"),
      ),
      body:
       SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8,left: 24,right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Text(
                  "Our atelier advisors are available 7 days a week for bespoke consultations and order assistance.",
                  style: TextStyle(fontSize: SizeM.commonBorderRadius),
                  ),
              ),

             ContactInfoCard(
              icon: Icons.mail_outline, 
              title: "Concierge Email", 
              subtitle: "concierge@dokkan-atelier.com", 
              footer: "Replies within 2 hours"),

              Gap(12),

             ContactInfoCard(
              icon: Icons.phone_outlined, 
              title: "Atelier Hotline", 
              subtitle: "+971 4 800 DOKKAN", 
              footer: "Mon-Sat 8AM-8PM GST"),

              Gap(12),

             ContactInfoCard(
              icon: Icons.location_on_outlined, 
              title: "Flagship Boutique", 
              subtitle: "Atelier 42, Design District, Dubai", 
              footer: "Private viewings by booking"),

              Gap(10),

             
              DirectAtelierInquiryWidget()
              
             
              ],
            
          ),
        ),
      ),
    );
  }
}
