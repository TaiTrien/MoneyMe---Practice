import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/categories/add/components/custom_dropdown.dart';
import 'package:MoneyMe/screens/categories/edit/edit_tag_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditTagScreen extends StatefulWidget {
  @override
  _EditTagScreenState createState() => _EditTagScreenState();
}

class _EditTagScreenState extends State<EditTagScreen> {
  var controller;
  @override
  void initState() {
    super.initState();
    controller = new EditTagController(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          'Sửa hạng mục',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical + 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<TagBloc, TagState>(
                builder: (context, state) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
                    child: Text(
                      (state.selectedTag.type == '1') ? 'Khoản thu' : 'Khoản chi',
                      style: kTitleTextStyle.copyWith(fontSize: 20),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  FlatButton(
                    shape: CircleBorder(side: BorderSide.none),
                    color: kPrimaryColor,
                    onPressed: controller.toIconScreen,
                    child: Icon(
                      MdiIcons.fromString(controller.currentTag.icon.substring(4)),
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: kDefaultPaddingHorizontal),
                      child: TextField(
                        maxLines: 1,
                        controller: controller.tagController,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: kDefaultPaddingHorizontal, top: kDefaultPaddingVertical),
                      child: BlocBuilder<TagBloc, TagState>(
                        builder: (context, state) {
                          return CustomDropdown(
                            hintText: 'Hạng mục cha',
                            value: controller.parentTag,
                            items: (state.selectedTag.type == '1') ? controller.revenues : controller.expenses,
                            onChanged: controller.updateParentTag,
                          );
                        },
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => controller.updateParentTag(null),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              Visibility(
                visible: (controller.currentTag.type == '2') ? true : false,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPaddingHorizontal,
                    vertical: kDefaultPaddingVertical,
                  ),
                  child: BlocBuilder<JarBloc, JarState>(
                    builder: (context, state) {
                      return CustomDropdown(
                        hintText: 'Chọn hũ',
                        value: controller.currentJar,
                        items: state.jarsList,
                        onChanged: controller.updateCurrentJar,
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPaddingHorizontal,
                  vertical: kDefaultPaddingVertical,
                ),
                child: Text('Nếu bạn bỏ trống hạng mục cha thì mặc định hạng mục này sẽ là hạng mục cha.'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: controller.handleEditTag,
                  child: Text(
                    'Lưu lại',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
