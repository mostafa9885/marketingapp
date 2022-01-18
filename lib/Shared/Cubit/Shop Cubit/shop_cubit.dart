

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketingapp/Models/Add%20or%20Delete%20Favorite%20Model/change_favorite_model.dart';
import 'package:marketingapp/Models/Categories%20Details%20Model/categories_details_model.dart';
import 'package:marketingapp/Models/Categories%20Model/categories_model.dart';
import 'package:marketingapp/Models/FAQS%20Model/faqs_model.dart';
import 'package:marketingapp/Models/Get%20Favorites%20Model/get_favorite_model.dart';
import 'package:marketingapp/Models/Home%20Model/home_model.dart';
import 'package:marketingapp/Models/Login%20Model/login_model.dart';
import 'package:marketingapp/Models/Products%20Details/product_details_model.dart';
import 'package:marketingapp/Moduels/Bottom%20Screen/Categories/categories_screen.dart';
import 'package:marketingapp/Moduels/Bottom%20Screen/Favorite/favorite_screen.dart';
import 'package:marketingapp/Moduels/Bottom%20Screen/Products/products_screen.dart';
import 'package:marketingapp/Moduels/Bottom%20Screen/Setting/settings_screen.dart';
import 'package:marketingapp/Network/End%20Point/end_point.dart';
import 'package:marketingapp/Network/Remote/dio_helper.dart';
import 'package:marketingapp/Shared/Components/components.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_states.dart';

class ShopCubit extends Cubit<ShopStates>
{

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<String> title =
  [
    'Alışveriş - Home',
    'Alışveriş - Categories',
    'Alışveriş - Favorite',
    'Alışveriş - Settings',
  ];

  var currentIndex = 0;

  List<Widget> screens = const
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void ChangeBottomScreen (int index)
  {
    currentIndex = index;
    emit(ChangeBottomNavigationBarIndex());
  }


  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData ()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: HOME,
        token: Token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element)
      {
        favorites.addAll({
          element.id! : element.inFavorites!,
        });
      });

      print(homeModel?.status);
      printFullText(homeModel.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategorisesDate()
  {
    DioHelper.getData(
        url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopErrorCategoriesState(onError.toString()));
    });
  }

  ProductDetailsModel? productDetailsModel;
  void getProductDetails(String id)
  {

    emit(ShopLoadingGetProductDetailsState());

    DioHelper.getData(
        url: 'products/$id',
        token: Token,
    ).then((value)
    {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(ShopSuccessGetProductDetailsState());
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopErrorGetProductDetailsState(onError.toString()));
    });
  }

  int pageValue = 0;
  void ChangeValueIndicator (int val)
  {
    pageValue = val;
    emit(ChangeIndicatorIndex());
  }

  FAQSModel? faqsModel;
  void getFAQSData ()
  {
    emit(ShopLoadingFAQSState());

    DioHelper.getData(
        url: FAQS,
    ).then((value) {
      faqsModel = FAQSModel.fromJson(value.data);
      emit(ShopSuccessFAQSState());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopErrorFAQSState(onError.toString()));
    });
  }

  CategoriesDetailModel? categoriesDetailModel;
  void getCategoriesDetailData(int categoryID)
  {
    emit(ShopLoadingGetProductsCategoriesState());

    DioHelper.getData(
        url: CATEGORIES_DETAILS,
        query:
        {
          'category_id':'${categoryID}',
        }
    ).then((value)
    {
      categoriesDetailModel = CategoriesDetailModel.fromJson(value.data);
      emit(ShopSuccessGetProductsCategoriesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetProductsCategoriesState(error.toString()));
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;
  void changeFavorites(int productId)
  {

    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoriteState());

    DioHelper.postData(
        url: FAVORITES,
        data:
        {
          'product_id' : productId,
        },
        token: Token,
    ).then((value)
    {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);

      if(!changeFavoriteModel!.status!)
      {
        favorites[productId] = !favorites[productId]!;
      }
      else
      {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoriteState(changeFavoriteModel!));
    }).catchError((onError)
    {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoriteState(onError));
    });
  }

  FavoriteModel? favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
        url: FAVORITES,
        token: Token,
    ).then((value)
    {
      favoritesModel = FavoriteModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


  ShopLoginModel? userModel;
  void getUserData()
  {

    emit(ShopLoadingUserDataState());

    DioHelper.getData(
        url: PROFILE,
        token: Token,
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopErrorUserDataState(onError.toString()));
    });
  }


  void updateUserData({
    String? name,
    String? email,
    String? phone,
})
  {
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: Token,
        data:
        {
          'name' : name,
          'email' : email,
          'phone' : phone,
        },
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopErrorUpdateUserDataState(onError.toString()));
    });
  }


}