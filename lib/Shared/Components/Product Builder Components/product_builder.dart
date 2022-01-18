import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marketingapp/Models/Categories%20Model/categories_model.dart';
import 'package:marketingapp/Models/Home%20Model/home_model.dart';
import 'package:marketingapp/Moduels/Products%20Details/product_detail_screen.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Components/components.dart';
import 'package:marketingapp/Shared/Components/constant.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_cubit.dart';

Widget productBuilder(HomeModel? homeModel, context, CategoriesModel? categoriesModel)
=> SingleChildScrollView(
  physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel!.data!.banners
                .map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250,
              scrollDirection: Axis.horizontal,
              reverse: false,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlay: true,
              initialPage: 0,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text(
                  'Categories',
                  style: bodyText1(context).copyWith(
                      color: ColorApp.blackColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 100,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoriesItem(categoriesModel!.data!.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(width: 15),
                      itemCount: categoriesModel!.data!.data.length,

                  ),
                ),
                const SizedBox(height: 25),
                Text(
                    'Products',
                    style: bodyText1(context).copyWith(
                      color: ColorApp.blackColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 25,
                    ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.60,
              children: List.generate(
                homeModel.data!.products.length,
                (index) => InkWell(
                  onTap: ()
                  {
                    NavigatorTo(context, ProductDetails(homeModel.data!.products[index].id));
                  },
                  child: gridProductsBuild(homeModel.data!.products[index], context),
                )
              ),
            ),
          ),
        ],
      ),
    );

Widget gridProductsBuild(ProductModel productModel, context)
=> Container(
  color: ColorApp.whiteColor,
  child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:
            [
              Image(
                image: NetworkImage('${productModel.image}'),
                width: double.infinity,
                height: 200,
              ),
              if(productModel.discount !=0)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                ),
                color: ColorApp.redAccent,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                      color: ColorApp.whiteColor,
                      fontSize: 10,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text(
                    '${productModel.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1.3,
                    ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('${productModel.price.round()}'),
                    const SizedBox(width: 10),
                    if(productModel.discount != 0)
                    Text(
                        '${productModel.oldPrice.round()}',
                        style: TextStyle(
                          color: ColorApp.greyColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: ()
                        {
                          ShopCubit.get(context).changeFavorites(productModel.id!);
                          print(productModel.id);
                        },
                        icon:
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: ShopCubit.get(context).favorites[productModel.id!]!
                              ?
                              ColorApp.mainColor
                              :
                              ColorApp.greyColor.withOpacity(0.2),
                          child: Icon(
                              IconAPP.borderFavoriteIcon,
                              color: ShopCubit.get(context).favorites[productModel.id!]!
                                  ?
                                  ColorApp.whiteColor
                                  :
                                  ColorApp.blackColor,
                              size: 20,
                          ),
                        ),

                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
);

Widget buildCategoriesItem(DataModel model)
=> Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children:
  [
    Image(
        image: NetworkImage('${model.image}'),
        width: 100,
        height: 100,
    ),
    Container(
      width: 100,
      color: ColorApp.blackColor,
      child: Text(
          '${model.name}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: ColorApp.whiteColor,
          ),
        textAlign: TextAlign.center,
      ),
    ),
  ],
);

