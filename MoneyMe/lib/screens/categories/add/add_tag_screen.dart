import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/icon.dart';
import 'package:MoneyMe/screens/categories/add/components/custom_dropdown.dart';
import 'package:MoneyMe/screens/categories/add/components/custom_toggle_button.dart';
import 'package:flutter/material.dart';

class AddTagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              onPress: () {},
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
                      onTap: () {},
                      controller: null,
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
                    child: CustomDropdown(
                      hintText: 'Hạng mục cha',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Icon(Icons.close),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
              child: CustomDropdown(
                hintText: 'Chọn hũ',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
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
