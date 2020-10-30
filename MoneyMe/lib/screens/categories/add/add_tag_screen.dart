import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/categories/add/add_tag_controller.dart';
import 'package:MoneyMe/screens/categories/add/components/custom_dropdown.dart';
import 'package:MoneyMe/screens/categories/add/components/custom_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = new AddTagController(context: context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          'Thêm hạng mục',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical + 10),
        child: Column(
          children: [
            CustomToggle(
              onPress: controller.switchToggle,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3 - kDefaultPaddingHorizontal,
                  child: Text(
                    'Khoản thu',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
                  width: MediaQuery.of(context).size.width / 3 - kDefaultPaddingHorizontal,
                  child: Text(
                    'Khoản chi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                FlatButton(
                  shape: CircleBorder(side: BorderSide.none),
                  color: kPrimaryColor,
                  onPressed: () {},
                  child: Icon(
                    Icons.ac_unit,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: kDefaultPaddingHorizontal),
                    child: TextField(
                      onChanged: controller.onChanged,
                      onTap: () {},
                      controller: controller.tagController,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: 'Tên hạng mục',
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
                  onPressed: () {},
                  child: Icon(Icons.close),
                ),
              ],
            ),
            BlocBuilder<TagBloc, TagState>(
              builder: (context, state) {
                return Visibility(
                  visible: (state.selectedTag.type == '2') ? true : false,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPaddingHorizontal,
                      vertical: kDefaultPaddingVertical,
                    ),
                    child: BlocBuilder<JarBloc, JarState>(
                      builder: (context, state) {
                        return CustomDropdown(
                          hintText: 'Chọn hũ',
                          items: state.jarsList,
                          onChanged: (value) {},
                        );
                      },
                    ),
                  ),
                );
              },
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
                onPressed: () {},
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
    );
  }
}

// Wrap(
//             spacing: 10,
//             runSpacing: kDefaultPaddingVertical,
//             children: IconsList.icons
//                 .map((icon) => GestureDetector(
//                     onTap: () {},
//                     child: CircleAvatar(
//                         backgroundColor: kPrimaryColor,
//                         child: Icon(
//                           MdiIcons.fromString(icon.substring(4)),
//                           color: Colors.white,
//                         ))))
//                 .toList(),
//           ),
