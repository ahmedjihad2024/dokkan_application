import 'package:dokkan/core/res/color_manager.dart';
import 'package:dokkan/core/res/fonts_manager.dart';
import 'package:dokkan/core/res/sizes_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Collectioncard extends StatelessWidget {
  const Collectioncard({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: ColorM.cardBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorM.cardborder),
        boxShadow: [
          BoxShadow(
           color: ColorM.cardborder.withOpacity(0.05),
          )]
        ),
      
      child: 
      Column(
           mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // icon
        Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorM.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.access_time_rounded,
              color: ColorM.backgroundDark,
              size: SizeM.pagePaddingLarge,
            ),),
            Gap(14),

            //name

            Text("Timepieces",style: TextStyle(fontWeight: FontWeightM.black),),
            Gap(2),
            Text("Automatic & quartz",style: TextStyle(fontWeight: FontWeightM.thin),),
            Gap(8),

            Container(
              decoration: BoxDecoration(
                color: ColorM.textMutedDark,
                borderRadius: BorderRadius.circular(12)
              ),
              child:
            Padding(
              padding: const EdgeInsets.only(top: 4,bottom: 4,right: 8,left: 8),
              child: Text("50 Items",style: TextStyle(fontWeight: FontWeightM.bold,color: ColorM.primary),),
            ),)

      ],)
    
    ,);
  }
}