
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:marketingapp/Moduels/FAQS%20Screen/faqs_screen.dart';
import 'package:marketingapp/Moduels/Profile/profile_screen.dart';
import 'package:marketingapp/Moduels/Shop%20Login/shop_login.dart';
import 'package:marketingapp/Network/End%20Point/end_point.dart';
import 'package:marketingapp/Network/Local/cache_helper.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Components/components.dart';
import 'package:marketingapp/Shared/Components/constant.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_cubit.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state)
      {

        var cubit = ShopCubit.get(context);

        return cubit.userModel == null && state is ShopLoadingUpdateUserDataState
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
            Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text(
                        'Hi, ${cubit.userModel?.data?.name!}',
                        style: bodyText1(context).copyWith(
                            color: ColorApp.blackColor,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${cubit.userModel?.data?.email!}',
                        style: bodyText1(context).copyWith(
                            color: ColorApp.blackColor,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 45,
                  color: ColorApp.greyColor.withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Account Information'.toUpperCase(),
                          style: bodyText1(context).copyWith(color: ColorApp.blackColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 7),
                  child: Column(
                    children:
                    [
                      Row(
                        children:
                        [
                          Icon(IconAPP.addShoppingCart),
                          const SizedBox(width: 10),
                          Text(
                            'Review Cart',
                            style: bodyText1(context).copyWith(
                              color: ColorApp.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Arrowicon(
                            onPressed: (){}
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children:
                        [
                          Icon(IconAPP.reorderSharp),
                          const SizedBox(width: 10),
                          Text(
                            'My Orders',
                            style: bodyText1(context).copyWith(
                                color: ColorApp.blackColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          const Spacer(),
                          Arrowicon(
                              onPressed: (){},
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: ()
                        {
                          cubit.getUserData();
                          NavigatorTo(context, ProfileScreen());
                        },
                        child: Row(
                          children:
                          [
                            Icon(IconAPP.accountCircleOutlined),
                            const SizedBox(width: 10),
                            Text(
                              'Profile',
                              style: bodyText1(context).copyWith(
                                  color: ColorApp.blackColor,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            const Spacer(),
                            Arrowicon(
                              onPressed: ()
                              {
                                cubit.getUserData();
                                NavigatorTo(context, ProfileScreen());
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Container(
                  height: 45,
                  color: ColorApp.greyColor.withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Settings'.toUpperCase(),
                          style: bodyText1(context).copyWith(color: ColorApp.blackColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 7),
                  child: Column(
                    children:
                    [
                      Row(
                        children:
                        [
                          Icon(IconAPP.brightness6Outlined),
                          const SizedBox(width: 10),
                          Text(
                            'Dark Mode',
                            style: bodyText1(context).copyWith(
                              color: ColorApp.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Arrowicon(
                            onPressed: (){},
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children:
                        [
                          Icon(IconAPP.flagOutlined),
                          const SizedBox(width: 10),
                          Text(
                            'Country',
                            style: bodyText1(context).copyWith(
                                color: ColorApp.blackColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          const Spacer(),
                          Arrowicon(
                            onPressed: (){},
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children:
                        [
                          Icon(IconAPP.languageOutlined),
                          const SizedBox(width: 10),
                          Text(
                            'Language',
                            style: bodyText1(context).copyWith(
                                color: ColorApp.blackColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          const Spacer(),
                          Arrowicon(
                            onPressed: (){},
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Container(
                  height: 45,
                  color: ColorApp.greyColor.withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Connect with us'.toUpperCase(),
                          style: bodyText1(context).copyWith(color: ColorApp.blackColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 7),
                  child: Column(
                    children:
                    [
                      InkWell(
                        onTap: ()
                        {
                          cubit.getFAQSData();
                          NavigatorTo(context, const FAQSScreen());
                        },
                        child: Row(
                          children:
                          [
                            Icon(IconAPP.contactSupportOutlined),
                            const SizedBox(width: 10),
                            Text(
                              'FAQs',
                              style: bodyText1(context).copyWith(
                                color: ColorApp.blackColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Arrowicon(
                              onPressed:()
                              {
                                cubit.getFAQSData();
                                NavigatorTo(context, const FAQSScreen());
                              },
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children:
                        [
                          Icon(IconAPP.contactPhoneOutlined),
                          const SizedBox(width: 10),
                          Text(
                            'Connect with us',
                            style: bodyText1(context).copyWith(
                                color: ColorApp.blackColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          const Spacer(),
                          Arrowicon(
                            onPressed: (){}
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                MyDivided(color: ColorApp.greyColor.withOpacity(0.4)),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: ()
                    {
                      signOut(context);
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorApp.greyColor.withOpacity(0.2),
                      ),

                      height: 45,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text(
                            'Sign Out',
                            style: TextStyle(
                                color: ColorApp.blackColor,
                                fontSize: 16
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}


void signOut (context)
{
  CacheHelper.removeData(key: 'token');
  Token =null;
  var model = ShopCubit.get(context).userModel;
  model!.data!.name = '';
  model.data!.email = '';
  model.data!.phone = '';
  NavigateAnfFinish(context, ShopLogin());
  ShopCubit.get(context).currentIndex =0;
}

Widget Arrowicon({required Function()? onPressed}) => IconButton(
  onPressed: onPressed,
  icon: Icon(
    IconAPP.arrowIcon,
    size: 19,
    color: ColorApp.blackColor.withOpacity(0.7),
  ),
  padding: EdgeInsets.zero,
);

