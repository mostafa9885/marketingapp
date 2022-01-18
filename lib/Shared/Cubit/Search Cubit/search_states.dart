
import 'package:marketingapp/Models/Search%20Model/search_model.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates
{
}

class SearchErrorState extends SearchStates
{
  final String onError;

  SearchErrorState(this.onError);
}