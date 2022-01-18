import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:marketingapp/Models/Products%20Details/product_details_model.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Components/constant.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_cubit.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatelessWidget {
  final id;

  ProductDetails(this.id);

  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopCubit>(context)..getProductDetails(id.toString()),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = ShopCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Product Details'),
            ),
            body: state is ShopLoadingGetProductDetailsState
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
                : cubit.productDetailsModel == null
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
                    : ProductDetailsItem(cubit.productDetailsModel!, context),
          );
        },
      ),
    );
  }
}

Widget ProductDetailsItem(ProductDetailsModel productDetailsModel, context) {
  List<Widget> images = [];

  productDetailsModel.data!.images.forEach((element) {
    images.add(Image.network(element, fit: BoxFit.contain));
  });

  return ShopCubit.get(context).productDetailsModel == null
      ? Center(
          child: Container(
            width: 100,
            height: 100,
            child: LiquidCircularProgressIndicator(
              borderWidth: 2,
              center: Text(
                'Loading...',
                style: TextStyle(
                    color: ColorApp.blackColor, fontWeight: FontWeight.w800),
              ),
              borderColor: ColorApp.mainColor.withOpacity(0.9),
              backgroundColor: ColorApp.whiteColor,
              value: 0.35,
            ),
          ),
        )
      : Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Text(
                '${productDetailsModel.data!.name}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: headline5(context)!.copyWith(
                  color: ColorApp.blackColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              CarouselSlider(
                items: images,
                options: CarouselOptions(
                    height: 200,
                    initialPage: 0,
                    autoPlay: true,
                    reverse: false,
                    scrollDirection: Axis.horizontal,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    viewportFraction: 1,
                    onPageChanged: (val, reason) {
                      ShopCubit.get(context).ChangeValueIndicator(val);
                    }),
              ),
              const SizedBox(height: 15),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: ShopCubit.get(context).pageValue,
                  count: images.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.black26,
                    dotHeight: 8,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 3,
                    activeDotColor: mainColor,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Price: ${productDetailsModel.data!.price} ILS ',
                    style: headline5(context)!
                        .copyWith(color: ColorApp.blackColor, fontSize: 17),
                  ),
                  const SizedBox(width: 5),
                  if (productDetailsModel.data!.discount != 0)
                    Text(
                      '(${productDetailsModel.data!.oldPrice})',
                      style: headline5(context)!.copyWith(
                        color: ColorApp.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(productDetailsModel.data!.id!);
                      print(productDetailsModel.data!.id);
                    },
                    icon:
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: ShopCubit.get(context).favorites[productDetailsModel.data!.id!]!
                          ?
                      ColorApp.mainColor
                          :
                      ColorApp.greyColor.withOpacity(0.2),
                      child: Icon(
                        IconAPP.borderFavoriteIcon,
                        color: ShopCubit.get(context).favorites[productDetailsModel.data!.id!]!
                            ?
                        ColorApp.whiteColor
                            :
                        ColorApp.blackColor,
                        size: 20,
                      ),
                    ),

                  ),

                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Description',
                style: headline5(context)!.copyWith(
                  color: ColorApp.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${productDetailsModel.data!.description}',
                style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    fontWeight: FontWeight.w300,
                    color: ColorApp.blackColor,
                ),
              ),
            ],
          ),
        );
}
