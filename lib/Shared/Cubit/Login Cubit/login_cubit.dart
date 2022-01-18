

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketingapp/Models/Login%20Model/login_model.dart';
import 'package:marketingapp/Network/End%20Point/end_point.dart';
import 'package:marketingapp/Network/Remote/dio_helper.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Cubit/Login%20Cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isVisible = true;
  IconData suffixIcon = IconAPP.visibilityIcon;

  void changeVisibilityIcon ()
  {
    isVisible = !isVisible;
    suffixIcon = isVisible? IconAPP.visibilityIcon : IconAPP.visibilityOffIcon;
    emit(ChangeVisibleIconPasswordState());
  }


  ShopLoginModel? loginModel;

  void UserLogin ({
    required String email,
    required String password,
  })
  {

    emit(LoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email' : email,
          'password' : password
        },
    ).then((value)
    {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((onError)
    {
      print(onError.toString());
      emit(LoginErrorState(onError.toString()));
    });
  }

}