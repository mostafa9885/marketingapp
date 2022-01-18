import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:marketingapp/Models/Categories%20Model/categories_model.dart';
import 'package:marketingapp/Moduels/Categories%20Product/categories_products.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Components/components.dart';
import 'package:marketingapp/Shared/Components/constant.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_cubit.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return cubit.categoriesModel == null
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
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => categoriesScreenBuilder(
                    cubit.categoriesModel!.data!.data[index], context),
                separatorBuilder: (context, index) =>
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyDivided(color: ColorApp.mainColor.withOpacity(0.2)),
                    ),
                itemCount: cubit.categoriesModel!.data!.data.length,
              );
      },
    );
  }
}

Widget categoriesScreenBuilder(DataModel dataModel, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: ()
        {
          ShopCubit.get(context).getCategoriesDetailData(dataModel.id!);
          NavigatorTo(context, CategoriesProductsScreen(categoryName: dataModel.name));
        },
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                '${dataModel.image}',
              ),
              height: 100,
              width: 100,
            ),
            const SizedBox(width: 15),
            Text(
                '${dataModel.name}',
                style: bodyText1(context).copyWith(
                    color: ColorApp.blackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                ),
            ),
            const Spacer(),
            IconButton(
                onPressed: ()
                {
                  ShopCubit.get(context).getCategoriesDetailData(dataModel.id!);
                  NavigatorTo(context, CategoriesProductsScreen(categoryName: dataModel.name));
                },
                icon: Icon(IconAPP.arrowIcon),
            ),
          ],
        ),
      ),
    );
