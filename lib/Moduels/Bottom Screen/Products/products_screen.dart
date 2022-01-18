

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Components/Product%20Builder%20Components/product_builder.dart';
import 'package:marketingapp/Shared/Components/Toast%20Components/toast_components.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_cubit.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

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

        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context) => productBuilder(cubit.homeModel!, context, cubit.categoriesModel!),
            fallback: (context) => Center(
              child: Container(
                width: 100,
                height: 100,
                child: LiquidCircularProgressIndicator(
                  borderWidth: 2,
                  center: Text('Loading...' , style: TextStyle(color: ColorApp.blackColor, fontWeight: FontWeight.w800),),
                  borderColor: ColorApp.mainColor.withOpacity(0.9),
                  backgroundColor: ColorApp.whiteColor,
                  value: 0.35,
                ),
              )
            ),
        );
      },
    );
  }
}


