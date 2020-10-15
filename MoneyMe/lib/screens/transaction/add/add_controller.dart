import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/categories/components/tag_row_child.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddController {
  BuildContext context;
  // ignore: close_sinks
  TagBloc _tagBloc;
  AddController({this.context}) {
    _tagBloc = BlocProvider.of<TagBloc>(context);
  }

  final noteController = TextEditingController();
  final moneyController = TextEditingController();

  void toCategoriesScreen() {
    Navigator.pushNamed(context, '/categoriesScreen');
  }

  Widget titleBtn() {
    if (_tagBloc.state.selectedTag == null)
      return Text(
        'Chọn hạng mục',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      );
    return ListTile(
      onTap: toCategoriesScreen,
      contentPadding: EdgeInsets.only(right: 12),
      leading: Container(
        height: double.infinity,
        width: 30.0,
        child: Icon(
          MdiIcons.fromString(_tagBloc.state.selectedTag.icon.substring(4)),
          color: kPrimaryColor,
          size: 30.0,
        ),
      ),
      title: Text(
        title,
        style: kTitleTextStyle.copyWith(fontSize: 16.0),
      ),
    );
  }

  get title => titleBtn();
}
