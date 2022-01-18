

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:marketingapp/Models/Categories%20Details%20Model/categories_details_model.dart';
import 'package:marketingapp/Moduels/Products%20Details/product_detail_screen.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Components/Toast%20Components/toast_components.dart';
import 'package:marketingapp/Shared/Components/components.dart';
import 'package:marketingapp/Shared/Components/constant.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_cubit.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_states.dart';

class CategoriesProductsScreen extends StatelessWidget {

  final String? categoryName;

  const CategoriesProductsScreen({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if(state is ShopSuccessChangeFavoriteState)
        {
          if(!state.changeFavoriteModel.status!)
          {
            toast(
              message: state.changeFavoriteModel.message!,
              state: ToastState.ERROR,
              context: context,
            );
          }
          else
          {
            toast(
              message: state.changeFavoriteModel.message!,
              state: ToastState.SUCCESS,
              context: context,
            );
          }
        }
      },
      builder: (context, state)
      {

        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('$categoryName'.toUpperCase()),
            titleSpacing: 2,
          ),
          body: cubit.categoriesDetailModel == null
              ? Center(
            child: Container(
              width: 100,
              height: 100,
              child: LiquidCircularProgressIndicator(
                borderWidth: 2,
                center: Text(
                  'Loading...',
                  style: TextStyle(
                      color: ColorApp.blackColor,
                      fontWeight: FontWeight.w800),
                ),
                borderColor: ColorApp.mainColor.withOpacity(0.9),
                backgroundColor: ColorApp.whiteColor,
                value: 0.35,
              ),
            ),
          )
              :
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Products',
                        style: bodyText1(context).copyWith(
                          color: ColorApp.blackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GridView.count(
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        childAspectRatio: 1/1.60,
                        crossAxisCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            cubit.categoriesDetailModel!.data!.Pdata!.length,
                            (index) => cubit.categoriesDetailModel!.data!.Pdata!.isEmpty
                            ?
                            const Text('No Items, it\'s Coming Soon')
                            :
                            itemBuild(cubit.categoriesDetailModel!.data!.Pdata![index], context)
                        ),
                    ),
                  ],
                ),
              )
        );
      },
    );
  }
}

Widget itemBuild(DataCategories dataCategories, context) => InkWell(
  onTap: ()
  {
    ShopCubit.get(context).getProductDetails(dataCategories.id.toString());
    NavigatorTo(context, ProductDetails(dataCategories.id));
  },
  child: Container(
    color: ColorApp.whiteColor,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:
          [
            Image(
              image: NetworkImage('${dataCategories.image}'),
              width: double.infinity,
              height: 200,
            ),
            if(dataCategories.discount !=0)
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
                '${dataCategories.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text('${dataCategories.price.round()}'),
                  const SizedBox(width: 10),
                  if(dataCategories.discount != 0)
                    Text(
                      '${dataCategories.oldPrice.round()}',
                      style: TextStyle(
                        color: ColorApp.greyColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(dataCategories.id!);
                    },
                    icon:
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: ShopCubit.get(context).favorites[dataCategories.id!]!
                          ?
                          ColorApp.mainColor
                          :
                          ColorApp.greyColor.withOpacity(0.2) ,
                      child: Icon(
                        IconAPP.borderFavoriteIcon,
                        color: ShopCubit.get(context).favorites[dataCategories.id!]!
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
  ),
);