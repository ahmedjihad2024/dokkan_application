import 'package:dokkan/core/res/color_manager.dart';
import 'package:dokkan/features/categories/Widget/collectionCard.dart';
import 'package:dokkan/features/categories/Widget/product_card.dart';
import 'package:flutter/material.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  const ProductsByCategoryScreen({super.key});

  @override
  State<ProductsByCategoryScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<ProductsByCategoryScreen> {
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
        title: Text("Luxury Timepieces"),
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
                child: Text("24 verified models in stock"),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0, 
                    mainAxisSpacing: 12.0, 
                    childAspectRatio: 0.8,
                
                    ) , 
                  itemBuilder: (context,index){
                    return  ProductCard();
                  }),
              )
              ],
            
          ),
        ),
      ),
    );
  }
}
