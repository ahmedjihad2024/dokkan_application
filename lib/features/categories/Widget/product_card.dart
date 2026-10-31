import 'package:dokkan/core/res/color_manager.dart';
import 'package:dokkan/core/res/fonts_manager.dart';
import 'package:dokkan/core/res/sizes_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorM.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color:ColorM.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&auto=format&fit=crop&q=60',
                      fit: BoxFit.contain,
                    ),
                  ),)
          ),
          
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: ColorM.warning),
                    Gap(4),
                    Text("4.9 (42)", style: TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
                Gap(4),
                
                Text(
                  "Milanese Gold Mesh",
                  style: TextStyle(fontWeight:FontWeightM.bold),
                  maxLines: 1,
                  
                ),
                Gap(6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$185.00",
                      style: TextStyle(fontWeight: FontWeightM.bold),
                    ),

                    SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        onPressed: () {},

                        style: IconButton.styleFrom(
                          backgroundColor: ColorM.backgroundDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          
                        ),
                        icon: const Icon(Icons.add, color: ColorM.backgroundLight, size: SizeM.buttonBorderRadius),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}