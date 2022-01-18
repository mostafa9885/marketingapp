

import 'package:marketingapp/Models/Login%20Model/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class ChangeVisibleIconPasswordState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates
{
  final ShopLoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates
{
  final String error;

  LoginErrorState(this.error);
}