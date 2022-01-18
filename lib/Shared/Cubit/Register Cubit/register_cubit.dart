

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketingapp/Models/Login%20Model/login_model.dart';
import 'package:marketingapp/Network/End%20Point/end_point.dart';
import 'package:marketingapp/Network/Remote/dio_helper.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Cubit/Register%20Cubit/register%20states.dart';

class RegisterCubit extends Cubit<RegisterStates>
{

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isVisibility = true;
  IconData suffix = IconAPP.visibilityIcon;

  void changeVisibility()
  {
    isVisibility = !isVisibility;
    suffix = isVisibility? IconAPP.visibilityIcon : IconAPP.visibilityOffIcon;
    emit(ChangeVisibilityPassword());
  }

  ShopLoginModel? registerModel;

  void UserRegister({
    required String name,
    required String email,
    required dynamic password,
    required String phone,
})
  {

    emit(RegisterLoadingState());

    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name' : name,
          'email' : email,
          'password' : password,
          'phone' : phone,
        },
    ).then((value)
    {
      registerModel = ShopLoginModel.fromJson(value.data);
      print(value.data);
      emit(RegisterSuccessState(registerModel!));
    }).catchError((onError)
    {
      print(onError.toString());
      emit(RegisterErrorState(onError.toString()));
    });
  }
}