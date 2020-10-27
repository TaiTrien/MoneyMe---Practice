import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/icon.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddTagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.white),
        title: Text(
          'Thêm hạng mục',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPaddingHorizontal,
                vertical: kDefaultPaddingVertical,
              ),
              decoration: BoxDecoration(
                color: Colors.white54,
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: IconsList.icons.length ?? 0,
                itemBuilder: (context, index) {
                  return CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    child: Icon(
                      MdiIcons.fromString(
                        IconsList.icons[index].substring(4),
                      ),
                      color: Colors.white,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
