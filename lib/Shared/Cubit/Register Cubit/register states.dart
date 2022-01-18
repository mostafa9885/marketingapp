

import 'package:marketingapp/Models/Login%20Model/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class ChangeVisibilityPassword extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates
{
  final ShopLoginModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates
{

  final String onError;

  RegisterErrorState(this.onError);

}