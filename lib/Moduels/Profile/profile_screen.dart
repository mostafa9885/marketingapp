import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketingapp/Moduels/Shop%20Login/shop_login.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:marketingapp/Shared/Components/components.dart';
import 'package:marketingapp/Shared/Components/constant.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_cubit.dart';
import 'package:marketingapp/Shared/Cubit/Shop%20Cubit/shop_states.dart';

class ProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state)
      {

        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data!.name!;
        phoneController.text = model.data!.phone!;
        emailController.text = model.data!.email!;

        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
            condition: cubit.userModel != null,
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Profile'),
                titleSpacing: 1,
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children:
                      [
                        Row(
                          children:
                          [
                            Icon(IconAPP.accountCircleOutlined),
                            const SizedBox(width: 6),
                            Text(
                                '${model.data!.name}',
                                style: headline5(context)!.copyWith(color: ColorApp.blackColor, fontSize: 18,),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children:
                          [
                            Icon(IconAPP.alternateEmailOutlined),
                            const SizedBox(width: 6),
                            Text(
                              '${model.data!.email}',
                              style: headline5(context)!.copyWith(color: ColorApp.blackColor, fontSize: 18,),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  Container(
                    color: ColorApp.greyColor.withOpacity(0.2),
                    height: 13,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children:
                      [
                        SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Text(
                                'Personal Information'.toUpperCase(),
                                style: bodyText1(context).copyWith(
                                    color: ColorApp.blackColor,
                                    fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Spacer(),
                              TextButton.icon(
                                onPressed: ()
                                {
                                  cubit.
                                  updateUserData(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text
                                  );
                                },
                                icon: Icon(IconAPP.saveOutlined),
                                label: const Text('Save'),

                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        if(state is ShopLoadingUpdateUserDataState)
                          const LinearProgressIndicator(),
                        const SizedBox(height: 15),
                        D_TextFromField(
                            controller: nameController,
                            label: 'Name',
                            prefixIcon: IconAPP.accountCircleOutlined,
                            keyboardType: TextInputType.name,
                            validator: (value)
                            {
                              if(value!.isEmpty) return 'Name no\'t be Empty';
                            }
                        ),
                        const SizedBox(height: 20),
                        D_TextFromField(
                            controller: phoneController,
                            label: 'Phone',
                            prefixIcon: IconAPP.phoneIcon,
                            keyboardType: TextInputType.phone,
                            validator: (value)
                            {
                              if(value!.isEmpty) return 'Phone no\'t be Empty';
                            }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
