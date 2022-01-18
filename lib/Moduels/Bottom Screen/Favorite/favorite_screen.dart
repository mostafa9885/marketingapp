

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:marketingapp/Models/Get%20Favorites%20Model/get_favorite_model.dart';
import 'package:marketingapp/Models/Home%20Model/home_model.dart';
import 'package:marketingapp/Moduels/Products%20Details/product_detail_screen.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Components/components.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_cubit.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var cubit = ShopCubit.get(context);

        return cubit.favoritesModel == null
        ?
        Center(
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
        cubit.favoritesModel!.data!.data.isEmpty
        ?
        const Text('')
        :
        ListView.separated(
         physics: const BouncingScrollPhysics(),
         itemBuilder: (context, index) => favoriteBuildItem(
           cubit.favoritesModel!.data!.data[index],
           context,
         ),
         separatorBuilder: (context, index) => Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20),
           child: MyDivided(color: ColorApp.blackColor.withOpacity(0.3)),
         ),
         itemCount: cubit.favoritesModel!.data!.data.length,
       );
      },
    );
  }
}

Widget favoriteBuildItem(FavoriteData? favoritesData, context) => InkWell(
  onTap: ()
  {
    ShopCubit.get(context).getProductDetails(favoritesData!.id.toString());
    NavigatorTo(context, ProductDetails(favoritesData.product!.id));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:
            [
              Image(
                image: NetworkImage('${favoritesData?.product!.image}'),
                width: 120,
                height: 120,
              ),
              if(favoritesData?.product!.discount !=0)
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
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text(
                  '${favoritesData?.product!.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                        '${favoritesData?.product!.price}'
                    ),
                    const SizedBox(width: 10),
                    if(favoritesData?.product!.discount != 0)
                      Text(
                        '(${favoritesData?.product!.oldPrice})',
                        style: TextStyle(
                          color: ColorApp.greyColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(favoritesData!.product!.id!);
                      },
                      icon:
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: ShopCubit.get(context).favorites[favoritesData?.product!.id]!
                            ?
                            ColorApp.mainColor
                            :
                            ColorApp.greyColor.withOpacity(0.3) ,
                        child: Icon(
                          IconAPP.borderFavoriteIcon,
                          color: ShopCubit.get(context).favorites[favoritesData?.product!.id]!
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
  ),
);
