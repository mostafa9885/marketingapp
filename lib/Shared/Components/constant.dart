
import 'package:flutter/material.dart';

TextStyle bodyText1(BuildContext context) => Theme.of(context).textTheme.bodyText1!.copyWith(color:Colors.grey[600]);
TextStyle? headline5(BuildContext context) => Theme.of(context).textTheme.headline5;



// void signOut (context)
// {
//   CacheHelper.removeData(key: 'token');
//   Token = null;
//   var model = ShopCubit.get(context).userModel;
//   model!.data!.name = '';
//   model.data!.email = '';
//   model.data!.phone = '';
//   NavigateAnfFinish(context, ShopLogin());
//   ShopCubit.get(context).currentIndex =0;
// }
