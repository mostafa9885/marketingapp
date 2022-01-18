

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketingapp/LayOut%20Home/layout_home.dart';
import 'package:marketingapp/Network/End%20Point/end_point.dart';
import 'package:marketingapp/Network/Local/cache_helper.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Components/Toast%20Components/toast_components.dart';
import 'package:marketingapp/Shared/Components/components.dart';
import 'package:marketingapp/Shared/Cubit/Register%20Cubit/register%20states.dart';
import 'package:marketingapp/Shared/Cubit/Register%20Cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state)
        {
          if(state is RegisterSuccessState)
          {
            if(state.registerModel.status!)
            {
              CacheHelper.saveData(
                  key: 'token',
                  value: state.registerModel.data!.token,
              ).then((value){
                Token = state.registerModel.data!.token;
                NavigateAnfFinish(context, const LayOutHome());
              });
              toast(
                  message: state.registerModel.message!,
                  state: ToastState.SUCCESS,
                  context: context,
              );
            }
            else
            {
              toast(
                message: state.registerModel.message!,
                state: ToastState.ERROR,
                context: context,
              );
            }
          }
        },
        builder: (context, state)
        {

          var cubit = RegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: ColorApp.blackColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        D_TextFromField(
                            controller: nameController,
                            label: 'Name',
                            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                            prefixIcon: IconAPP.personIcon,
                            keyboardType: TextInputType.text,
                            validator: (value)
                            {
                              if(value!.isEmpty){return 'Enter You\'r Name';}
                            }
                        ),
                        const SizedBox(height: 15),
                        D_TextFromField(
                            controller: emailController,
                            label: 'Email Address',
                            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                            prefixIcon: IconAPP.emailIcon,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value)
                            {
                              if(value!.isEmpty){return 'Email Address not be Empty';}
                            }
                        ),
                        const SizedBox(height: 15),
                        D_TextFromField(
                            controller: passwordController,
                            label: 'Password',
                            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                            prefixIcon: IconAPP.lockIcon,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value)
                            {
                              if(value!.isEmpty){return 'Password is to Short';}
                            },
                            suffixIcon: cubit.suffix,
                            isobscureText: cubit.isVisibility,
                            suffixPressed: ()
                            {
                              cubit.changeVisibility();
                            }
                        ),
                        const SizedBox(height: 15),
                        D_TextFromField(
                            controller: phoneController,
                            label: 'Phone',
                            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                            prefixIcon: IconAPP.phoneIcon,
                            keyboardType: TextInputType.phone,
                            validator: (value)
                            {
                              if(value!.isEmpty){return 'Enter you\'r Phone';}
                            }
                        ),
                        const SizedBox(height: 20),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => D_MaterialButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  cubit.UserRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              isUpperCase: true,
                              text: 'register',
                              width: double.infinity,
                              backgroundColorButton: ColorApp.mainColor
                          ),
                          fallback: (context) =>  const Center(child: CircularProgressIndicator(),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
