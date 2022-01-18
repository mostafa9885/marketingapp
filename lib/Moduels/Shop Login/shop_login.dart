

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketingapp/LayOut%20Home/layout_home.dart';
import 'package:marketingapp/Moduels/Register/register_screen.dart';
import 'package:marketingapp/Network/End%20Point/end_point.dart';
import 'package:marketingapp/Network/Local/cache_helper.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Components/Toast%20Components/toast_components.dart';
import 'package:marketingapp/Shared/Components/components.dart';
import 'package:marketingapp/Shared/Cubit/Login%20Cubit/login_cubit.dart';
import 'package:marketingapp/Shared/Cubit/Login%20Cubit/login_states.dart';

class ShopLogin extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state)
      {
        if(state is LoginSuccessState)
        {
          if(state.loginModel.status!)
          {
            CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token
            ).then((value)
            {
              Token = state.loginModel.data!.token;
              NavigateAnfFinish(context, LayOutHome());

            });
          }
          else
          {
            toast(
              message: state.loginModel.message!,
              state: ToastState.ERROR,
              context: context,
            );
          }
        }
      },
      builder: (context, state)
      {

        var cubit = LoginCubit.get(context);

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
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: ColorApp.blackColor,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                          if(value!.isEmpty){return 'inCorrect Password';}
                        },
                        suffixIcon: cubit.suffixIcon,
                        suffixPressed: ()
                        {
                          cubit.changeVisibilityIcon();
                        },
                        isobscureText: cubit.isVisible,
                        onSubmitted: (value)
                        {
                          cubit.UserLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      ),
                      const SizedBox(height: 20),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) =>D_MaterialButton(
                            onPressed: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                cubit.UserLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            isUpperCase: true,
                            text: 'login',
                            width: double.infinity,
                            backgroundColorButton: ColorApp.mainColor
                        ),
                        fallback: (context) => const Center(child: CircularProgressIndicator(),),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          const Text(
                            'Don\'t have an Account?',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 10),
                          D_TextButton(
                              onPressed: ()
                              {
                                NavigatorTo(context, RegisterScreen());
                              },
                              text: 'Register Now!',
                              fontWeight: FontWeight.w800
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
