

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketingapp/Models/Search%20Model/search_model.dart';
import 'package:marketingapp/Network/End%20Point/end_point.dart';
import 'package:marketingapp/Network/Remote/dio_helper.dart';
import 'package:marketingapp/Shared/Cubit/Search%20Cubit/search_states.dart';

class SearchCubit extends Cubit<SearchStates>
{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void Search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: Token,
        data:
        {
          'text': text,
        },
    ).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((onError)
    {
      print(onError.toString());
      emit(SearchErrorState(onError.toString()));
    });
  }

}