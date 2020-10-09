import 'package:MoneyMe/api/tag_api.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/models/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesController {
  BuildContext context;
  TagBloc _tagBloc;
  CategoriesController({this.context}) {
    _tagBloc = BlocProvider.of<TagBloc>(context);
  }

  get tagsList => _tagBloc.state.tagsList;
}
