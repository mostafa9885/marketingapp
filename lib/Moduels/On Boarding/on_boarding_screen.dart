import 'package:flutter/material.dart';
import 'package:marketingapp/Moduels/Shop%20Login/shop_login.dart';
import 'package:marketingapp/Network/Local/cache_helper.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Components/On%20Boarding%20Item/on_boarding_item.dart';
import 'package:marketingapp/Shared/Components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewModel {
  final String? image;
  final String? title;
  final String? body;

  PageViewModel(
    this.image,
    this.title,
    this.body,
  );
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var onBoardingController = PageController();
  bool isLast = false;

  List<PageViewModel> onBoardingModel =
  [
    PageViewModel(
      'assets/images/onBoard_1.jpg',
      'Welcome To Alışveriş',
      'The World\'s largest shopping Community',
    ),
    PageViewModel(
      'assets/images/onBoard_2.jpg',
      'Shop from Alışveriş',
      'From games to gadgets, get any product from abroad, delivered by Alışveriş.',
    ),
    PageViewModel(
      'assets/images/onBoard_3.jpg',
      'Travel for less',
      'Make money every time you travel by delivering products to local along the way',
    ),
  ];

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value)
      {
        NavigateAnfFinish(context, ShopLogin());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:
        [
          TextButton(
              onPressed: submit,
              child: const Text('SKIP'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: onBoardingController,
                itemBuilder: (context, index) => onBoardingItemBuilder(context, onBoardingModel[index]),
                itemCount: onBoardingModel.length,
                onPageChanged: (int index)
                {
                  if(index == onBoardingModel.length-1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }
                  else
                  {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 70),
            Row(
              children: [
                SmoothPageIndicator(
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.black26,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4,
                      activeDotColor: mainColor,
                    ),
                    controller: onBoardingController,
                    count: onBoardingModel.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      submit();
                    }
                    else
                    {
                      onBoardingController.nextPage(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(IconAPP.arrowIcon),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
