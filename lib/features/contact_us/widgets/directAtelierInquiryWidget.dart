import 'package:dokkan/core/res/color_manager.dart';
import 'package:dokkan/core/res/sizes_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DirectAtelierInquiryWidget extends StatelessWidget {
  const DirectAtelierInquiryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorM.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorM.cardBackground),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "Direct Atelier Inquiry",
            style: TextStyle(fontSize: SizeM.cardBorderRadius, fontWeight: FontWeight.bold),
          ),
          Gap(12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorM.cardBackground),
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Bespoke Timepiece Consultation", style: TextStyle(color: ColorM.black, fontWeight: FontWeight.w500)),
                Icon(Icons.keyboard_arrow_down, color: ColorM.cardBackground),
              ],
            ),
          ),
          Gap(12),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Describe your desired customizations or order number...",
              hintStyle: TextStyle(color: ColorM.cardBackground, fontSize: 13),
              filled: true,
              fillColor: ColorM.cardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorM.cardBackground),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorM.cardBackground),
              ),
            ),
          ),
          Gap(12),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:  ColorM.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () {},
              child: const Text(
                "Send Atelier Message",
                style: TextStyle(color: ColorM.backgroundLight, fontSize: SizeM.cardBorderRadius, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}